// archivo: show_hide_name_switch.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';

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
          },
        );
      },
    );
  }
}
