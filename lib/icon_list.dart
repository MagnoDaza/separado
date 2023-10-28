// Importa los paquetes necesarios
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Define una clase StatefulWidget llamada IconList
class IconList extends StatefulWidget {
  @override
  _IconListState createState() =>
      _IconListState(); // Crea una instancia de _IconListState
}

// Define la clase State para IconList
class _IconListState extends State<IconList> {
  // Define el número de iconos por página
  final int _iconsPerPage = 25;
  // Crea un controlador de página para el PageView
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // Añade un listener al controlador de página para actualizar el estado cuando cambia la página
    _pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calcula el número total de páginas
    final int _totalPages = (icons.length / _iconsPerPage).ceil();

    return Center(
      child: PageView.builder(
        controller: _pageController,
        itemCount: _totalPages,
        itemBuilder: (BuildContext context, int page) {
          return GridView.builder(
            itemCount: (page < _totalPages - 1)
                ? _iconsPerPage
                : icons.length % _iconsPerPage,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5, // Número de columnas en la cuadrícula
            ),
            itemBuilder: (BuildContext context, int index) {
              int iconIndex = page * _iconsPerPage + index;
              return IconButton(
                icon: Icon(icons[
                    iconIndex]), // Muestra el icono en la posición iconIndex
                onPressed: () {
                  // Cuando se presiona un icono, cierra el diálogo y devuelve el icono seleccionado
                  Navigator.pop(context, icons[iconIndex]);
                },
              );
            },
          );
        },
      ),
    );
  }
}

// Define una lista constante de IconData para usar en el GridView
const List<IconData> icons = [
  Icons.ac_unit,
  Icons.access_alarm,
  Icons.favorite,
  CupertinoIcons.add_circled,
  CupertinoIcons.heart_fill,
  CupertinoIcons.bell,
  CupertinoIcons.airplane,
  CupertinoIcons.alarm,
  CupertinoIcons.ant_circle_fill,
];
