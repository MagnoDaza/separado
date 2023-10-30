import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';

class ShowHideNameSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TabProvider>(
      builder: (context, tabProvider, child) {
        return SwitchListTile(
          title: const Text('Mostrar u ocultar nombre'),
          value: tabProvider.showText,
          onChanged: tabProvider.customNamesEnabled
              ? null
              : (bool value) {
// Desactiva el switch si "nombre e icono personalizado" está activado
                  tabProvider.toggleShowText();
                  Fluttertoast.showToast(
                    msg: tabProvider.showText
                        ? "Nombre mostrado"
                        : "Nombre ocultado",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                },
        );
      },
    );
  }
}
