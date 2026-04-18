import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/screens/bookings_history/booking_history_screen.dart';
import 'ui/screens/map/map_screen.dart';
import 'ui/theme/theme.dart';


// main
void mainCommon(List<InheritedProvider> providers) {
  runApp(
    MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: blaTheme,
        home: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [MapScreen(), BookingHistoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color.fromARGB(255, 233, 233, 233),
              width: 0.2,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColor.white,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index; // triggers rebuild
            });
          },
          selectedItemColor: AppColor.primary,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_num_outlined),
              label: 'Bookings',
            ),
          ],
        ),
      ),
    );
  }
}
