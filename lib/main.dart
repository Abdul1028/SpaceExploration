import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:nasa_api_hello_world/presentation/home_page.dart';

void main() {
  Gemini.init(apiKey: "AIzaSyD0ztX0K6Goz-oZySvjfzNmwqTEjSjxeLQ");
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
