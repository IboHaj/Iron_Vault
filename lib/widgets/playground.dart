import 'package:flutter/widget_previews.dart';
import 'package:flutter/material.dart'; // For Material widgets

@Preview(name: 'List Tile')
Widget mListTile() {
  return Container(
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
    child: Row(
      mainAxisSize: .max,
      crossAxisAlignment: .center,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: .center,
            children: [
              Text(
                "Ti",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.black),
              ),
              VerticalDivider(width: 20, thickness: 100, color: Colors.grey),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: .center,
            spacing: 5,
            children: [
              Text(
                "Title/Appname",
                style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w900),
              ),
              Text(
                "Username",
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
