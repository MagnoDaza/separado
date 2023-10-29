//archivo tab_organizer_paga.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';
import 'tab_data.dart';

class TabOrganizerPage extends StatefulWidget {
  @override
  _TabOrganizerPageState createState() => _TabOrganizerPageState();
}

class _TabOrganizerPageState extends State<TabOrganizerPage> {
  late List<TabData> workingTabs;

  @override
  void initState() {
    super.initState();
    workingTabs =
        List.from(Provider.of<TabProvider>(context, listen: false).myTabs);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Organizar los tabs'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final TabData item = workingTabs.removeAt(oldIndex);
                    workingTabs.insert(newIndex, item);
                  });
                },
                children: workingTabs.map((tabData) {
                  return ListTile(
                    key: Key(tabData.text),
                    leading: Icon(tabData.icon),
                    title: Text(tabData.text),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pop(context);
                },
                label: Text('Cancelar'),
                icon: Icon(Icons.cancel),
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  Provider.of<TabProvider>(context, listen: false).myTabs =
                      workingTabs;
                  Fluttertoast.showToast(
                    msg: "Cambios guardados",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                  Navigator.pop(context);
                },
                label: Text('Confirmar'),
                icon: Icon(Icons.check),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
