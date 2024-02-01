import 'package:flutter/material.dart';
import 'package:registrasi_klaim_app/beranda.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registrasi Klaim App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Beranda(
          title: "", formulir: [], enabledProvince: [], initialSelection: ""),
    );
  }
}
