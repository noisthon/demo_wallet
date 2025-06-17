import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/blocs/app_bloc.dart';
import 'package:wallet/utils/extensions.dart';
import 'package:wallet/widgets/app_bar.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "Home";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AppBloc>().signOut();
          },
          child: "Sign out".txt,
        ),
      ),
    );
  }
}
