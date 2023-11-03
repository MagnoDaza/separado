//archivo show_hide_switch.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';

class ShowHideSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TabProvider>(
      builder: (context, tabProvider, child) {
        return SwitchListTile(
          title: Text(tabProvider.showText
              ? 'Se muestran todos los nombres de los tabs'
              : 'Se muestran todos los iconos'),
          value: tabProvider.showText,
          onChanged: tabProvider.customNamesEnabled
              ? null
              : (bool value) {
                  tabProvider.toggleShowText();
                  tabProvider.toggleShowIcons();
                  Fluttertoast.showToast(
                    msg: tabProvider.showText
                        ? "Nombre mostrado"
                        : "Icono mostrado",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                },
        );
      },
    );
  }
}
