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
      return;
    }
    showText = !showText;
    for (TabData tab in myTabs) {
      tab.showText = showText;
    }
    notifyListeners();
  }

  void toggleShowIcons() {
    if (!showText && showIcons) {
      return;
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
      showText = false;
      _showIcons = false;
      for (TabData tab in myTabs) {
        tab.showText = false;
        tab.showIcon = false;
      }
    }
    notifyListeners();
  }
}
