// File: tab_creator_page.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';
import 'new_tab_dialog.dart'; // Update this import
import 'show_hide_tabs_page.dart';
import 'tab_organizer_dialog.dart';

class TabCreatorPage extends StatefulWidget {
  final int? tabIndex;
  TabCreatorPage({this.tabIndex});

  @override
  _TabCreatorPageState createState() => _TabCreatorPageState();
}

class _TabCreatorPageState extends State<TabCreatorPage> {
  TextEditingController? _textController;
  IconData? _icon;
  int? _tabIndex;

  @override
  void initState() {
    super.initState();
    if (widget.tabIndex != null) {
      _textController = TextEditingController(
        text: Provider.of<TabProvider>(context, listen: false)
            .myTabs[widget.tabIndex!]
            .text,
      );
      _icon = Provider.of<TabProvider>(context, listen: false)
          .myTabs[widget.tabIndex!]
          .icon;
      _tabIndex = widget.tabIndex;
    } else {
      _textController = TextEditingController();
      _icon = Icons.home;
    }
  }

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
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NewTabDialog(); // Update this constructor call
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
                      leading: tabData.showIcon ? Icon(tabData.icon) : null,
                      title: Text(tabData.text),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Add your logic for editing a tab here
                            _textController =
                                TextEditingController(text: tabData.text);
                            _icon = tabData.icon;
                            _tabIndex =
                                Provider.of<TabProvider>(context, listen: false)
                                    .myTabs
                                    .indexOf(tabData);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NewTabDialog(
                                    tabIndex:
                                        _tabIndex); // Update this constructor call
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Add your logic for deleting a tab here
                            Provider.of<TabProvider>(context, listen: false)
                                .removeTab(Provider.of<TabProvider>(context,
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
