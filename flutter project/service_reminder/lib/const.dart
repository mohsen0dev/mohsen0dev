import 'package:flutter/material.dart';

class Constants {
  static Color bgColor = const Color(0xff6F43C0);
  static Color bg2Color = const Color(0xffEAE1F6);
  static Color bg3Color = const Color(0xffDED3EF);
  static Color btnColor = const Color(0xff6F43C0);
}

class MsizedBox extends StatelessWidget {
  final double? height;
  final double? width;
  // ignore: use_key_in_widget_constructors
  const MsizedBox([
    this.height,
    this.width,
  ]);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 16.0,
      width: width ?? 16.0,
    );
  }
}
