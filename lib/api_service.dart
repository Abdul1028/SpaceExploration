import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:nasa_api_hello_world/models/news_model.dart';
import 'models/upcoming_launches_data_model.dart';
import 'models/apod_model.dart';

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

  //For fetching Image of the day!!

  Future<APOD> fetchImageOfTheDay() async {
    APOD modelAPOD;
    try {
      final res = await _dio.get(
          'https://api.nasa.gov/planetary/apod?api_key=ENhcn49EHMwPfDPoX3vNc6ntmBAruQdDL8iq58Fc');

      if (res.statusCode == 200) {
        modelAPOD = APOD(
          name: res.data["title"],
          description: res.data["explanation"],
          imageURL: res.data["url"],
          date: res.data["date"],
        );
        return modelAPOD;
      } else {
        throw Exception('Unable to load AIOD: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<NewsResponse> fetchNews() async {
    try {
      final res = await _dio.get(
          'https://api.spaceflightnewsapi.net/v4/articles/?format=json');

      if (res.statusCode == 200) {
        return NewsResponse.fromJson(res.data);
      } else {
        throw Exception('Unable to load AIOD: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
