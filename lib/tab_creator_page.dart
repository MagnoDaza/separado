// archivo: tab_creator_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';
import 'show_hide_name_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'tab_data.dart';
import 'icon_list.dart'; // Importa el archivo icon_list.dart

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
        // Permite desplazamiento si el contenido se desborda
        child: Container(
          height: MediaQuery.of(context).size.height,
          // Proporciona una altura específica
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  iconList(), // Reemplaza iconDropdown() con iconList()
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        labelText: 'Nombre del Tab',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              createOrEditButton(),
              const SizedBox(height: 15),
              ShowHideNameSwitch(),
              const SizedBox(height: 15),
              const Text('Mis DinamicsTabs',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              Expanded(
                child: ReorderableListView(
                  onReorder: (oldIndex, newIndex) =>
                      Provider.of<TabProvider>(context, listen: false)
                          .reorderTabs(oldIndex, newIndex),
                  children:
                      Provider.of<TabProvider>(context).myTabs.map((tabData) {
                    return ListTile(
                      key: Key(tabData.text),
                      leading: Icon(tabData.icon),
                      title: Text(tabData.text),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        editButton(tabData),
                        deleteButton(tabData),
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

  Widget iconList() {
    // Nueva función iconList
    return StatefulBuilder(
      // Añade StatefulBuilder
      builder: (BuildContext context, StateSetter setState) {
        return IconButton(
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
                // Actualiza el estado del ícono seleccionado
                _icon = selectedIcon;
              });
            }
          },
        );
      },
    );
  }

  Widget createOrEditButton() {
    return ElevatedButton(
      onPressed: () {
        if (_textController != null &&
            _icon != null &&
            _textController!.text.isNotEmpty) {
          if (_tabIndex != null) {
            editTab();
          } else {
            createTab();
          }
        } else {
          Fluttertoast.showToast(
            msg: "Por favor, proporciona un nombre para el tab",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      },
      child: Text(_tabIndex != null ? 'Confirmar edición' : 'Crear nuevo tab'),
    );
  }

  void editTab() {
    Provider.of<TabProvider>(context, listen: false)
        .updateTab(_tabIndex!, _textController!.text, _icon!);
    Fluttertoast.showToast(
      msg: "Tab actualizado",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
    setState(() {
      _textController!.clear();
      _icon = Icons.home;
      _tabIndex = null;
    });
  }

  void createTab() {
    // Verifica si ya existe una pestaña con el mismo nombre
    bool tabExists = Provider.of<TabProvider>(context, listen: false)
        .myTabs
        .any((tab) => tab.text == _textController!.text);

    if (tabExists) {
      // Si la pestaña ya existe, muestra un toast de advertencia
      Fluttertoast.showToast(
        msg: "No se pueden tener tabs con el mismo nombre",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      // Si la pestaña no existe, crea la pestaña y limpia el campo de texto
      Provider.of<TabProvider>(context, listen: false)
          .addTab(_textController!.text, _icon!);
      Fluttertoast.showToast(
        msg: "Tab creado",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      _textController!.clear();
    }
  }

  // Define un widget para el botón de edición
// Define un widget para el botón de edición
  Widget editButton(TabData tabData) {
    // Retorna un botón elevado
    return ElevatedButton(
      // Cuando se presiona el botón
      onPressed: () {
        // Crea un nuevo controlador de texto con el texto del tabData
        _textController = TextEditingController(text: tabData.text);
        // Establece el icono actual al icono del tabData
        _icon = tabData.icon;
        // Encuentra el índice del tabData en la lista de tabs
        _tabIndex = Provider.of<TabProvider>(context, listen: false)
            .myTabs
            .indexOf(tabData);
        // Muestra un diálogo
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // Retorna un SimpleDialog
            return SimpleDialog(
              // Establece el título del SimpleDialog
              title: Text('Editar Tab'),
              // Define los hijos del SimpleDialog
              children: <Widget>[
                // Un campo de texto para editar el nombre del tab
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(hintText: "Nombre del Tab"),
                  ),
                ),
                // La lista de iconos para seleccionar un nuevo icono
                iconList(),
                // Un ButtonBar para los botones de acción
                ButtonBar(
                  children: <Widget>[
                    // Un botón para cancelar la edición
                    TextButton(
                      child: Text('Cancelar'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    // Un botón para confirmar la edición
                    TextButton(
                      child: Text('Confirmar edición'),
                      onPressed: () {
                        editTab();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
      child: Text('Editar'), // El texto que se muestra en el botón elevado
    );
  }

  Widget deleteButton(TabData tabData) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.red),
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmar eliminación'),
            content: Text('¿Estás seguro de que quieres eliminar este tab?'),
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
                  Provider.of<TabProvider>(context, listen: false).removeTab(
                      Provider.of<TabProvider>(context, listen: false)
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
    );
  }
}
