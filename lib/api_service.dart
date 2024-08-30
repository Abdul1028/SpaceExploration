import 'package:dio/dio.dart';
import 'models/upcoming_launches_data_model.dart';

//Calling API and storing data in data models

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
