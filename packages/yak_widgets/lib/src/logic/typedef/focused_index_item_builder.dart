import 'package:flutter/material.dart';

/// a widget builder for `FocusedIndexList`
typedef FocusedIndexedItemBuilder = Widget Function(
  BuildContext context,
  int index,
  bool selected,
);
