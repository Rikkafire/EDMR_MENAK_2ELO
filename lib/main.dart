import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_kanso/views/pages/reception.dart';
import 'package:project_kanso/library/bluetooth_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  // 🔥 Initialize Firebase before running the app
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
      home: const Reception(),
    );
  }
}
