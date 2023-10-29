// archivo: tab_data.dart
import 'package:flutter/material.dart';

class TabData {
  String text;
  IconData icon;
  bool hideName;
  bool hideIcon;
  bool showText; // Agrega este campo

  TabData({
    required this.text,
    required this.icon,
    this.hideName = false,
    this.hideIcon = false,
    this.showText = true, // Asegúrate de proporcionar un valor predeterminado
  });

  void toggleHideName() {
    hideName = !hideName;
  }

  void toggleHideIcon() {
    hideIcon = !hideIcon;
  }
}
