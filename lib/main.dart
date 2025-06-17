import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:wallet/blocs/app_bloc.dart';
import 'package:wallet/blocs/sign_in_bloc.dart';
import 'package:wallet/blocs/sign_up_bloc.dart';
import 'package:wallet/models/user.dart';
import 'package:wallet/screens/auth.screen.dart';
import 'package:wallet/screens/home.screen.dart';
import 'package:wallet/screens/on_boarding.screen.dart';
import 'package:wallet/screens/sign_in.screen.dart';
import 'package:wallet/screens/sign_up.screen.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/utils/extensions.dart';
import 'package:wallet/widgets/hide_keyboard.dart';
import 'package:wallet/widgets/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserImplAdapter());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  late final AppBloc appBloc;
  @override
  void initState() {
    appBloc = AppBloc();
    appBloc.authStateStream.listen((authState) {
      if (authState) {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          HomeScreen.routeName,
          (Route<dynamic> route) => false,
        );
      } else {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          AuthScreen.routeName,
          (Route<dynamic> route) => false,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => appBloc,
      child: StreamBuilder(
          stream: appBloc.themeStream,
          initialData: MyTheme.defaultTheme,
          builder: (context, asyncSnapshot) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              title: 'Flutter Demo',
              theme: asyncSnapshot.data,
              routes: {
                OnBoardingScreen.routeName: (context) =>
                    const OnBoardingScreen(),
                AuthScreen.routeName: (context) => const AuthScreen(),
                HomeScreen.routeName: (context) => const HomeScreen(),
                SignUpScreen.routeName: (context) => CustomProvider<SignUpBloc>(
                      create: (_) => SignUpBloc(),
                      child: const SignUpScreen(),
                    ),
                SignInScreen.routeName: (context) => CustomProvider<SignInBloc>(
                      create: (_) => SignInBloc(),
                      child: const SignInScreen(),
                    ),
              },
              initialRoute: AuthScreen.routeName,
              builder: (context, child) => HelperWidget(child: child),
            );
          }),
    );
  }
}
