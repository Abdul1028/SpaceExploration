import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:nasa_api_hello_world/models/apod_model.dart';
import '../api_service.dart';
import '../models/upcoming_launches_data_model.dart';

class RecentsTab extends StatefulWidget {
  const RecentsTab({Key? key}) : super(key: key);

  @override
  _RecentsTabState createState() => _RecentsTabState();
}

class _RecentsTabState extends State<RecentsTab> {
  List<Launch> _launches = [];
  bool _loading = false;
  String _errorMessage = '';

  final ApiService _apiService = ApiService();

  void _fetchLaunches() async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });

    try {
      final launchesResponse = await _apiService.fetchUpcomingLaunches();
      setState(() {
        _launches = launchesResponse.results;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchLaunches();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          color: const Color(0xFF262626),
          padding:
              const EdgeInsets.only(top: 65, left: 25, right: 25, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("app_name",
                  style:
                      GoogleFonts.bebasNeue(fontSize: 26, color: Colors.white)),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.2),
                            color: const Color(0xFF191919),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text("Astronomical Pic of the Day",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 20,
                                            letterSpacing: -1,
                                            fontWeight: FontWeight.w600)),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          CupertinoIcons.multiply_circle_fill,
                                          size: 27,
                                          color: Color(0xFF333333),
                                        )),
                                  ],
                                ),
                              ),
                              FutureBuilder<APOD>(
                                  future: _apiService.fetchImageOfTheDay(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 200,
                                          child: Image.network(
                                            snapshot.data.imageURL,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data.name,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: -0.4,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            ],
                          ),
                        );
                      });
                },
                child: Lottie.asset('assets/apod-button.json',
                    height: 45,
                    fit: BoxFit.cover,
                    animate: true,
                    alignment: Alignment.topRight),
              )
            ],
          ),
        ),
        if (_loading)
          const CircularProgressIndicator()
        else if (_errorMessage.isNotEmpty)
          Text('Error: $_errorMessage',
              style: const TextStyle(color: Colors.red))
        else
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _fetchLaunches();
              },
              child: ListView.builder(
                itemCount: _launches.length,
                itemBuilder: (context, index) {
                  final launch = _launches[index];
                  return _launchComponent(launch, context);
                },
              ),
            ),
          ),
      ],
    );
  }

  Widget _launchComponent(Launch launch, BuildContext context) {
    return ListTile(
      title: Text(
        launch.name,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        launch.windowStart,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
      ),
      onTap: () {
        // Add onTap functionality
      },
    );
  }
}
