// archivo: show_hide_tabs_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';

class ShowHideTabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mostrar nombre del tab'),
      ),
      body: SingleChildScrollView(
        child: Consumer<TabProvider>(
          builder: (context, tabProvider, child) {
            return Column(
              children: <Widget>[
                SwitchListTile(
                  title: Text('Mostrar u ocultar nombre'),
                  value: tabProvider.showText,
                  onChanged: (bool value) {
                    tabProvider.toggleShowText();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
