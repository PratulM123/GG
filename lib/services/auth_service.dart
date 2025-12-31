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

  /// Initialize & load existing stored credentials
  Future<void> initialize() async {
    try {
      _credentials = await _auth0.credentialsManager.credentials();
    } catch (_) {
      _credentials = null;
    }
  }

  /// Universal Login (recommended)
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
    } catch (_) {
      return false;
    }
  }

  /// Email + password login (ROPG)
  Future<bool> loginWithEmailPassword(String email, String password) async {
    try {
      final url = Uri.parse('https://$_auth0Domain/oauth/token');

      final response = await http.post(
        url,
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

        // Credentials() now REQUIRES user
        _credentials = Credentials(
          user: const UserProfile(sub: ''),
          accessToken: data['access_token'],
          refreshToken: data['refresh_token'],
          idToken: data['id_token'],
          expiresAt: DateTime.now()
              .add(Duration(seconds: data['expires_in'] ?? 3600)),
          tokenType: data['token_type'] ?? 'Bearer',
          scopes: (() {
            final raw = data['scope'];

            if (raw == null) return <String>{};

            if (raw is String) {
              return raw.split(' ').map((e) => e.toString()).toSet();
            }

            if (raw is List) {
              return raw.map((e) => e.toString()).toSet();
            }

            return <String>{};
          })(),
        );


        await _storeCredentials();
        return true;
      }

      return false;
    } catch (_) {
      return await login(); // fallback to universal login
    }
  }

  /// Register new user
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String name,
    String? surname,
  }) async {
    try {
      final signupUrl =
      Uri.parse('https://$_auth0Domain/dbconnections/signup');

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
        final success = await loginWithEmailPassword(email, password);
        return {
          'success': success,
          'message': success
              ? 'Account created successfully'
              : 'Account created but login failed',
        };
      }

      return {
        'success': false,
        'message': 'Registration failed',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Registration error: $e',
      };
    }
  }

  // ---------------- USER PREFERENCES -----------------

// Update user preferences
  Future<Map<String, dynamic>> updateUserPreferences(
      Map<String, dynamic> preferences,
      ) async {
    try {
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

// Get user preferences
  Future<Map<String, dynamic>> getUserPreferences() async {
    try {
      final response = await makeAuthenticatedRequest(
        'GET',
        '/user/preferences',
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
        };
      } else {
        return {
          'success': false,
          'error': _parseErrorMessage(response),
          'data': <String, dynamic>{},
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
        'data': <String, dynamic>{},
      };
    }
  }


  /// Password reset
  Future<bool> requestPasswordReset(String email) async {
    try {
      final url =
      Uri.parse('https://$_auth0Domain/dbconnections/change_password');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'client_id': _clientId,
          'email': email,
          'connection': 'Username-Password-Authentication',
        }),
      );

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      await _auth0.webAuthentication().logout();
    } finally {
      await _clearCredentials();
      _credentials = null;
    }
  }

  /// Logged-in status
  bool get isLoggedIn => _credentials != null;

  /// Current user profile (nullable)
  UserProfile? get user => _credentials?.user;

  /// Access token getter
  String? get accessToken => _credentials?.accessToken;

  /// Save credentials securely
  Future<void> _storeCredentials() async {
    if (_credentials != null) {
      await _auth0.credentialsManager.storeCredentials(_credentials!);
    }
  }

  /// Clear stored creds
  Future<void> _clearCredentials() async {
    await _auth0.credentialsManager.clearCredentials();
  }

  /// Refresh if expired (new API)
  Future<bool> refreshTokenIfNeeded() async {
    try {
      _credentials = await _auth0.credentialsManager.credentials();
      await _storeCredentials();
      return true;
    } catch (_) {
      await _clearCredentials();
      _credentials = null;
      return false;
    }
  }

  //----------------------------------------------------
  // --------- BELOW: API CALL HELPERS -----------------
  //----------------------------------------------------

  String _parseErrorMessage(http.Response r) {
    try {
      final d = jsonDecode(r.body);
      return d['error'] ?? d['message'] ?? 'Error';
    } catch (_) {
      return 'HTTP ${r.statusCode}';
    }
  }

  Future<http.Response> makeAuthenticatedRequest(
      String method,
      String endpoint, {
        Map<String, dynamic>? body,
        Map<String, String>? headers,
        bool retryOn401 = true,
      }) async {
    if (!isLoggedIn) throw Exception('Not logged in');

    final refreshed = await refreshTokenIfNeeded();
    if (!refreshed) throw Exception('Session expired');

    final url = Uri.parse('$_apiBaseUrl$endpoint');

    final h = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
      ...?headers,
    };

    http.Response r;

    switch (method.toUpperCase()) {
      case 'GET':
        r = await http.get(url, headers: h);
        break;
      case 'POST':
        r = await http.post(url, headers: h, body: jsonEncode(body));
        break;
      case 'PUT':
        r = await http.put(url, headers: h, body: jsonEncode(body));
        break;
      case 'DELETE':
        r = await http.delete(url, headers: h);
        break;
      default:
        throw Exception('Unsupported method');
    }

    if (r.statusCode == 401 && retryOn401) {
      final ok = await refreshTokenIfNeeded();
      if (!ok) throw Exception('Session expired');

      h['Authorization'] = 'Bearer $accessToken';

      return makeAuthenticatedRequest(
        method,
        endpoint,
        body: body,
        headers: headers,
        retryOn401: false,
      );
    }

    return r;
  }

  /// Group APIs ---------------------------------------

  Future<Map<String, dynamic>> createGroup(String name) async {
    try {
      final r = await makeAuthenticatedRequest(
        'POST',
        '/groups',
        body: {'GroupName': name},
      );

      if (r.statusCode == 201) {
        return {'success': true, 'data': jsonDecode(r.body)};
      }

      return {'success': false, 'error': _parseErrorMessage(r)};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> listGroups() async {
    try {
      final r = await makeAuthenticatedRequest('GET', '/groups');

      if (r.statusCode == 200) {
        final data = jsonDecode(r.body);
        return {
          'success': true,
          'data': List<Map<String, dynamic>>.from(data['groups'] ?? []),
        };
      }

      return {'success': false, 'error': _parseErrorMessage(r)};
    } catch (e) {
      return {'success': false, 'error': e.toString(), 'data': []};
    }
  }

  Future<Map<String, dynamic>> linkDeviceToGroup(
      int groupId,
      String guid,
      ) async {
    try {
      final r = await makeAuthenticatedRequest(
        'POST',
        '/groups/$groupId/devices/by-guid/$guid',
      );

      if (r.statusCode == 201 || r.statusCode == 202) {
        return {'success': true, 'data': jsonDecode(r.body)};
      }

      return {'success': false, 'error': _parseErrorMessage(r)};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }
}
