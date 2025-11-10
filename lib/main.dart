import 'package:flutter/material.dart';
import 'package:project_kanso/views/pages/Reception.dart';
import 'package:project_kanso/library/bluetooth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => BluetoothProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 90, 180, 221),
          brightness: Brightness.dark,
        ),
      ),
      home: ReceptionPage(),
    );
  }
}
