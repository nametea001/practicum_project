import 'dart:convert';

// import 'package:packing/models/user.dart';
import 'package:smart_garage_app/services/networking.dart';

class Garage {
  final int? id;
  final String? name;
  final int? userId;
  final String? status;
  final String? dateTime;

  Garage({
    this.id,
    this.name,
    this.userId,
    this.status,
    this.dateTime,
  });

  static Future<List<Garage>?> getGarageFromUserId(int userId) async {
    NetworkHelper networkHelper = NetworkHelper('/api/garage/', {
      'user_id': userId.toString(),
    });
    List<Garage> garages = [];
    var json = await networkHelper.getData();
    if (json != null && json['error'] == false) {
      for (Map g in json['garages']) {
        Garage garage = Garage(
          id: int.parse(g['id']),
          name: g['name'],
          userId: int.parse(g['user_id']),
          status: g['status'],
          dateTime: g['parking_date'],
        );
        garages.add(garage);
      }
      return garages;
    }
    return null;
  }
}