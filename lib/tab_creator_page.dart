// File: tab_creator_page.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';
import 'tabs_dialog.dart'; // Import TabDialog class
import 'show_hide_tabs_page.dart';
import 'tab_organizer_dialog.dart';

class TabCreatorPage extends StatefulWidget {
  final int? tabIndex;
  TabCreatorPage({this.tabIndex});

  @override
  _TabCreatorPageState createState() => _TabCreatorPageState();
}

class _TabCreatorPageState extends State<TabCreatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Creador de DinamicsTabs'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text('Crear un nuevo tab'),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TabDialog(isNewTab: true);
                    },
                  );
                },
                child: Text('Crear un nuevo tab'),
              ),
              Divider(),
              const SizedBox(height: 15),
              Text('Mostrar Tabs'),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowHideTabsPage(),
                    ),
                  );
                },
                child: Text('Mostrar Tabs'),
              ),
              Divider(),
              const SizedBox(height: 15),
              Text('Organizar los tabs'),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TabOrganizerDialog();
                    },
                  );
                },
                child: Text('Organizar los tabs'),
              ),
              Divider(),
              const SizedBox(height: 15),
              const Text('Mis DinamicsTabs',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              Expanded(
                child: ListView(
                  children:
                      Provider.of<TabProvider>(context).myTabs.map((tabData) {
                    return ListTile(
                      key: Key(tabData.text),
                      leading: tabData.showIcon
                          ? Icon(tabData.icon)
                          : Container(
                              width:
                                  50.0, // Ajusta este valor según tus necesidades
                              child: Row(children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Icon(tabData.icon),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right:
                                          5.0), // Añade 5 pixeles de espacio a la derecha
                                  child: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Icon(Icons.visibility_off, size: 18.0),
                                  ),
                                )
                              ]),
                            ),
                      title: tabData.showText
                          ? Text(tabData.text)
                          : Row(children: [
                              Text(tabData.text),
                              Padding(
                                padding: EdgeInsets.only(
                                    right:
                                        5.0), // Añade 5 pixeles de espacio a la derecha
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Icon(Icons.visibility_off, size: 18.0),
                                ),
                              )
                            ]),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            int tabIndex =
                                Provider.of<TabProvider>(context, listen: false)
                                    .myTabs
                                    .indexOf(tabData);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return TabDialog(tabIndex: tabIndex);
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete,
                              color: Provider.of<TabProvider>(context,
                                              listen: false)
                                          .myTabs
                                          .indexOf(tabData) ==
                                      0
                                  ? Colors.grey
                                  : null),
                          onPressed:
                              Provider.of<TabProvider>(context, listen: false)
                                          .myTabs
                                          .indexOf(tabData) ==
                                      0
                                  ? null
                                  : () {
                                      Provider.of<TabProvider>(context,
                                              listen: false)
                                          .removeTab(Provider.of<TabProvider>(
                                                  context,
                                                  listen: false)
                                              .myTabs
                                              .indexOf(tabData));
                                      Fluttertoast.showToast(
                                        msg: "Tab eliminado",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                      );
                                    },
                        ),
                      ]),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
