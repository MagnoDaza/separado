import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';

class EditTabsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<TabProvider>(context, listen: false).saveState();

    return AlertDialog(
      title: Text('Editar nombre del tab'),
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: Provider.of<TabProvider>(context).myTabs.length,
          itemBuilder: (context, index) {
            var tabData = Provider.of<TabProvider>(context).myTabs[index];
            return ListTile(
              key: Key(tabData.text),
              leading: Icon(tabData.icon),
              title: Text(tabData.text),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: tabData.showText,
                    onChanged: (bool? value) {
                      if (value != null) {
                        tabData.showText = value;
                        if (!tabData.showText && !tabData.showIcon) {
                          tabData.showIcon = true;
                        }
                      }
                    },
                  ),
                  Checkbox(
                    value: tabData.showIcon,
                    onChanged: (bool? value) {
                      if (value != null) {
                        tabData.showIcon = value;
                        if (!tabData.showText && !tabData.showIcon) {
                          tabData.showText = true;
                        }
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Provider.of<TabProvider>(context, listen: false).restoreState();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Confirmar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
