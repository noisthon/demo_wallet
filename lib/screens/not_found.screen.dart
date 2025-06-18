import 'package:flutter/material.dart';
import 'package:wallet/utils/extensions.dart';

class NotFoundScreen extends StatelessWidget {
  static const routeName = "OnBoarding";

  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Placeholder(),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 17.5,
            ),
            child: "Error 404\nPage Not Found".text(34600,
                color: const Color(0xFF2a2a2a), textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 17.5,
            ),
            child:
                "Oops! It looks like the poge you're looking for doesnt exist Or hos been moved. Please try again or go to the nome pogo"
                    .text(14400,
                        color: const Color(0xFF2a2a2a),
                        textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.5, 24, 16.5, 30),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Back To Home"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
