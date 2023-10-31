import 'package:flutter/material.dart';

class TabData {
  String text;
  IconData icon;
  bool hideName;
  bool hideIcon;
  bool showText; // Agrega este campo
  bool showIcon; // Agrega este campo

  TabData({
    required this.text,
    required this.icon,
    this.hideName = false,
    this.hideIcon = false,
    this.showText = true, // Asegúrate de proporcionar un valor predeterminado
    this.showIcon = true,
  });

  void toggleHideName() {
    hideName = !hideName;
  }

  void toggleHideIcon() {
    hideIcon = !hideIcon;
  }
}
