// MODEL FILE

// Agency
class Agency {
  final String name;

  Agency({required this.name});

  factory Agency.fromJson(Map<String, dynamic> json) {
    return Agency(name: json['name']);
  }
}

// Mission
class Mission {
  final String name;
  final List<Agency> agencies;

  Mission({
    required this.name,
    required this.agencies,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    var agencyList = (json['agencies'] as List)
        .map((agencyJson) => Agency.fromJson(agencyJson))
        .toList();

    return Mission(
      name: json['name'],
      agencies: agencyList,
    );
  }
}

// Rocket Configuration
class RocketConfiguration {
  final String name;

  RocketConfiguration({required this.name});

  factory RocketConfiguration.fromJson(Map<String, dynamic> json) {
    return RocketConfiguration(name: json['name']);
  }
}

// Rocket
class Rocket {
  final RocketConfiguration configuration;

  Rocket({required this.configuration});

  factory Rocket.fromJson(Map<String, dynamic> json) {
    return Rocket(
      configuration: RocketConfiguration.fromJson(json['configuration']),
    );
  }
}

// Launch Status
class LaunchStatus {
  final String name;

  LaunchStatus({required this.name});

  factory LaunchStatus.fromJson(Map<String, dynamic> json) {
    return LaunchStatus(name: json['name']);
  }
}

// Launch
class Launch {
  final String name;
  final String windowStart;
  final LaunchStatus status;
  final Rocket rocket;
  final Mission mission;
  final String imageUrl;

  Launch({
    required this.name,
    required this.windowStart,
    required this.status,
    required this.rocket,
    required this.mission,
    required this.imageUrl,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      name: json['name'],
      windowStart: json['window_start'],
      status: LaunchStatus.fromJson(json['status']),
      rocket: Rocket.fromJson(json['rocket']),
      mission: Mission.fromJson(json['mission']),
      imageUrl: json['image'],
    );
  }
}

// WHOLE RESPONSE OF LAUNCHES
class LaunchesResponse {
  final List<Launch> results;

  LaunchesResponse({required this.results});

  factory LaunchesResponse.fromJson(Map<String, dynamic> json) {
    var launchList = (json['results'] as List)
        .map((launchJson) => Launch.fromJson(launchJson))
        .toList();

    return LaunchesResponse(results: launchList);
  }
}

class APOD {
  final String name;
  final String description;
  final String imageURL;
  final String date;

  APOD({required this.name, required this.description, required this.imageURL, required this.date});
}