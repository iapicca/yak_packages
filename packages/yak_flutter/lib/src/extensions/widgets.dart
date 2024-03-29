import 'package:flutter/material.dart';

import '../widgets/all.dart';

/// applies [ThemeData] to a [PreferredSizeWidget]
extension PreferredSizeWidgetWithThemeX on PreferredSizeWidget {
  PreferredSizeWidget withTheme(ThemeData data) => PreferredSizeWidgetThemed(
        data: data,
        child: this,
      );
}
