// File: tab_dialog.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'icon_list.dart';
import 'tab_provider.dart';
import 'tab_preview.dart'; // Import TabPreview class

class TabDialog extends StatefulWidget {
  final int? tabIndex;
  final bool isNewTab;

  TabDialog({this.tabIndex, this.isNewTab = false});

  @override
  _TabDialogState createState() => _TabDialogState();
}

class _TabDialogState extends State<TabDialog> {
  TextEditingController? _textController;
  IconData? _icon;

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
    } else {
      _textController = TextEditingController();
      _icon = Icons.home;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isNewTab ? 'Crear un nuevo tab' : 'Editar Tab'),
      content: Column(
        children: <Widget>[
          const SizedBox(height: 15),
          const Text('Preview', style: TextStyle(fontSize: 14)),
          if (_textController != null && _icon != null)
            TabPreview(textController: _textController!, icon: _icon!),
          const SizedBox(height: 15),
          const Text('Selecciona el icono', style: TextStyle(fontSize: 14)),
          IconButton(
            icon: Icon(_icon),
            onPressed: () async {
              IconData? selectedIcon = await showDialog<IconData>(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: IconList(),
                  );
                },
              );
              if (selectedIcon != null) {
                setState(() {
                  _icon = selectedIcon;
                });
              }
            },
          ),
          const SizedBox(height: 15),
          const Text('Nombre del Tab', style: TextStyle(fontSize: 14)),
          TextField(
            controller: _textController,
            decoration: InputDecoration(hintText: "Nombre del Tab"),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child:
              Text(widget.isNewTab ? 'Crear nuevo tab' : 'Confirmar edición'),
          onPressed: () {
            if (_textController != null &&
                _icon != null &&
                _textController!.text.isNotEmpty) {
              if (!widget.isNewTab) {
                Provider.of<TabProvider>(context, listen: false).updateTab(
                  widget.tabIndex!,
                  _textController!.text,
                  _icon!,
                );
                Fluttertoast.showToast(
                  msg: "Tab actualizado",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
              } else {
                bool tabExists =
                    Provider.of<TabProvider>(context, listen: false)
                        .myTabs
                        .any((tab) => tab.text == _textController!.text);
                if (tabExists) {
                  Fluttertoast.showToast(
                    msg: "No se pueden tener tabs con el mismo nombre",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                } else {
                  Provider.of<TabProvider>(context, listen: false)
                      .addTab(_textController!.text, _icon!);
                  Fluttertoast.showToast(
                    msg: "Tab creado",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                  _textController!.clear();
                  FocusScope.of(context).unfocus();
                }
              }
            } else {
              Fluttertoast.showToast(
                msg: "Por favor, proporciona un nombre para el tab",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              );
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
