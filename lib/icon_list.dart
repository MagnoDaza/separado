import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IconList extends StatefulWidget {
  @override
  _IconListState createState() => _IconListState();
}

class _IconListState extends State<IconList> {
  final int _iconsPerPage = 25;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final int _totalPages = (icons.length / _iconsPerPage).ceil();

    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Text('Selecciona un icono',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Container(
            height: MediaQuery.of(context).size.height /
                3, // Ajusta esto según tus necesidades
            child: PageView.builder(
              controller: _pageController,
              itemCount: _totalPages,
              itemBuilder: (BuildContext context, int page) {
                return GridView.builder(
                  itemCount: (page < _totalPages - 1)
                      ? _iconsPerPage
                      : icons.length % _iconsPerPage,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    int iconIndex = page * _iconsPerPage + index;
                    return IconButton(
                      icon: Icon(icons[iconIndex]),
                      onPressed: () {
                        Navigator.pop(context, icons[iconIndex]);
                      },
                    );
                  },
                );
              },
            ),
          ),
          Text('Página ${_currentPage + 1} de $_totalPages'),
        ],
      ),
    );
  }
}

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
  Icons.favorite_border,
  Icons.favorite_outline,
  Icons.favorite_rounded,
  Icons.favorite_sharp,
  Icons.favorite_border_outlined, // Añade más íconos aquí
];
