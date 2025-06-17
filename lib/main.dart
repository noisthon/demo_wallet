import 'package:flutter/material.dart';
import 'package:wallet/screens/on_boarding.screen.dart';
import 'package:wallet/screens/sign_up.screen.dart';

class MyColor {
  static const Color primary = Color(0xFF304FFE);
  static const Color lightGrey = Color(0xFFD0D0D0);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme: AppBarTheme(),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: MyColor.lightGrey,
                width: 2,
              ),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
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
          )),
      routes: {
        OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
      },
      initialRoute: OnBoardingScreen.routeName,
    );
  }
}
