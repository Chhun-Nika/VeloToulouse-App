import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../model/station.dart';
import '../../config/firebase_config.dart';
import '../../dto/station_dto.dart';
import 'station_repository.dart';

class StationRepositoryFirebase implements StationRepository {
  @override
  Future<List<Station>> getAllStations() async {
    final Uri stationsUri = FirebaseConfig.baseUri.replace(path: '/stations.json');
    final http.Response response = await http.get(stationsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of stations
      Map<String, dynamic> stationsJson = json.decode(response.body);
      List<Station> result = [];

      for (var stationEntry in stationsJson.entries) {
        result.add(StationDto.fromJson(stationEntry.key ,stationEntry.value));
      }

      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }
}