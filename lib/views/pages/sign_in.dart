import 'package:flutter/material.dart';
import 'package:project_kanso/views/widget_tree.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

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
            height: MediaQuery.of(context).size.height * 0.40,
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
                  child: Container(
                    child: Column(
                      children: [
                        SearchBar(hintText: '  Enter your Username'),
                        SizedBox(height: 20),
                        SearchBar(hintText: '  Enter your Password'),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (context) => const WidgetTree(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              65,
                              91,
                              111,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
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
