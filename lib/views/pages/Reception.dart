import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_kanso/auth/auth.dart';
import 'package:project_kanso/views/pages/sign_in.dart';
import 'package:project_kanso/views/widget_tree.dart';

class Reception extends StatefulWidget {
  const Reception({super.key});

  @override
  State<Reception> createState() => _ReceptionState();
}

class _ReceptionState extends State<Reception> {
  final auth = AuthService();
  bool _showAnimation = true;

  @override
  void initState() {
    super.initState();

    // Delay 2 seconds to show animation
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // ✅ ensures widget is still in the tree
        setState(() {
          _showAnimation = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showAnimation
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lotties/Doctor welcoming pacient.json',
                    height: 250,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          : StreamBuilder<User?>(
              stream: auth.authStateChanges,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  return const WidgetTree();
                }

                return const SignIn();
              },
            ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:project_kanso/auth/auth.dart';
// import 'package:project_kanso/views/pages/sign_in.dart';
// import 'package:project_kanso/views/widget_tree.dart';

// class Reception extends StatelessWidget {
//   const Reception({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final auth = AuthService();
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: auth.authStateChanges,
//         builder: (context, snapshot) {
//           // Still checking auth state
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Lottie.asset(
//                     'assets/lotties/Delivery Service-Delivery man.json',
//                     height: 250,
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     'Delivery Fire',
//                     style: TextStyle(
//                       fontSize: 27,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }

//           // 🔥 User is logged in → go to main widget tree
//           if (snapshot.hasData) {
//             return const WidgetTree();
//           }

//           // ❌ User is NOT logged in → go to Sign In
//           return const SignIn();
//         },
//       ),
//     );
//   }
// }
