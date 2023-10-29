// archivo: tab_organizer_page.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';

class TabOrganizerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organizar los tabs'),
      ),
      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) =>
            Provider.of<TabProvider>(context, listen: false)
                .reorderTabs(oldIndex, newIndex),
        children: Provider.of<TabProvider>(context).myTabs.map((tabData) {
          return ListTile(
            key: Key(tabData.text),
            leading: Icon(tabData.icon),
            title: Text(tabData.text),
          );
        }).toList(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        FloatingActionButton.extended(
          onPressed: () {
            // Aquí puedes implementar la lógica para cancelar los cambios
            Navigator.pop(context);
          },
          label: Text('Cancelar'),
          icon: Icon(Icons.cancel),
        ),
        FloatingActionButton.extended(
          onPressed: () {
            // Aquí puedes implementar la lógica para confirmar los cambios
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
    );
  }
}
