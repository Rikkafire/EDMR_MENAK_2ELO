import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ReceptionPage extends StatelessWidget {
  const ReceptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.blue[100],
          ),

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lotties/Doctor welcoming pacient.json'),
                ElevatedButton(onPressed: () {}, child: const Text('Sign In')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
