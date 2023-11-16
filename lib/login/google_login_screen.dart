// ignore_for_file: use_build_context_synchronously
import 'package:admin_e_learning/course/ui/show_course_screen.dart';
import 'package:admin_e_learning/login/service/auth_firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GoogleLoginScreen extends StatefulWidget {
  const GoogleLoginScreen({super.key});

  @override
  State<GoogleLoginScreen> createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends State<GoogleLoginScreen> {
  bool loading = false;

  getData() async {
    setState(() {
      loading = true;
    });
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.pink,
                Colors.blue,
              ])),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      await GoogleServices().gmailLogin();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ShowCourseScreen(),
                        ),
                      );
                      Fluttertoast.showToast(
                          msg: 'Account Create Successfully');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/img.png',
                            width: 36,
                            height: 36,
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          const Text(
                            'Login With Gmail',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
