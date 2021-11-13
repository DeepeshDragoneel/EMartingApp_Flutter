import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token = '';
  // DateTime _expiryDate;
  String _userName = '';
  String _errorData = '';
  String _verificationData = '';
  String _userId = '';

  String get errorData => _errorData;
  String get verificationData => _verificationData;
  String get token => _token;
  String get userName => _userName;
  String get userId => _userId;

  Future<bool> get isAuthenticated async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final localUserData = json.decode(prefs.getString('userData') as String);

    final body = {
      'token': localUserData['token'],
    };
    // print(body['token']);
    final uri = Uri.https('emarting-backend-api.herokuapp.com', '/auth');
    final result = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: json.encode(body));
    print(json.decode(result.body)['_id']);
    return result.body == 'ERROR' ? false : true;
  }

  Future<Map<String, Object>> getUerData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return {};
    }
    final localUserData = json.decode(prefs.getString('userData') as String);

    final body = {
      'token': localUserData['token'],
    };
    // print(body['token']);
    final uri = Uri.https('emarting-backend-api.herokuapp.com', '/auth');
    final result = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: json.encode(body));
    // print(result.body);
    return json.decode(result.body);
  }

  void changeErrorAndVerifyMsg() {
    _errorData = '';
    _verificationData = '';
    notifyListeners();
  }

  Future<void> signUp(String email, String username, String password) async {
    try {
      final body = {
        'data': {
          'email': email,
          'username': username,
          'pass': password,
        }
      };
      print(json.encode(body));
      final uri =
          Uri.https('emarting-backend-api.herokuapp.com', '/auth/signUp');
      final result = await http.post(uri,
          headers: {"Content-Type": "application/json"},
          body: json.encode(body));
      print('printing result');
      print(result.body);
      if (result.body == "res Username is already taken") {
        _errorData = ('Username is Taken!');
        _verificationData = ('');
      } else if (result.body == "res email is already taken") {
        _errorData = ('Email already Exists!');
        _verificationData = ("");
      } else {
        _errorData = ('');
        _verificationData =
            ('Please Verify Your EMail using the verification link sent to your mail!');
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> logIn(String email, String pass) async {
    try {
      final body = {
        'data': {
          'email': email,
          'pass': pass,
        }
      };
      final uri =
          Uri.https('emarting-backend-api.herokuapp.com', '/auth/login');
      final result = await http.post(uri,
          headers: {"Content-Type": "application/json"},
          body: json.encode(body));
      if (json.decode(result.body)['code'] == 'ERROR') {
        print(json.decode(result.body)['code']);
        _errorData = 'INVALID CREDENTIALS!';
        notifyListeners();
      } else if (json.decode(result.body)['code'] == 'SUCCESS') {
        _token = (json.decode(result.body)['token']);
        _userName = (json.decode(result.body)['username']);
        _errorData = '';
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode({'token': _token, 'username': _userName});
        prefs.setString('userData', userData);
        final body = {
          'token': _token,
        };
        // print(body['token']);
        final uri = Uri.https('emarting-backend-api.herokuapp.com', '/auth');
        final res = await http.post(uri,
            headers: {"Content-Type": "application/json"},
            body: json.encode(body));
        _userId = (json.decode(res.body)['_id']);
        // print(_token);
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> logout() async {
    _token = '';
    _userName = '';
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    notifyListeners();
  }
}
