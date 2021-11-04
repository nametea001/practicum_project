import 'dart:convert';

import 'package:packing/services/networking.dart';

class User {
  final int? userID;
  final String? username;
  User({
    this.userID,
    this.username,
  });

  static Future<User?> checkLogin(String username, String password) async {
    NetworkHelper networkHelper = NetworkHelper('/api/login', {});
    var json = await networkHelper.postData(jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }));
    if (json != null && json['error'] == false) {
      Map u = json['user'];
      User user = User(
        userID: int.parse(u["id"]),
        username: u["username"],
      );
      return user;
    }
    return null;
  }

  static Future<User?> checkOpenGarage(int userId, String password) async {
    NetworkHelper networkHelper = NetworkHelper('/api/check_open_garage', {});
    var json = await networkHelper.postData(jsonEncode(<String, String>{
      'user_id': userId.toString(),
      'password': password,
    }));

    if (json != null && json['error'] == false) {
      Map u = json['user'];
      User user = User(
        userID: int.parse(u["id"]),
        username: u["username"],
      );
      return user;
    }

    return null;
  }
}
