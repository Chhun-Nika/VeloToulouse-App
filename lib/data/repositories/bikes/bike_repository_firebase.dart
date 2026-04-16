import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:velo_toulouse_app/data/config/firebase_config.dart';
import 'package:velo_toulouse_app/data/dto/bike_dto.dart';
import 'package:velo_toulouse_app/data/repositories/bikes/bike_repository.dart';
import 'package:velo_toulouse_app/model/bike.dart';

class BikeRepositoryFirebase implements BikeRepository {
  static const String _bikesPath = '/bikes';

  @override
  Future<List<Bike>> getBikesByStation(String stationId) async {
    final Uri bikeUri = FirebaseConfig.baseUri.replace(
      path: '$_bikesPath.json',
    );
    final http.Response response = await http.get(bikeUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of bikes
      final decodedBody = json.decode(response.body);
      if (decodedBody == null) {
        return [];
      }

      if (decodedBody is! Map<String, dynamic>) {
        throw FormatException('Expected bikes data to be a map.');
      }

      Map<String, dynamic> bikesJson = decodedBody;
      List<Bike> result = [];

      for (var bikeEntry in bikesJson.entries) {
        final bikeJson = bikeEntry.value;
        if (bikeJson is! Map) {
          continue;
        }

        Bike bike = BikeDto.fromJson(
          bikeEntry.key,
          Map<String, dynamic>.from(bikeJson),
        );

        // filter by stationId
        if (bike.stationId == stationId) {
          result.add(bike);
        }
      }

      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load bike');
    }
  }

  @override
  Future<void> markBikeAsBooked(String bikeId) async {
    final Uri bikeUri = FirebaseConfig.baseUri.replace(
      path: '$_bikesPath/$bikeId.json',
    );

    await http.patch(bikeUri, body: json.encode({'status': 'booked'}));
  }
}
