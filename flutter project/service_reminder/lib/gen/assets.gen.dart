/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/ic_launcher.png
  AssetGenImage get icLauncher =>
      const AssetGenImage('assets/images/ic_launcher.png');

  $AssetsImagesIntroGen get intro => const $AssetsImagesIntroGen();

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/wave back.png
  AssetGenImage get waveBack =>
      const AssetGenImage('assets/images/wave back.png');

  /// List of all assets
  List<AssetGenImage> get values => [icLauncher, logo, waveBack];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  $AssetsSvgIconsGen get icons => const $AssetsSvgIconsGen();
  $AssetsSvgIntroGen get intro => const $AssetsSvgIntroGen();
}

class $AssetsImagesIntroGen {
  const $AssetsImagesIntroGen();

  /// File path: assets/images/intro/bakup.png
  AssetGenImage get bakup =>
      const AssetGenImage('assets/images/intro/bakup.png');

  /// File path: assets/images/intro/dark.png
  AssetGenImage get dark => const AssetGenImage('assets/images/intro/dark.png');

  /// File path: assets/images/intro/dark_mode.png
  AssetGenImage get darkMode =>
      const AssetGenImage('assets/images/intro/dark_mode.png');

  /// File path: assets/images/intro/easy_us.png
  AssetGenImage get easyUs =>
      const AssetGenImage('assets/images/intro/easy_us.png');

  /// File path: assets/images/intro/login.png
  AssetGenImage get login =>
      const AssetGenImage('assets/images/intro/login.png');

  /// List of all assets
  List<AssetGenImage> get values => [bakup, dark, darkMode, easyUs, login];
}

class $AssetsSvgIconsGen {
  const $AssetsSvgIconsGen();

  /// File path: assets/svg/icons/ac_belt.svg
  SvgGenImage get acBelt => const SvgGenImage('assets/svg/icons/ac_belt.svg');

  /// File path: assets/svg/icons/antifreeze.svg
  SvgGenImage get antifreeze =>
      const SvgGenImage('assets/svg/icons/antifreeze.svg');

  /// File path: assets/svg/icons/batry.svg
  SvgGenImage get batry => const SvgGenImage('assets/svg/icons/batry.svg');

  /// File path: assets/svg/icons/brake-fluid.svg
  SvgGenImage get brakeFluid =>
      const SvgGenImage('assets/svg/icons/brake-fluid.svg');

  /// File path: assets/svg/icons/car-filter.svg
  SvgGenImage get carFilter =>
      const SvgGenImage('assets/svg/icons/car-filter.svg');

  /// File path: assets/svg/icons/disc-brake.svg
  SvgGenImage get discBrake =>
      const SvgGenImage('assets/svg/icons/disc-brake.svg');

  /// File path: assets/svg/icons/oil.svg
  SvgGenImage get oil => const SvgGenImage('assets/svg/icons/oil.svg');

  /// File path: assets/svg/icons/oil_filter.svg
  SvgGenImage get oilFilter =>
      const SvgGenImage('assets/svg/icons/oil_filter.svg');

  /// File path: assets/svg/icons/spark-plug.svg
  SvgGenImage get sparkPlug =>
      const SvgGenImage('assets/svg/icons/spark-plug.svg');

  /// File path: assets/svg/icons/taire.svg
  SvgGenImage get taire => const SvgGenImage('assets/svg/icons/taire.svg');

  /// File path: assets/svg/icons/timing-belt.svg
  SvgGenImage get timingBelt =>
      const SvgGenImage('assets/svg/icons/timing-belt.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        acBelt,
        antifreeze,
        batry,
        brakeFluid,
        carFilter,
        discBrake,
        oil,
        oilFilter,
        sparkPlug,
        taire,
        timingBelt
      ];
}

class $AssetsSvgIntroGen {
  const $AssetsSvgIntroGen();

  /// File path: assets/svg/intro/bakup.svg
  SvgGenImage get bakup => const SvgGenImage('assets/svg/intro/bakup.svg');

  /// File path: assets/svg/intro/dark.svg
  SvgGenImage get dark => const SvgGenImage('assets/svg/intro/dark.svg');

  /// File path: assets/svg/intro/dark_mode.svg
  SvgGenImage get darkMode =>
      const SvgGenImage('assets/svg/intro/dark_mode.svg');

  /// File path: assets/svg/intro/easy_us.svg
  SvgGenImage get easyUs => const SvgGenImage('assets/svg/intro/easy_us.svg');

  /// File path: assets/svg/intro/login.svg
  SvgGenImage get login => const SvgGenImage('assets/svg/intro/login.svg');

  /// List of all assets
  List<SvgGenImage> get values => [bakup, dark, darkMode, easyUs, login];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
