import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String _newsText = 'Breaking News: Flutter is awesome!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      body: Center(
        child: Text(
          "News Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
