import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:wallet/blocs/additional_info_bloc.dart';
import 'package:wallet/blocs/app_bloc.dart';
import 'package:wallet/blocs/home_bloc.dart';
import 'package:wallet/blocs/send_money_bloc.dart';
import 'package:wallet/blocs/sign_in_bloc.dart';
import 'package:wallet/blocs/sign_up_bloc.dart';
import 'package:wallet/models/additional_info.dart';
import 'package:wallet/models/user.dart';
import 'package:wallet/screens/additional_info.screen.dart';
import 'package:wallet/screens/auth.screen.dart';
import 'package:wallet/screens/home.screen.dart';
import 'package:wallet/screens/not_found.screen.dart';
import 'package:wallet/screens/on_boarding.screen.dart';
import 'package:wallet/screens/qr_reader.screen.dart';
import 'package:wallet/screens/send_modey.screen.dart';
import 'package:wallet/screens/sign_in.screen.dart';
import 'package:wallet/screens/sign_up.screen.dart';
import 'package:wallet/screens/transaction_complete.screen.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/widgets/hide_keyboard.dart';
import 'package:wallet/widgets/provider.dart';

late List<CameraDescription> cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Hive.initFlutter();
  Hive.registerAdapter(UserImplAdapter());
  Hive.registerAdapter(AdditionalInfoImplAdapter());
  // Hive.deleteBoxFromDisk("auth");
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
  late final StreamSubscription authStateSubscription;

  @override
  void initState() {
    appBloc = AppBloc();
    authStateSubscription = appBloc.authUserStream.listen((user) {
      if (user != null) {
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
    authStateSubscription.cancel();
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
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: asyncSnapshot.data,
              onUnknownRoute: (settings) => MaterialPageRoute<void>(
                settings:
                    settings, // It's good practice to pass the original settings
                builder: (BuildContext context) => const NotFoundScreen(),
              ),
              routes: {
                OnBoardingScreen.routeName: (context) =>
                    const OnBoardingScreen(),
                QrReaderScreen.routeName: (context) => const QrReaderScreen(),
                TransactionCompleteScreen.routeName: (context) =>
                    const TransactionCompleteScreen(),
                AuthScreen.routeName: (context) => const AuthScreen(),
                SendModeyScreen.routeName: (context) => CustomProvider(
                    create: (_) => SendMoneyBloc(),
                    child: const SendModeyScreen()),
                HomeScreen.routeName: (context) => CustomProvider(
                      create: (_) => HomeBloc(),
                      child: const HomeScreen(),
                    ),
                SignUpScreen.routeName: (context) => CustomProvider(
                      create: (_) => SignUpBloc(),
                      child: const SignUpScreen(),
                    ),
                AdditionalInfoScreen.routeName: (context) =>
                    CustomProvider<AdditionalInfoBloc>(
                      create: (_) => AdditionalInfoBloc(),
                      child: const AdditionalInfoScreen(),
                    ),
                SignInScreen.routeName: (context) => CustomProvider(
                      create: (_) => SignInBloc(),
                      child: const SignInScreen(),
                    ),
              },
              initialRoute: OnBoardingScreen.routeName,
              builder: (context, child) => HelperWidget(child: child),
            );
          }),
    );
  }
}
