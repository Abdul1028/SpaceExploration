import 'package:feather_icons/feather_icons.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      bottomNavigationBar: Container(
        color: const Color(0xFF262626),
        padding: const EdgeInsets.only(top: 18, left: 30, right: 30, bottom: 29),
        child: GNav(
          // backgroundColor: Colors.red,
          activeColor: Colors.black,
          rippleColor: Colors.grey,
          hoverColor: const Color(0xFF9E86FF),
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 15),
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
          ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                color: Color(0xFF262626),
                padding: EdgeInsets.only(top: 65, left: 25, right: 25, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("app_name", style: GoogleFonts.bebasNeue(fontSize: 26, color: Colors.white)),
                    Icon(CupertinoIcons.info, color: Colors.white, size: 25,)
                  ],
                ),
              ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.09),
              // ElevatedButton(
              //   onPressed: _fetchLaunches,
              //   child: const Text('Fetch Upcoming Launches'),
              // ),
              if (_loading)
                const CircularProgressIndicator()
              else if (_errorMessage.isNotEmpty)
                Text('Error: $_errorMessage',
                    style: const TextStyle(color: Colors.red))
              else
                Expanded(
                //   child: PageView.builder(
                //     itemCount: _launches.length,
                //     itemBuilder: (context, index) {
                //       return _launchComponent(_launches[index], context);
                //     },
                //   ),
                  child: ListView.builder(
                    itemCount: _launches.length,
                    itemBuilder: (context, index) {
                      final launch = _launches[index];
                      return _launchComponent(launch, context);
                    },
                  ),
                ),
            ],
          )
          : Container(),
    );
  }
}

Widget _launchComponent(data, context) {

  TextStyle headerStyle = GoogleFonts.anton(
      color: Colors.white,
      fontSize: 19,
      // letterSpacing: -0.7,
      fontWeight: FontWeight.w500,
  );

  TextStyle normalStyle = GoogleFonts.poppins(
      color: Colors.grey,
      fontSize: 14,
      letterSpacing: -0.3,
      fontWeight: FontWeight.w500
  );

  TextStyle descStyle = GoogleFonts.poppins(
      color: Colors.blueGrey,
      fontSize: 14,
      letterSpacing: -0.7,
      fontWeight: FontWeight.w600
  );

  String mainName = data.name;
  String launchWindow = data.windowStart.substring(0, 10);
  String status = data.status.name;
  String rocketName = data.rocket.configuration.name;
  String mission = data.mission.name;
  String agency = data.mission.agencies.isNotEmpty ? data.mission.agencies[0].name : 'No Agency Name';

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Container(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 14, bottom: 18),
      clipBehavior: Clip.hardEdge,
      width: MediaQuery.of(context).size.width*0.84,
      decoration: ShapeDecoration(
        color: const Color(0xFF1E1E1E),
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 17,
            cornerSmoothing: 0.9,
          ),
        ),
      ),
      // height: 200,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            // width: MediaQuery.of(context).size.width*0.94,
            decoration: ShapeDecoration(
              color: const Color(0xFF1E1E1E),
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: NetworkImage(data.imageUrl)
              ),
              shape: SmoothRectangleBorder(
                borderRadius: SmoothBorderRadius(
                  cornerRadius: 13,
                  cornerSmoothing: 0.9,
                ),
              ),
            ),
          ),
          const SizedBox(height: 13),
          Text(mainName, style: headerStyle),
          const SizedBox(height: 5),
          Text(launchWindow, style: normalStyle),
          Text(status, style: normalStyle),
          Text("${agency} - ${mission}", style: descStyle)
        ],
      ),
    ),
  );
}