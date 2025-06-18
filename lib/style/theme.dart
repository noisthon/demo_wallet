import 'package:flutter/material.dart';
import 'package:wallet/utils/extensions.dart';

abstract interface class MyColor {
  static const Color primary = Color(0xFF304FFE);
  static const Color lightGrey = Color(0xFFD0D0D0);
  static const Color grey = Color(0xFF565656);
  static const Color purple = Color(0xFF778bfe);
  static const Color orange = Color(0xFFfaa824);
  static const Color light = Color(0xFFf7f7f7);
}

abstract interface class MyTheme {
  static final defaultTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    primaryColor: MyColor.primary,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent
    ),
    scaffoldBackgroundColor:MyColor.light ,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: 16400.style(color: MyColor.lightGrey),
      prefixIconColor: MyColor.lightGrey,
      contentPadding: const EdgeInsets.all(14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: MyColor.lightGrey,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: MyColor.lightGrey,
          width: 1,
        ),
      ),
      focusColor: MyColor.primary,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: MyColor.primary,
          width: 1,
        ),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: MyColor.primary,
    ),
    textTheme: TextTheme(
      bodyMedium: 15400.style(color: MyColor.grey),
      // labelMedium: 15600.style()
      // bodyMedium: 17500.style(),
      // bodyLarge: 17500.style()
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.resolveWith((state) {
          if (state.contains(WidgetState.disabled)) {
            return 15600.style(color: MyColor.lightGrey);
          }
          return 15600.style(color: MyColor.lightGrey);
        }),
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.resolveWith((state) {
          if (state.contains(WidgetState.disabled)) {
            return Colors.grey[300];
          }
          return MyColor.primary;
        }),
        fixedSize: WidgetStateProperty.all(const Size.fromHeight(56)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        visualDensity: const VisualDensity(horizontal: 4),
        alignment: Alignment.center,
        enableFeedback: true,
        foregroundColor: WidgetStateProperty.resolveWith((state) {
          if (state.contains(WidgetState.disabled)) {
            return Colors.grey;
          }
          return Colors.white;
        }),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.resolveWith((state) {
          if (state.contains(WidgetState.disabled)) {
            return 15600.style(color: MyColor.lightGrey);
          }
          return 15600.style(color: MyColor.lightGrey);
        }),
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.resolveWith((state) {
          if (state.contains(WidgetState.disabled)) {
            return Colors.grey[300];
          }
          return Colors.transparent;
        }),
        fixedSize: WidgetStateProperty.all(const Size.fromHeight(56)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        side: WidgetStateProperty.all(
          const BorderSide(
            width: 2,
            color: MyColor.primary,
          ),
        ),
        visualDensity: const VisualDensity(horizontal: 4),
        alignment: Alignment.center,
        enableFeedback: true,
        foregroundColor: WidgetStateProperty.resolveWith((state) {
          if (state.contains(WidgetState.disabled)) {
            return Colors.grey;
          }
          return MyColor.primary;
        }),
      ),
    ),
  );
}
