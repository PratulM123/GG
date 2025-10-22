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
  
  // Initialize Auth0
  Future<void> initialize() async {
    try {
      _credentials = await _auth0.credentialsManager.credentials();
    } catch (e) {
      // No stored credentials, user needs to login
      _credentials = null;
    }
  }
  
  // Login with Auth0
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
  
  // Logout
  Future<void> logout() async {
    try {
      await _auth0.webAuthentication().logout();
      await _clearCredentials();
      _credentials = null;
    } catch (e) {
      // Logout error - continue anyway
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
        // Token refresh error - user needs to login again
        return false;
      }
    }
    return true;
  }
  
  // Make authenticated API calls
  Future<http.Response> makeAuthenticatedRequest(
    String method,
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    if (!isLoggedIn) {
      throw Exception('User not logged in');
    }
    
    // Refresh token if needed
    await refreshTokenIfNeeded();
    
    final url = Uri.parse('$_apiBaseUrl$endpoint');
    final requestHeaders = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
      ...?headers,
    };
    
    switch (method.toUpperCase()) {
      case 'GET':
        return await http.get(url, headers: requestHeaders);
      case 'POST':
        return await http.post(
          url,
          headers: requestHeaders,
          body: body != null ? jsonEncode(body) : null,
        );
      case 'PUT':
        return await http.put(
          url,
          headers: requestHeaders,
          body: body != null ? jsonEncode(body) : null,
        );
      case 'DELETE':
        return await http.delete(url, headers: requestHeaders);
      default:
        throw Exception('Unsupported HTTP method: $method');
    }
  }
  
  // Create a group
  Future<Map<String, dynamic>?> createGroup(String groupName) async {
    try {
      final response = await makeAuthenticatedRequest(
        'POST',
        '/groups',
        body: {'GroupName': groupName},
      );
      
      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        print('Create group error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Create group exception: $e');
      return null;
    }
  }
  
  // List groups
  Future<List<Map<String, dynamic>>?> listGroups() async {
    try {
      final response = await makeAuthenticatedRequest('GET', '/groups');
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['groups']);
      } else {
        print('List groups error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('List groups exception: $e');
      return null;
    }
  }
  
  // Link device to group by GUID
  Future<Map<String, dynamic>?> linkDeviceToGroup(
    int groupId,
    String deviceGuid,
  ) async {
    try {
      final response = await makeAuthenticatedRequest(
        'POST',
        '/groups/$groupId/devices/by-guid/$deviceGuid',
      );
      
      if (response.statusCode == 201 || response.statusCode == 202) {
        return jsonDecode(response.body);
      } else {
        print('Link device error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Link device exception: $e');
      return null;
    }
  }
}