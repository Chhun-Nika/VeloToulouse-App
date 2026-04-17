import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../model/slot.dart';
import '../../config/firebase_config.dart';
import '../../dto/slot_dto.dart';
import 'slot_repository.dart';

class SlotRepositoryFirebase implements SlotRepository {
  @override
  Future<Slot?> getSlotById(String stationId, String slotId) async {
    final Uri slotUri = FirebaseConfig.baseUri.replace(
      path: '/slots/$slotId.json',
    );
    final http.Response response = await http.get(slotUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved slot
      if (response.body == 'null') {
        return null;
      }

      Map<String, dynamic> slotJson = json.decode(response.body);
      Slot slot = SlotDto.fromJson(slotId, slotJson);

      if (slot.stationId != stationId) {
        return null;
      }

      return slot;
    } else {
      // 2- Throw exception if any issue
      throw Exception('Failed to load slot');
    }
  }

  @override
  Future<List<Slot>> getSlotsByStation(String stationId) async {
    final Uri slotsUri = FirebaseConfig.baseUri.replace(
      path: '/slots.json',
    );
    final http.Response response = await http.get(slotsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of slots by station
      if (response.body == 'null') {
        return [];
      }

      Map<String, dynamic> slotsJson = json.decode(response.body);
      List<Slot> result = [];

      for (var slotEntry in slotsJson.entries) {
        Slot slot = SlotDto.fromJson(slotEntry.key, slotEntry.value);

        if (slot.stationId == stationId) {
          result.add(slot);
        }
      }

      return result;
    } else {
      // 2- Throw exception if any issue
      throw Exception('Failed to load slots');
    }
  }

  @override
  Future<void> markSlotAsBooked({
    required String stationId,
    required String slotId,
  }) async {
    final Slot? slot = await getSlotById(stationId, slotId);

    if (slot == null) {
      throw Exception('Slot not found');
    }

    final Uri slotUri = FirebaseConfig.baseUri.replace(
      path: '/slots/$slotId.json',
    );

    final http.Response response = await http.patch(
      slotUri,
      body: json.encode({'status': SlotStatus.occupied.name}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update slot');
    }
  }
}
