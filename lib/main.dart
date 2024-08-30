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

Future<void> fetchUpcomingLaunches() async {
  final Dio _dio = Dio();

  try {
    final response = await _dio
        .get('https://ll.thespacedevs.com/2.2.0/launch/upcoming/?format=json');

    if (response.statusCode == 200) {
      final data = response.data;

      // Loop through and print the required details
      for (var launch in data['results']) {
        print('Launch Name: ${launch['name']}');
        print('Launch Time: ${launch['window_start']}');
        print('Launch Status: ${launch['status']['name']}');
        print('Rocket Name: ${launch['rocket']['configuration']['name']}');
        print('Mission Name: ${launch['mission']['name']}');
        print(
            'Agency Name: ${launch['rocket']['spacecraft_stage']['spacecraft']['spacecraft_config']['manufacturer']['name']}');
        print('-----------------------------------');
      }
    } else {
      print('Failed to load launches: ${response.statusCode}');
    }
  } catch (e) {
    print('Error occurred: $e');
  }
}
