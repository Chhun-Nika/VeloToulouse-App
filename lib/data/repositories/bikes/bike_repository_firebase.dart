import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../model/bike.dart';
import '../../config/firebase_config.dart';
import '../../dto/bike_dto.dart';
import 'bike_repository.dart';

class BikeRepositoryFirebase implements BikeRepository {
  @override
  Future<Bike?> getBikeById(String stationId, String bikeId) async {
    final Uri bikeUri = FirebaseConfig.baseUri.replace(
      path: '/bikes/$bikeId.json',
    );
    final http.Response response = await http.get(bikeUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved bike
      if (response.body == 'null') {
        return null;
      }

      Map<String, dynamic> bikeJson = json.decode(response.body);
      Bike bike = BikeDto.fromJson(bikeId, bikeJson);

      if (bike.stationId != stationId) {
        return null;
      }

      return bike;
    } else {
      // 2- Throw exception if any issue
      throw Exception('Failed to load bike');
    }
  }

  @override
  Future<List<Bike>> getBikesByStation(String stationId) async {
    final Uri bikesUri = FirebaseConfig.baseUri.replace(
      path: '/bikes.json',
    );
    final http.Response response = await http.get(bikesUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of bikes by station
      if (response.body == 'null') {
        return [];
      }

      Map<String, dynamic> bikesJson = json.decode(response.body);
      List<Bike> result = [];

      for (var bikeEntry in bikesJson.entries) {
        Bike bike = BikeDto.fromJson(bikeEntry.key, bikeEntry.value);

        if (bike.stationId == stationId) {
          result.add(bike);
        }
      }

      return result;
    } else {
      // 2- Throw exception if any issue
      throw Exception('Failed to load bikes');
    }
  }
}
