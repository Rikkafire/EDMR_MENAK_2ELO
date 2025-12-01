import 'package:flutter/material.dart';
import 'package:project_kanso/auth/auth.dart';
import 'package:project_kanso/views/pages/register_page.dart';
import 'package:project_kanso/views/widget_tree.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
            MediaQuery.of(context).size.width * 0.1,
            0,
            MediaQuery.of(context).size.width * 0.1,
            0,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.42,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          controller: emailController,
                          style: const TextStyle(
                            color: Colors.black, // <-- text color
                            fontSize: 16, // optional: change font size
                          ),
                          decoration: const InputDecoration(
                            icon: Icon(Icons.search),
                            border: InputBorder.none,
                            hintText: "Enter your email",
                            hintStyle: TextStyle(
                              color: Colors
                                  .grey, // optional: change hint text color
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          controller: passController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.lock),
                            border: InputBorder.none,
                            hintText: "Enter your password",
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          final error = await auth.signIn(
                            email: emailController.text.trim(),
                            password: passController.text.trim(),
                          );

                          if (error != null) {
                            ScaffoldMessenger.of(
                              // ignore: use_build_context_synchronously
                              context,
                            ).showSnackBar(SnackBar(content: Text(error)));
                          } else {
                            // Navigate to main app on success
                            if (!mounted) return;
                            Navigator.pushReplacement(
                              // ignore: use_build_context_synchronously
                              context,
                              MaterialPageRoute(
                                builder: (_) => const WidgetTree(),
                              ),
                            );
                          }
                        },
                        child: const Text("Sign In"),
                      ),
                      const SizedBox(height: 10),
                      // Go to Register Button
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegisterPage(),
                            ),
                          );
                        },
                        child: const Text("Don't have an account? Register"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
