import 'package:flutter/material.dart';

enum Cores {
  green,
  red,
  yellow,
  blue;

  Color get color {
    return switch(this) {
      .green => Colors.green,
      .red => Colors.red,
      .yellow => Colors.yellow,
      .blue => Colors.blue,
    };
  }
}