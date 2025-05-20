import 'package:flutter/widgets.dart';

class SizeConfig {
  static double width = 0;
  static double height = 0;
  static double statusBar = 0;
  static double bottomBar = 0;

  static bool isPortrait = false;
  static bool isSmall = false;
  static bool isMobile = false;
  static bool isTablet = false;
  static bool isDesktop = false;
  static bool bottomNotch = false;

  static void initMediaQuery(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    width = mediaQuery.size.width;
    height = mediaQuery.size.height;
    statusBar = mediaQuery.padding.top;
    bottomBar = mediaQuery.viewPadding.bottom;
    bottomNotch = mediaQuery.viewPadding.bottom > 0;
  }

  static void initLayoutBuilder(BoxConstraints constraints, Orientation orientation) {
    width = constraints.maxWidth;
    height = constraints.maxHeight;
    isSmall = width <= 375;
    isMobile = width < 601;
    isTablet = width >= 601 && width < 1024;
    isDesktop = width >= 1100;
    isPortrait = orientation == Orientation.portrait;
  }
}

extension NumberExt on num {
  double get height => this * (SizeConfig.height / 100);
  double get width => this * (SizeConfig.width / 100);
  // ignore: non_constant_identifier_names
  double get _min_size => SizeConfig.isPortrait ? SizeConfig.width : SizeConfig.height;
  double get sp => this * ((_min_size / 3) / 100);
  double get widthRatio => this * (_min_size / 100);
}

extension ParseNullableInt on int? {
  int get parseInt => this ?? 0;
  double get parseDouble => this == null ? 0 : this!.toDouble();
  double get intToDouble => this == null ? 0 : this!.toDouble();
}
