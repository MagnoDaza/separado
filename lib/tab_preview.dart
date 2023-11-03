// File: tab_preview.dart
import 'package:flutter/material.dart';

class TabPreview extends StatelessWidget {
  final String text;
  final IconData icon;

  TabPreview({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Tab(
            text: 'tabs',
            icon: Icon(icon),
          ),
        ),
        const SizedBox(height: 0),
        Container(
          width: MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Tab(
            text: 'tab normal',
            icon: Icon(Icons.favorite),
          ),
        ),
      ],
    );
  }
}
