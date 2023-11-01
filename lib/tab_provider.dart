//archivo tabprovider.dart
import 'package:flutter/material.dart';
import 'tab_data.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    if (!showIcons) {
      Fluttertoast.showToast(
        msg:
            "No se pueden tener ambos switches apagados. Por favor, enciende el switch de icono primero.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      showText = !showText;
      for (TabData tab in myTabs) {
        tab.showText = showText;
      }
      notifyListeners();
    }
  }

  void toggleShowIcons() {
    if (!showText) {
      Fluttertoast.showToast(
        msg:
            "No se pueden tener ambos switches apagados. Por favor, enciende el switch de texto primero.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      _showIcons = !_showIcons;
      for (TabData tab in myTabs) {
        tab.showIcon = _showIcons;
      }
      notifyListeners();
    }
  }

  void toggleCustomNamesEnabled() {
    _customNamesEnabled = !_customNamesEnabled;
    if (_customNamesEnabled) {
      showText = true;
      _showIcons = true;
      for (TabData tab in myTabs) {
        tab.showText = true;
        tab.showIcon = true;
      }
    } else {
      showText = true;
      _showIcons = true;
    }
    notifyListeners();
  }
}
