// lib/api_service.dart

import 'package:dio/dio.dart';
import 'models/upcoming_launches_data_model.dart'; // Import the models from models.dart

class ApiService {
  final Dio _dio = Dio();

  Future<LaunchesResponse> fetchUpcomingLaunches() async {
    try {
      final response = await _dio.get(
          'https://ll.thespacedevs.com/2.2.0/launch/upcoming/?format=json');

      if (response.statusCode == 200) {
        return LaunchesResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load launches: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
