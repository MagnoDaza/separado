import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';
import 'show_hide_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'edit_tabs_dialog.dart';

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
                  if (tabProvider.customNamesEnabled)
                    ElevatedButton(
                      onPressed: () => showDialog(
                          context: context, builder: (_) => EditTabsDialog()),
                      child: Text('Editar'),
                    ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          Provider.of<TabProvider>(context).myTabs.length,
                      itemBuilder: (context, index) {
                        var tabData =
                            Provider.of<TabProvider>(context).myTabs[index];
                        return ListTile(
                          key: Key(tabData.text),
                          leading: Icon(tabData.icon),
                          title: Text(tabData.text),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: tabData.showText,
                                onChanged: null,
                              ),
                              Checkbox(
                                value: tabData.showIcon,
                                onChanged: null,
                              ),
                            ],
                          ),
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
