//archivo show_hide_name_switch.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowHideNameSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TabProvider>(
      builder: (context, tabProvider, child) {
        return SwitchListTile(
          title: Text('Mostrar u ocultar nombre'),
          value: tabProvider.showText,
          onChanged: (bool value) {
            tabProvider.toggleShowText();
            Fluttertoast.showToast(
              msg: tabProvider.showText
                  ? 'Mostrando nombres de tabs'
                  : 'Ocultando nombres de tabs',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
          },
        );
      },
    );
  }
}
