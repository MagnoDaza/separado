import 'package:flutter/material.dart';

class ShowHideNameSwitch extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  ShowHideNameSwitch({required this.initialValue, required this.onChanged});

  @override
  _ShowHideNameSwitchState createState() => _ShowHideNameSwitchState();
}

class _ShowHideNameSwitchState extends State<ShowHideNameSwitch> {
  bool? currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text('Mostrar u ocultar nombre'),
      value: currentValue!,
      onChanged: (bool value) {
        setState(() {
          currentValue = value;
        });
        widget.onChanged(value);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Aviso'),
              content: Text(value
                  ? 'Has seleccionado mostrar el nombre de los tabs.'
                  : 'Has seleccionado ocultar el nombre de los tabs.'),
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
  }
}
