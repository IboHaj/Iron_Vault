import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class MaterialTheme {
  final textTheme = TextTheme(
    displayLarge: GoogleFonts.inter().copyWith(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
    displayMedium: GoogleFonts.inter().copyWith(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
    displaySmall: GoogleFonts.inter().copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    headlineLarge: GoogleFonts.spaceGrotesk().copyWith(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),
    headlineMedium: GoogleFonts.spaceGrotesk().copyWith(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
    headlineSmall: GoogleFonts.spaceGrotesk().copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
    titleLarge: GoogleFonts.spaceGrotesk().copyWith(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.spaceGrotesk().copyWith(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
    titleSmall: GoogleFonts.spaceGrotesk().copyWith(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
    bodyLarge: GoogleFonts.robotoSerif().copyWith(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
    bodyMedium: GoogleFonts.robotoSerif().copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
    bodySmall: GoogleFonts.robotoSerif().copyWith(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),
    labelLarge: GoogleFonts.inter().copyWith(color: Colors.blue, fontSize: 24, fontWeight: FontWeight.w600),
    labelMedium: GoogleFonts.inter().copyWith(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w600),
    labelSmall: GoogleFonts.inter().copyWith(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600),
  );

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff705d00),
      surfaceTint: Color(0xff705d00),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffd700),
      onPrimaryContainer: Color(0xff705e00),
      secondary: Color(0xff171818),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2c2c2c),
      onSecondaryContainer: Color(0xff949393),
      tertiary: Color(0xff00696f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff00f1ff),
      onTertiaryContainer: Color(0xff006a70),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffdf8f8),
      onSurface: Color(0xff1c1b1b),
      onSurfaceVariant: Color(0xff4d4732),
      outline: Color(0xff7e775f),
      outlineVariant: Color(0xffd0c6ab),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffe9c400),
      primaryFixed: Color(0xffffe16d),
      onPrimaryFixed: Color(0xff221b00),
      primaryFixedDim: Color(0xffe9c400),
      onPrimaryFixedVariant: Color(0xff544600),
      secondaryFixed: Color(0xffe4e2e1),
      onSecondaryFixed: Color(0xff1b1c1c),
      secondaryFixedDim: Color(0xffc8c6c5),
      onSecondaryFixedVariant: Color(0xff474747),
      tertiaryFixed: Color(0xff79f5ff),
      onTertiaryFixed: Color(0xff002022),
      tertiaryFixedDim: Color(0xff00dbe8),
      onTertiaryFixedVariant: Color(0xff004f54),
      surfaceDim: Color(0xffddd9d8),
      surfaceBright: Color(0xfffdf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e6),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff413500),
      surfaceTint: Color(0xff705d00),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff816c00),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff171818),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2c2c2c),
      onSecondaryContainer: Color(0xffbab8b8),
      tertiary: Color(0xff003d41),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff007980),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffdf8f8),
      onSurface: Color(0xff111111),
      onSurfaceVariant: Color(0xff3c3622),
      outline: Color(0xff59523d),
      outlineVariant: Color(0xff746d56),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffe9c400),
      primaryFixed: Color(0xff816c00),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff645400),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6e6d6d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff555554),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff007980),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff005e64),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc9c6c5),
      surfaceBright: Color(0xfffdf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f3f2),
      surfaceContainer: Color(0xffebe7e6),
      surfaceContainerHigh: Color(0xffe0dcdb),
      surfaceContainerHighest: Color(0xffd4d1d0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff352b00),
      surfaceTint: Color(0xff705d00),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff574800),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff171818),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2c2c2c),
      onSecondaryContainer: Color(0xffe7e5e4),
      tertiary: Color(0xff003235),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff005257),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffdf8f8),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff312c19),
      outlineVariant: Color(0xff4f4934),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffe9c400),
      primaryFixed: Color(0xff574800),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff3d3200),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff494949),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff333333),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff005257),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff00393d),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbbb8b7),
      surfaceBright: Color(0xfffdf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f0ef),
      surfaceContainer: Color(0xffe5e2e1),
      surfaceContainerHigh: Color(0xffd7d4d3),
      surfaceContainerHighest: Color(0xffc9c6c5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffff6df),
      surfaceTint: Color(0xffe9c400),
      onPrimary: Color(0xff3a3000),
      primaryContainer: Color(0xffffd700),
      onPrimaryContainer: Color(0xff705e00),
      secondary: Color(0xffc8c6c5),
      onSecondary: Color(0xff303030),
      secondaryContainer: Color(0xff2c2c2c),
      onSecondaryContainer: Color(0xff949393),
      tertiary: Color(0xffdefcff),
      onTertiary: Color(0xff00363a),
      tertiaryContainer: Color(0xff00f1ff),
      onTertiaryContainer: Color(0xff006a70),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff141313),
      onSurface: Color(0xffe5e2e1),
      onSurfaceVariant: Color(0xffd0c6ab),
      outline: Color(0xff999077),
      outlineVariant: Color(0xff4d4732),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff705d00),
      primaryFixed: Color(0xffffe16d),
      onPrimaryFixed: Color(0xff221b00),
      primaryFixedDim: Color(0xffe9c400),
      onPrimaryFixedVariant: Color(0xff544600),
      secondaryFixed: Color(0xffe4e2e1),
      onSecondaryFixed: Color(0xff1b1c1c),
      secondaryFixedDim: Color(0xffc8c6c5),
      onSecondaryFixedVariant: Color(0xff474747),
      tertiaryFixed: Color(0xff79f5ff),
      onTertiaryFixed: Color(0xff002022),
      tertiaryFixedDim: Color(0xff00dbe8),
      onTertiaryFixedVariant: Color(0xff004f54),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2b2a2a),
      surfaceContainerHighest: Color(0xff353434),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffff6df),
      surfaceTint: Color(0xffe9c400),
      onPrimary: Color(0xff3a3000),
      primaryContainer: Color(0xffffd700),
      onPrimaryContainer: Color(0xff4f4200),
      secondary: Color(0xffdedcdb),
      onSecondary: Color(0xff252626),
      secondaryContainer: Color(0xff929090),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffdefcff),
      onTertiary: Color(0xff00363a),
      tertiaryContainer: Color(0xff00f1ff),
      onTertiaryContainer: Color(0xff004b50),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffe6dcc0),
      outline: Color(0xffbbb197),
      outlineVariant: Color(0xff989077),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff564700),
      primaryFixed: Color(0xffffe16d),
      onPrimaryFixed: Color(0xff161100),
      primaryFixedDim: Color(0xffe9c400),
      onPrimaryFixedVariant: Color(0xff413500),
      secondaryFixed: Color(0xffe4e2e1),
      onSecondaryFixed: Color(0xff111111),
      secondaryFixedDim: Color(0xffc8c6c5),
      onSecondaryFixedVariant: Color(0xff363636),
      tertiaryFixed: Color(0xff79f5ff),
      onTertiaryFixed: Color(0xff001416),
      tertiaryFixedDim: Color(0xff00dbe8),
      onTertiaryFixedVariant: Color(0xff003d41),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff454444),
      surfaceContainerLowest: Color(0xff080707),
      surfaceContainerLow: Color(0xff1e1d1d),
      surfaceContainer: Color(0xff282827),
      surfaceContainerHigh: Color(0xff333232),
      surfaceContainerHighest: Color(0xff3e3d3d),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffff6df),
      surfaceTint: Color(0xffe9c400),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffd700),
      onPrimaryContainer: Color(0xff2c2300),
      secondary: Color(0xfff2efef),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc4c2c2),
      onSecondaryContainer: Color(0xff0b0b0b),
      tertiary: Color(0xffdefcff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff00f1ff),
      onTertiaryContainer: Color(0xff00292c),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfffaefd2),
      outlineVariant: Color(0xffccc2a7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff564700),
      primaryFixed: Color(0xffffe16d),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffe9c400),
      onPrimaryFixedVariant: Color(0xff161100),
      secondaryFixed: Color(0xffe4e2e1),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc8c6c5),
      onSecondaryFixedVariant: Color(0xff111111),
      tertiaryFixed: Color(0xff79f5ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff00dbe8),
      onTertiaryFixedVariant: Color(0xff001416),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff51504f),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff201f1f),
      surfaceContainer: Color(0xff313030),
      surfaceContainerHigh: Color(0xff3c3b3b),
      surfaceContainerHighest: Color(0xff484646),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
