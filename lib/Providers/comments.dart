import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class Comment with ChangeNotifier {
  final String id;
  final String userId;
  final String userName;
  final String googleUserId;
  final num rating;
  final String heading;
  final String desc;
  final String productId;
  final DateTime updatedAt;

  Comment({
    required this.id,
    required this.userId,
    required this.googleUserId,
    // required this.googleUserName,
    required this.userName,
    required this.rating,
    required this.heading,
    required this.desc,
    required this.productId,
    required this.updatedAt,
  });
}

class Comments with ChangeNotifier {
  List<Comment> _comments = [];
  int _remainingComments = 1;
  int _pageNumber = 0;
  int get remainingComments => _remainingComments;
  int get pageNumber => _pageNumber;
  List<Comment> get comments => _comments;

  void setRemainingComments() {
    _remainingComments = 1;
    // notifyListeners();
  }

  void setPageNumber() {
    _pageNumber = 0;
    // notifyListeners();
  }

  Future<void> getAndSetComments(String id) async {
    try {
      print('yo from get! ${_remainingComments}');
      if (_remainingComments <= 0) {
        return;
      }
      _pageNumber = _pageNumber + 1;
      final queryParameters = {
        'pageNumber': _pageNumber.toString(),
        'productId': id,
      };
      final url =
          Uri.http(FlutterConfig.get('REST_URL'), '/review', queryParameters);
      final result = await http.get(url);
      _remainingComments = json.decode(result.body)['count'];
      var productReviews = json.decode(result.body)['review'];
      // print(productReviews);
      _comments = [];
      var _newComments = [];
      productReviews.forEach((item) => _comments.add(Comment(
            id: item['_id'],
            userId: item['userId'] != null ? item['userId']['_id'] : '',
            userName: item['userId'] == null
                ? item['googleUserId']['username']
                : item['userId']['username'],
            googleUserId:
                item['googleUserId'] != null ? item['googleUserId']['_id'] : '',
            // googleUserName: item['googleUserId'].username,
            rating: item['rating'],
            heading: item['heading'],
            desc: item['desc'],
            productId: item['productId'],
            updatedAt: DateTime.parse(item['updatedAt']),
          )));
      // productReviews
      //     .forEach((item) => print('${item['googleUserId']['username']}'));
      print(_comments[0].heading);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
