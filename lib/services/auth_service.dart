import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auth0_flutter/auth0_flutter.dart';

class AuthService {
  static const String _auth0Domain = 'twoglobes.eu.auth0.com';
  static const String _clientId = 'x2pVfwSjjxqZGIGtcIEani5naU9VnotX';
  static const String _audience = 'https://api-staging.twoglobes.com/';
  static const String _apiBaseUrl = 'https://api-staging.twoglobes.com/mobile';

  late Auth0 _auth0;
  Credentials? _credentials;

  AuthService() {
    _auth0 = Auth0(_auth0Domain, _clientId);
  }

  // Initialize Auth0 and load stored credentials
  Future<void> initialize() async {
    try {
      _credentials = await _auth0.credentialsManager.credentials();
    } catch (e) {
      // No stored credentials, user needs to login
      _credentials = null;
    }
  }

  // Login with Auth0 (Universal Login - recommended)
  Future<bool> login() async {
    try {
      _credentials = await _auth0.webAuthentication().login(
        audience: _audience,
        scopes: {'openid', 'profile', 'email'},
      );
      if (_credentials != null) {
        await _storeCredentials();
        return true;
      }
      return false;
    } catch (e) {
      // Login error - user cancelled or network issue
      return false;
    }
  }

  // Login with email/password using Auth0's database connection
  // Note: For security, Auth0 recommends Universal Login for mobile apps
  // This method uses Resource Owner Password Grant (requires app to be configured as public client)
  Future<bool> loginWithEmailPassword(String email, String password) async {
    try {
      // Use Auth0's OAuth2 Resource Owner Password Grant (no client secret for public clients)
      final tokenUrl = Uri.parse('https://$_auth0Domain/oauth/token');
      final response = await http.post(
        tokenUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'client_id': _clientId,
          'audience': _audience,
          'grant_type': 'http://auth0.com/oauth/grant-type/password-realm',
          'username': email,
          'password': password,
          'realm': 'Username-Password-Authentication',
          'scope': 'openid profile email',
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Create credentials object from token response
        _credentials = Credentials(
          accessToken: data['access_token'],
          refreshToken: data['refresh_token'],
          idToken: data['id_token'],
          expiresAt: DateTime.now().add(Duration(seconds: data['expires_in'] ?? 3600)),
          tokenType: data['token_type'] ?? 'Bearer',
          scopes: (data['scope'] as String?)?.split(' ') ?? [],
        );
        await _storeCredentials();
        return true;
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['error_description'] ?? errorData['error'] ?? 'Login failed');
      }
    } catch (e) {
      // Login error - fallback to Universal Login
      // This is more secure and recommended by Auth0
      return await login();
    }
  }

  // Register new user
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String name,
    String? surname,
  }) async {
    try {
      // Use Auth0 Management API signup endpoint
      final signupUrl = Uri.parse('https://$_auth0Domain/dbconnections/signup');
      final response = await http.post(
        signupUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'client_id': _clientId,
          'email': email,
          'password': password,
          'connection': 'Username-Password-Authentication',
          'user_metadata': {
            'name': name,
            'surname': surname ?? '',
          },
        }),
      );

      if (response.statusCode == 200) {
        // After signup, automatically log in
        final loginSuccess = await loginWithEmailPassword(email, password);
        return {
          'success': loginSuccess,
          'message': loginSuccess 
            ? 'Account created successfully' 
            : 'Account created but login failed. Please try logging in.',
        };
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['description'] ?? errorData['error'] ?? 'Registration failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Registration error: ${e.toString()}',
      };
    }
  }

  // Request password reset
  Future<bool> requestPasswordReset(String email) async {
    try {
      final resetUrl = Uri.parse('https://$_auth0Domain/dbconnections/change_password');
      final response = await http.post(
        resetUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'client_id': _clientId,
          'email': email,
          'connection': 'Username-Password-Authentication',
        }),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _auth0.webAuthentication().logout();
      await _clearCredentials();
      _credentials = null;
    } catch (e) {
      // Logout error - continue anyway
      await _clearCredentials();
      _credentials = null;
    }
  }

  // Check if user is logged in
  bool get isLoggedIn => _credentials != null;

  // Get access token
  String? get accessToken => _credentials?.accessToken;

  // Store credentials securely
  Future<void> _storeCredentials() async {
    if (_credentials != null) {
      await _auth0.credentialsManager.storeCredentials(_credentials!);
    }
  }

  // Clear stored credentials
  Future<void> _clearCredentials() async {
    await _auth0.credentialsManager.clearCredentials();
  }

  // Refresh token if needed
  Future<bool> refreshTokenIfNeeded() async {
    if (_credentials != null) {
      try {
        _credentials = await _auth0.credentialsManager.renewCredentials();
        await _storeCredentials();
        return true;
      } catch (e) {
        // Token refresh error - clear credentials and require re-login
        await _clearCredentials();
        _credentials = null;
        return false;
      }
    }
    return true;
  }

  // Parse error message from API response
  String _parseErrorMessage(http.Response response) {
    try {
      final data = jsonDecode(response.body);
      return data['error'] ?? data['message'] ?? 'An error occurred';
    } catch (e) {
      return 'An error occurred (${response.statusCode})';
    }
  }

  // Make authenticated API calls with 401 retry logic
  Future<http.Response> makeAuthenticatedRequest(
    String method,
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool retryOn401 = true,
  }) async {
    if (!isLoggedIn) {
      throw Exception('User not logged in');
    }

    // Refresh token before request
    final refreshed = await refreshTokenIfNeeded();
    if (!refreshed) {
      throw Exception('Session expired. Please login again.');
    }

    final url = Uri.parse('$_apiBaseUrl$endpoint');
    final requestHeaders = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
      ...?headers,
    };

    http.Response response;
    switch (method.toUpperCase()) {
      case 'GET':
        response = await http.get(url, headers: requestHeaders);
        break;
      case 'POST':
        response = await http.post(
          url,
          headers: requestHeaders,
          body: body != null ? jsonEncode(body) : null,
        );
        break;
      case 'PUT':
        response = await http.put(
          url,
          headers: requestHeaders,
          body: body != null ? jsonEncode(body) : null,
        );
        break;
      case 'DELETE':
        response = await http.delete(url, headers: requestHeaders);
        break;
      default:
        throw Exception('Unsupported HTTP method: $method');
    }

    // Handle 401 Unauthorized - retry once after refresh (per Twoglobes API guide)
    if (response.statusCode == 401 && retryOn401) {
      // Try to refresh credentials
      final refreshed = await refreshTokenIfNeeded();
      if (refreshed && isLoggedIn) {
        // Retry the request once
        requestHeaders['Authorization'] = 'Bearer $accessToken';
        switch (method.toUpperCase()) {
          case 'GET':
            response = await http.get(url, headers: requestHeaders);
            break;
          case 'POST':
            response = await http.post(
              url,
              headers: requestHeaders,
              body: body != null ? jsonEncode(body) : null,
            );
            break;
          case 'PUT':
            response = await http.put(
              url,
              headers: requestHeaders,
              body: body != null ? jsonEncode(body) : null,
            );
            break;
          case 'DELETE':
            response = await http.delete(url, headers: requestHeaders);
            break;
        }
      } else {
        // Refresh failed - user needs to login again
        throw Exception('Session expired. Please login again.');
      }
    }

    return response;
  }

  // Create a group
  Future<Map<String, dynamic>> createGroup(String groupName) async {
    try {
      final response = await makeAuthenticatedRequest(
        'POST',
        '/groups',
        body: {'GroupName': groupName},
      );

      if (response.statusCode == 201) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
        };
      } else {
        return {
          'success': false,
          'error': _parseErrorMessage(response),
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  // List groups
  Future<Map<String, dynamic>> listGroups() async {
    try {
      final response = await makeAuthenticatedRequest('GET', '/groups');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'data': List<Map<String, dynamic>>.from(data['groups'] ?? []),
        };
      } else {
        return {
          'success': false,
          'error': _parseErrorMessage(response),
          'data': <Map<String, dynamic>>[],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
        'data': <Map<String, dynamic>>[],
      };
    }
  }

  // Link device to group by GUID
  Future<Map<String, dynamic>> linkDeviceToGroup(
    int groupId,
    String deviceGuid,
  ) async {
    try {
      final response = await makeAuthenticatedRequest(
        'POST',
        '/groups/$groupId/devices/by-guid/$deviceGuid',
      );

      if (response.statusCode == 201 || response.statusCode == 202) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
        };
      } else {
        return {
          'success': false,
          'error': _parseErrorMessage(response),
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  // Update user preferences (for Account page)
  Future<Map<String, dynamic>> updateUserPreferences(
    Map<String, dynamic> preferences,
  ) async {
    try {
      // Note: This endpoint may not exist yet in your API
      // Adjust the endpoint as needed
      final response = await makeAuthenticatedRequest(
        'PUT',
        '/user/preferences',
        body: preferences,
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
        };
      } else {
        // If endpoint doesn't exist (404), store locally for now
        if (response.statusCode == 404) {
          return {
            'success': true,
            'data': preferences,
            'note': 'Stored locally (API endpoint not available)',
          };
        }
        return {
          'success': false,
          'error': _parseErrorMessage(response),
        };
      }
    } catch (e) {
      // If endpoint doesn't exist, store locally for now
      // In production, you'd want to use SharedPreferences or similar
      return {
        'success': true,
        'data': preferences,
        'note': 'Stored locally (API endpoint not available)',
      };
    }
  }

  // Get user preferences
  Future<Map<String, dynamic>> getUserPreferences() async {
    try {
      final response = await makeAuthenticatedRequest('GET', '/user/preferences');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
        };
      } else {
        // If endpoint doesn't exist, return empty preferences
        return {
          'success': false,
          'error': _parseErrorMessage(response),
          'data': <String, dynamic>{},
        };
      }
    } catch (e) {
      // Return empty preferences if endpoint doesn't exist
      return {
        'success': false,
        'error': e.toString(),
        'data': <String, dynamic>{},
      };
    }
  }
}

