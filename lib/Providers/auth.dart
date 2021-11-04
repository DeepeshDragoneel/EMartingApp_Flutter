import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'dart:convert';

class Auth with ChangeNotifier {
  // String _token;
  // DateTime _expiryDate;
  // String _userId;
  String _errorData = '';
  String _verificationData = '';

  String get errorData => _errorData;
  String get verificationData => _verificationData;

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
        _errorData = ("Username Taken!");
        _verificationData = ("");
      } else if (result.body == "res email is already taken") {
        _errorData = ("Email Taken!");
        _verificationData = ("");
      } else {
        _errorData = ("");
        _verificationData =
            ("Please Verify Your EMail using the invitation link sent to your mail!");
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
