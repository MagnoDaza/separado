import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IconList extends StatefulWidget {
  @override
  _IconListState createState() => _IconListState();
}

class _IconListState extends State<IconList> {
  final int _iconsPerPage = 25;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final int _totalPages = (icons.length / _iconsPerPage).ceil();

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Center(
          child: PageView.builder(
            controller: _pageController,
            itemCount: _totalPages,
            itemBuilder: (BuildContext context, int page) {
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: (page < _totalPages - 1)
                    ? _iconsPerPage
                    : icons.length % _iconsPerPage,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio:
                      constraints.maxWidth / constraints.maxHeight,
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
        );
      },
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
  Icons.ac_unit,
  Icons.access_alarm,
  Icons.favorite,
  CupertinoIcons.add_circled,
  CupertinoIcons.heart_fill,
  CupertinoIcons.bell,
  CupertinoIcons.airplane,
  CupertinoIcons.alarm,
  CupertinoIcons.ant_circle_fill,
  Icons.ac_unit,
  Icons.access_alarm,
  Icons.favorite,
  CupertinoIcons.add_circled,
  CupertinoIcons.heart_fill,
  CupertinoIcons.bell,
  CupertinoIcons.airplane,
  CupertinoIcons.alarm,
  CupertinoIcons.ant_circle_fill,
  Icons.ac_unit,
  Icons.access_alarm,
  Icons.favorite,
  CupertinoIcons.add_circled,
  CupertinoIcons.heart_fill,
  CupertinoIcons.bell,
  CupertinoIcons.airplane,
  CupertinoIcons.alarm,
  CupertinoIcons.ant_circle_fill,
  Icons.ac_unit,
  Icons.access_alarm,
  Icons.favorite,
  CupertinoIcons.add_circled,
  CupertinoIcons.heart_fill,
  CupertinoIcons.bell,
  CupertinoIcons.airplane,
  CupertinoIcons.alarm,
  CupertinoIcons.ant_circle_fill,
  Icons.ac_unit,
  Icons.access_alarm,
  Icons.favorite,
  CupertinoIcons.add_circled,
  CupertinoIcons.heart_fill,
  CupertinoIcons.bell,
  CupertinoIcons.airplane,
  CupertinoIcons.alarm,
  CupertinoIcons.ant_circle_fill,
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
