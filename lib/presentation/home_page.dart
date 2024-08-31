import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:icons_plus/icons_plus.dart';

import '../api_service.dart'; // Import the ApiService class
import '../models/upcoming_launches_data_model.dart'; // Import the data models where data is stored

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Page/tab counter [3 PAGES IN TOTAL]
  List<Launch> _launches = [];
  bool _loading = false;
  String _errorMessage = '';

  //Create instance for accessing api services

  final ApiService _apiService = ApiService();

  /**
   * This function is called when the user taps on launch and fetches data from data model
   */

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
    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 40),
        child: GNav(
          activeColor: Colors.black,
          rippleColor: Colors.grey,
          hoverColor: const Color(0xFF9E86FF),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          gap: 6,
          iconSize: 22,
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: const Color(0x799E86FF),
          color: Colors.white,
          textStyle: const TextStyle(
            color: Color(0xFF9E86FF),
            fontWeight: FontWeight.w700,
            letterSpacing: -1,
            fontSize: 15,
          ),
          tabs: const [
            GButton(
              icon: Icons.rocket_launch,
              iconActiveColor: Color(0xFF9E86FF),
              text: 'Recents',
            ),
            GButton(
              icon: Icons.chat_bubble,
              iconActiveColor: Color(0xFF9E86FF),
              text: 'SpaceBot',
            ),
            GButton(
              icon: Icons.article_outlined,
              iconActiveColor: Color(0xFF9E86FF),
              text: 'News',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      body: _selectedIndex == 0
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                  ElevatedButton(
                    onPressed: _fetchLaunches,
                    child: const Text('Fetch Upcoming Launches'),
                  ),
                  if (_loading)
                    const CircularProgressIndicator()
                  else if (_errorMessage.isNotEmpty)
                    Text('Error: $_errorMessage',
                        style: const TextStyle(color: Colors.red))
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: _launches.length,
                        itemBuilder: (context, index) {
                          final launch = _launches[index];
                          return ListTile(
                            title: Text(
                              launch.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Launch Time: ${launch.windowStart}\n'
                              'Status: ${launch.status.name}\n'
                              'Rocket: ${launch.rocket.configuration.name}\n'
                              'Mission: ${launch.mission.name}\n'
                              'Agency: ${launch.mission.agencies.isNotEmpty ? launch.mission.agencies[0].name : 'No Agency Name'}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            )
          : Container(),
    );
  }
}
