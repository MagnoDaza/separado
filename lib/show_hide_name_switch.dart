//archivo: show_hide_name.dart

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
      },
    );
  }
}
