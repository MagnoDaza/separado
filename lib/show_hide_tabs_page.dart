// archivo show_hide_tabs_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';
import 'show_hide_name_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';

// archivo: show_hide_tabs_page.dart
class ShowHideTabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mostrar nombre del tab'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Consumer<TabProvider>(
            builder: (context, tabProvider, child) {
              return Column(
                children: <Widget>[
                  ShowHideNameSwitch(),
                  const SizedBox(height: 15),
                  const Text('Nombres e iconos personalizados',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  SwitchListTile(
                    title: Text('Nombre e icono personalizado'),
                    value: tabProvider.customNamesEnabled,
                    onChanged: (bool value) {
                      tabProvider.toggleCustomNamesEnabled();
                      Fluttertoast.showToast(
                        msg: tabProvider.customNamesEnabled
                            ? "Nombres e iconos personalizados habilitados"
                            : "Nombres e iconos personalizados deshabilitados",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView(
                      children: Provider.of<TabProvider>(context)
                          .myTabs
                          .map((tabData) {
                        return ListTile(
                          key: Key(tabData.text),
                          leading: Icon(tabData.icon),
                          title: Text(tabData.text),
                          trailing:
                              Row(mainAxisSize: MainAxisSize.min, children: [
                            Checkbox(
                              value: tabData.hideName,
                              onChanged: (bool? value) {
                                if (value != null) {
                                  tabData.toggleHideName();
                                }
                              },
                            ),
                            Checkbox(
                              value: tabData.hideIcon,
                              onChanged: (bool? value) {
                                if (value != null) {
                                  tabData.toggleHideIcon();
                                }
                              },
                            ),
                          ]),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
