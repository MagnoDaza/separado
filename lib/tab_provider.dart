//archivo: tab_provider

import 'package:flutter/material.dart';
import 'tab_data.dart';

class TabProvider with ChangeNotifier {
  List<TabData> myTabs = [TabData(text: 'Tab 1', icon: Icons.home)];

  bool get customNamesEnabled => _customNamesEnabled;
  bool _customNamesEnabled = false;

  bool showText = true;

  bool get showIcons => _showIcons;
  bool _showIcons = true;

  void addTab(String name, IconData icon) {
    myTabs.add(TabData(text: name, icon: icon));
    notifyListeners();
  }

  void updateTab(int index, String name, IconData icon) {
    myTabs[index].text = name;
    myTabs[index].icon = icon;
    notifyListeners();
  }

  void removeTab(int index) {
    myTabs.removeAt(index);
    notifyListeners();
  }

  void toggleShowText() {
    if (!showIcons && showText) {
      _showIcons = true;
    }
    showText = !showText;
    for (TabData tab in myTabs) {
      tab.showText = showText;
    }
    notifyListeners();
  }

  void toggleShowIcons() {
    if (!showText && showIcons) {
      showText = true;
    }
    _showIcons = !_showIcons;
    for (TabData tab in myTabs) {
      tab.showIcon = _showIcons;
    }
    notifyListeners();
  }

  void toggleCustomNamesEnabled() {
    _customNamesEnabled = !_customNamesEnabled;
    if (_customNamesEnabled) {
      showText = true; // Asegúrate de que al menos uno de ellos sea verdadero
      _showIcons = true; // Asegúrate de que al menos uno de ellos sea verdadero
      for (TabData tab in myTabs) {
        tab.showText =
            true; // Asegúrate de que al menos uno de ellos sea verdadero
        tab.showIcon =
            true; // Asegúrate de que al menos uno de ellos sea verdadero
      }
    } else {
      showText = true; // Asegúrate de que al menos uno de ellos sea verdadero
      _showIcons = true; // Asegúrate de que al menos uno de ellos sea verdadero
    }
    notifyListeners();
  }
}
