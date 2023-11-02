//archivo show_hide_tads_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'show_hide_switch.dart';

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
                  Text("Mostrar u ocultar nombre"),
                  ShowHideSwitch(),
                  const SizedBox(height: 15),
                  Divider(),
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
                  const SizedBox(height: 20),
                  if (tabProvider.customNamesEnabled)
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            Provider.of<TabProvider>(context).myTabs.length,
                        itemBuilder: (context, index) {
                          var tabData =
                              Provider.of<TabProvider>(context).myTabs[index];
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Icons')),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text('Name Tabs')),
                                  Align(
                                      alignment: Alignment.center,
                                      child:
                                          Icon(Icons.text_fields, size: 20.0)),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(Icons.image, size: 20.0)),
                                ],
                              ),
                              ListTile(
                                key: Key(tabData.text),
                                leading: tabData.showIcon
                                    ? Icon(tabData.icon)
                                    : Icon(tabData.icon, color: Colors.grey),
                                title: tabData.showText
                                    ? Text(tabData.text)
                                    : Text(''),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                      value: tabData.showText,
                                      onChanged: (bool? value) {
                                        if (value != null) {
                                          tabData.showText = value;
                                          if (!tabData.showText &&
                                              !tabData.showIcon) {
                                            tabData.showIcon = true;
                                          }
                                          Fluttertoast.showToast(
                                            msg: tabData.showText
                                                ? "Nombre mostrado"
                                                : "Nombre ocultado",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                          );
                                        }
                                      },
                                    ),
                                    Checkbox(
                                      value: tabData.showIcon,
                                      onChanged: (bool? value) {
                                        if (value != null) {
                                          tabData.showIcon = value;
                                          if (!tabData.showText &&
                                              !tabData.showIcon) {
                                            tabData.showText = true;
                                          }
                                          Fluttertoast.showToast(
                                            msg: tabData.showIcon
                                                ? "Icono mostrado"
                                                : "Icono ocultado",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
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
