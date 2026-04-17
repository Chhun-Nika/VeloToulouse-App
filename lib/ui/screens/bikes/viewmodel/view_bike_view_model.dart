// import 'package:flutter/widgets.dart';
// import 'package:velo_toulouse_app/data/repositories/bikes/bike_repository.dart';
// import 'package:velo_toulouse_app/model/bike.dart';
// import 'package:velo_toulouse_app/ui/utils/async_value.dart';

// class ViewBikeViewModel extends ChangeNotifier {
//   final BikeRepository bikeRepository;
//   final String stationId;

//   AsyncValue<List<Bike>> bikesValue = AsyncValue.loading();
//   Bike? selectedBike;

//   ViewBikeViewModel({required this.bikeRepository, required this.stationId}) {
//     _init();
//   }

//   void _init() async {
//     fetchBikesByStationId(stationId);
//   }

//   void fetchBikesByStationId(String stationId) async {
//     bikesValue = AsyncValue.loading();
//     notifyListeners();

//     try {
//       // List<Bike> bikes = await bikeRepository.getBikesByStation(stationId);
//       List<Bike> bikes = await bikeRepository.getAllBikes(); // will be remove later 
//       bikesValue = AsyncValue.success(bikes);
//       notifyListeners();
//     } catch (e) {
//       bikesValue = AsyncValue.error(e);
//       notifyListeners();
//     }
//   }

//   void selectBike(Bike bike) {
//     selectedBike = bike;
//     notifyListeners();
//   }

//   bool isBikeSelected(Bike bike) => selectedBike == bike;

//   bool isAvailable(Bike bike) {
//     return bike.bikeStatus == BikeStatus.available;
//   }
// }
