import 'package:flutter/material.dart';

import 'features/stopwatch_screen/stopwatch_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF10111A),
      ),
      home: const StopWatchScreen(),
    );
  }
}
