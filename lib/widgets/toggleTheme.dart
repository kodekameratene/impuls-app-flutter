import 'package:flutter/material.dart';
import 'package:impuls/providers/AppSettings.dart';
import 'package:provider/provider.dart';

class ToggleThemeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorProvider colorTheme = Provider.of<ColorProvider>(context);
    return Container(
      child: ToggleButtons(
        borderColor: colorTheme.mainColor,
        fillColor: colorTheme.isLightThemeActive
            ? colorTheme.mainColor
            : Colors.white30,
        children: <Widget>[
          Icon(
            Icons.brightness_1,
            color: colorTheme.isLightThemeActive
                ? Colors.amber
                : colorTheme.mainColor,
          ),
          Icon(Icons.brightness_3,
              color: !colorTheme.isLightThemeActive
                  ? Colors.amber
                  : colorTheme.mainColor),
        ],
        isSelected: <bool>[
          colorTheme.isLightThemeActive,
          !colorTheme.isLightThemeActive,
        ],
        onPressed: (int index) {
          colorTheme.toggleTheme();
        },
      ),
    );
  }
}
