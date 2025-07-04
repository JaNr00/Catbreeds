import 'package:flutter/cupertino.dart';

class Responsive {
  double _width = 0;
  double _height = 0;
  bool _isTablet = false;
  bool _isLandscape = false;

  static Responsive of(BuildContext context) => Responsive(context);

  Responsive(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    _isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    _isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
  }

  bool isTablet() => _isTablet;
  bool isLandscape() => _isLandscape;
  double wp(double percent) => _width * percent / 100;
  double hp(double percent) => _height * percent / 100;
}
