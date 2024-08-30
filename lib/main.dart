import 'package:flutter/material.dart';
import 'package:nasa_api_hello_world/presentation/home_page.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
