//archivo icon_list.dart
// Importa el paquete necesario para usar los widgets de Flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Crea una clase que extienda de StatelessWidget
class IconList extends StatelessWidget {
  // Cambia la lista de IconData que contiene los iconos de Cupertino por una lista de IconData que contenga los iconos de Material que quieras mostrar
  final List<IconData> iconList = [
    Icons.favorite,
    CupertinoIcons.add_circled,
    CupertinoIcons.heart_fill,
    CupertinoIcons.bell,
    CupertinoIcons.airplane,
    CupertinoIcons.alarm,
    CupertinoIcons.ant_circle_fill,
    Icons.favorite_border,
    Icons.favorite_outline,
    Icons.favorite_rounded,
    Icons.favorite_sharp,
    Icons.favorite,
    Icons.favorite_border,
    Icons.favorite_outline,
    Icons.favorite_rounded,
    Icons.favorite_sharp,
    Icons.favorite,
    Icons.favorite_border,
    Icons.favorite_outline,
    Icons.favorite_rounded,
    Icons.favorite_sharp,
    Icons.favorite,
    Icons.favorite_border,
    Icons.favorite_outline,
    Icons.favorite_rounded,
    Icons.favorite_sharp,
    Icons.favorite,
    Icons.favorite_border,
    Icons.favorite_outline,
    Icons.favorite_rounded,
    Icons.favorite_sharp,
    Icons.favorite,
    Icons.favorite_border,
    Icons.favorite_outline,
    Icons.favorite_rounded,
    Icons.favorite_sharp,
    Icons.favorite,
    Icons.favorite_border,
    Icons.favorite_outline,
    Icons.favorite_rounded,
    Icons.favorite_sharp,
    // Añade más iconos según tus preferencias
  ];

  @override
  Widget build(BuildContext context) {
    // Calcula el número de páginas
    int numPages = (iconList.length / 25).ceil();

    // Divide la lista de iconos en páginas
    List<List<IconData>> iconPages = [];
    for (int i = 0; i < numPages; i++) {
      int start = i * 25;
      int end = start + 25;
      if (end > iconList.length) end = iconList.length;
      iconPages.add(iconList.sublist(start, end));
    }

    // Devuelve el widget que quieres extraer
    return Container(
      // Asigna un valor al alto del contenedor
      height: 300,
      // Usa un widget PageView para permitir deslizar entre las páginas de iconos
      child: PageView.builder(
        itemCount: numPages,
        itemBuilder: (context, pageIndex) {
          return Column(
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 5,
                  children: iconPages[pageIndex].map((icon) {
                    return InkWell(
                      child: Icon(icon),
                      onTap: () {
                        print(icon);
                        Navigator.of(context).pop();
                      },
                    );
                  }).toList(),
                ),
              ),
              Text(
                'Página ${pageIndex + 1} de $numPages',
              ),
            ],
          );
        },
      ),
    );
  }
}
