//archivo: tab_creator_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';
import 'show_hide_name_switch.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Asegúrate de tener esta librería

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
              if (_textController != null &&
                  _icon != null &&
                  _textController!.text.isNotEmpty) {
                if (_tabIndex != null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirmar edición'),
                        content: Column(
                          children: <Widget>[
                            TextField(
                              controller: _textController,
                              decoration:
                                  InputDecoration(hintText: "Nombre del Tab"),
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
                                  .map<DropdownMenuItem<IconData>>(
                                      (IconData value) {
                                return DropdownMenuItem<IconData>(
                                  value: value,
                                  child: Icon(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancelar'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: Text('Confirmar edición'),
                            onPressed: () {
                              Provider.of<TabProvider>(context, listen: false)
                                  .updateTab(_tabIndex!, _textController!.text,
                                      _icon!);
                              Fluttertoast.showToast(
                                msg: "Tab actualizado",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );
                              // Restablecer los campos a los valores predeterminados
                              setState(() {
                                _textController!.clear();
                                _icon = Icons.home;
                                _tabIndex = null;
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  Provider.of<TabProvider>(context, listen: false)
                      .addTab(_textController!.text, _icon!);
                  Fluttertoast.showToast(
                    msg: "Tab creado",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                  // No se necesita restablecer los campos a los valores predeterminados
                }
              } else {
                Fluttertoast.showToast(
                  msg: "Por favor, proporciona un nombre para el tab",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
              }
            },
            child: Text(
                _tabIndex != null ? 'Confirmar edición' : 'Crear nuevo tab'),
          ),
          SizedBox(height: 10),
          Text('Ocultar o mostrar nombre'),
          ShowHideNameSwitch(
            initialValue: true,
            onChanged: (value) {
              Provider.of<TabProvider>(context, listen: false)
                  .toggleShowText(value);
              Fluttertoast.showToast(
                msg: value
                    ? 'Mostrando nombres de tabs'
                    : 'Ocultando nombres de tabs',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              );
            },
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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Editar Tab'),
                              content: Column(
                                children: <Widget>[
                                  TextField(
                                    controller: _textController,
                                    decoration: InputDecoration(
                                        hintText: "Nombre del Tab"),
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
                                    items: [
                                      Icons.home,
                                      Icons.star,
                                      Icons.settings
                                    ].map<DropdownMenuItem<IconData>>(
                                        (IconData value) {
                                      return DropdownMenuItem<IconData>(
                                        value: value,
                                        child: Icon(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Cancelar'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                TextButton(
                                  child: Text('Confirmar edición'),
                                  onPressed: () {
                                    if (_textController != null &&
                                        _icon != null &&
                                        _textController!.text.isNotEmpty) {
                                      Provider.of<TabProvider>(context,
                                              listen: false)
                                          .updateTab(_tabIndex!,
                                              _textController!.text, _icon!);
                                      Fluttertoast.showToast(
                                        msg: "Tab actualizado",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                      );
                                      // Restablecer los campos a los valores predeterminados
                                      setState(() {
                                        _textController!.clear();
                                        _icon = Icons.home;
                                        _tabIndex = null;
                                      });
                                      Navigator.of(context).pop();
                                    } else {
                                      Fluttertoast.showToast(
                                        msg:
                                            "Por favor, proporciona un nombre para el tab",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                      );
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Editar'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirmar eliminación'),
                            content: Text(
                                '¿Estás seguro de que quieres eliminar este tab?'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Cancelar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Eliminar'),
                                onPressed: () {
                                  Provider.of<TabProvider>(context,
                                          listen: false)
                                      .removeTab(Provider.of<TabProvider>(
                                              context,
                                              listen: false)
                                          .myTabs
                                          .indexOf(tabData));
                                  Navigator.of(context).pop();
                                  Fluttertoast.showToast(
                                    msg: "Tab eliminado",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
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
