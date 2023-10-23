import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Añade esta línea
import 'tab_provider.dart';

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
        title: Text('Creador de Tabs'),
      ),
      body: Column(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Nombre del Tab',
              ),
            ),
          ),
          DropdownButton<IconData>(
            value: _icon,
            onChanged: (IconData? newValue) {
              if (newValue != null) {
                setState(() {
                  _icon = newValue;
                });
              }
            },
            items: [Icons.home, Icons.star, Icons.settings]
                .map<DropdownMenuItem<IconData>>((IconData value) {
              return DropdownMenuItem<IconData>(
                value: value,
                child: Icon(value),
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: () {
              if (_tabIndex != null &&
                  _textController != null &&
                  _icon != null) {
                Provider.of<TabProvider>(context, listen: false)
                    .updateTab(_tabIndex!, _textController!.text, _icon!);
              } else if (_textController != null && _icon != null) {
                Provider.of<TabProvider>(context, listen: false)
                    .addTab(_textController!.text, _icon!);
              }
              Navigator.pop(context);
            },
            child: Text('Confirmar'),
          ),
          SizedBox(height: 10),
          Text('Ocultar o mostrar nombre'),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        content: Container(
                          width: double.maxFinite,
                          child: ListView(
                            children:
                                Provider.of<TabProvider>(context).myTabs.map(
                              (tabData) {
                                return CheckboxListTile(
                                  title: Text(tabData.text),
                                  secondary: Icon(tabData.icon),
                                  value: tabData.showText,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      tabData.showText = value!;
                                    });
                                  },
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cerrar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
            child: Icon(Icons.edit_outlined),
          ),
          SizedBox(height: 10),
          Text('Historial'),
          Expanded(
            child: ReorderableListView(
              onReorder: (oldIndex, newIndex) =>
                  Provider.of<TabProvider>(context, listen: false)
                      .reorderTabs(oldIndex, newIndex),
              children: Provider.of<TabProvider>(context).myTabs.map((tabData) {
                return ListTile(
                  key: Key(tabData.text),
                  leading: Icon(tabData.icon),
                  title: Text(tabData.text),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _textController =
                              TextEditingController(text: tabData.text);
                          _icon = tabData.icon;
                          _tabIndex =
                              Provider.of<TabProvider>(context, listen: false)
                                  .myTabs
                                  .indexOf(tabData);
                        });
                      },
                      child: Text('Editar'),
                    ),
                    ElevatedButton(
                      onPressed: () => Provider.of<TabProvider>(context,
                              listen: false)
                          .removeTab(
                              Provider.of<TabProvider>(context, listen: false)
                                  .myTabs
                                  .indexOf(tabData)),
                      child: Text('Eliminar'),
                    ),
                  ]),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
