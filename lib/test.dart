import 'package:dio/dio.dart';

class Test {
  final Dio _dio = Dio();

  Future<void> fetchUpcomingLaunches() async {
    try {
      final response = await _dio.get(
          'https://ll.thespacedevs.com/2.2.0/launch/upcoming/?format=json');

      if (response.statusCode == 200) {
        final data = response.data;
        var count = 1;
        for (var launch in data['results']) {
          print(count);
          print('Launch Name: ${launch['name']}');
          print('Launch Time: ${launch['window_start']}');
          print('Launch Status: ${launch['status']['name']}');
          print('Rocket Name: ${launch['rocket']['configuration']['name']}');
          print('Mission Name: ${launch['mission']['name']}');
          final agencyNames = launch['mission']['agencies'];
          final agencyName = agencyNames.isNotEmpty
              ? agencyNames[0]['name']
              : 'No Agency Name';

          print('Agency Name: $agencyName');
          print("-------------");
          count++;
        }
      } else {
        print('Failed to load launches: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}

void main() async {
  Test testInstance = Test();
  await testInstance.fetchUpcomingLaunches();
}
