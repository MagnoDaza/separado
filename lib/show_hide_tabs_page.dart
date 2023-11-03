// File: show_hide_tabs_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';
import 'show_hide_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowHideTabsPage extends StatelessWidget {
  const ShowHideTabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mostrar nombre del tab'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Consumer<TabProvider>(
            builder: (context, tabProvider, child) {
              return Column(
                children: <Widget>[
                  const SizedBox(height: 15),
                  const Text("Mostrar u ocultar nombre"),
                  ShowHideSwitch(),
                  const SizedBox(height: 15),
                  const Divider(),
                  const SizedBox(height: 15),
                  const Text('Nombres e iconos personalizados',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  SwitchListTile(
                    title: const Text('Nombre e icono personalizado'),
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
                      onPressed: () {
                        // showDialog(
                        //   context: context,
                        //   builder: (_) => const EditTabsDialog(),
                        // );
                      },
                      child: const Text('Editar'),
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
                          leading: IconTheme(
                            data: IconThemeData(
                              color:
                                  tabData.showIcon ? Colors.black : Colors.grey,
                            ),
                            child: Icon(tabData.icon),
                          ),
                          title: Text(tabData.text,
                              style: TextStyle(
                                  color: tabData.showText
                                      ? Colors.black
                                      : Colors.grey)),
                          trailing:
                              Row(mainAxisSize: MainAxisSize.min, children: [
                            const Icon(Icons.text_fields), // Icono de texto
                            Checkbox(
                              value: tabData.showText,
                              onChanged: null,
                            ),
                            const Icon(Icons.image), // Icono de imagen
                            Checkbox(
                              value: tabData.showIcon,
                              onChanged: null,
                            ),
                          ]),
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
