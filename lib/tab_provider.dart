//archivo tap_provider.dart
import 'package:flutter/material.dart';
import 'tab_data.dart';

class TabProvider with ChangeNotifier {
  List<TabData> myTabs = [TabData(text: 'Tab 1', icon: Icons.home)];
  int maxTabsToShowText = -1;
  bool showText = true; // Agrega esta línea

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

  void setMaxTabsToShowText(int maxTabs) {
    maxTabsToShowText = maxTabs;
    notifyListeners();
  }

  void reorderTabs(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final TabData tab = myTabs.removeAt(oldIndex);
    myTabs.insert(newIndex, tab);
    notifyListeners();
  }

  void toggleShowText() {
    showText = !showText;
    for (TabData tab in myTabs) {
      tab.showText = showText;
    }
    notifyListeners();
  }
}
