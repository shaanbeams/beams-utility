import 'package:flutter/cupertino.dart';

Widget MinWindowSize(Widget) {
  return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 300, // Minimum width you want
        minHeight: 500, // Minimum height you want
      ),
      child: Widget);
}
