import 'package:balmond_chat/home_page.dart';
import 'package:balmond_chat/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = true;
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void login() {
      try {
        //login via firebase
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: txtEmail.text, password: txtPassword.text)
            .then((value) {
          Navigator.of(context)
              .pushAndRemoveUntil(MaterialPageRoute(builder: (c) => const HomePage()),(route) => false,);
        });
      } on Exception catch (e) {
        showToast(e.toString());
      }
    }

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Login to Balmond Chat",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: txtEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.email), hintText: "Email"),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: txtPassword,
                  textInputAction: TextInputAction.done,
                  obscureText: showPassword,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    icon: Icon(Icons.password),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CheckboxListTile(
                  title: const Text("Show Password"),
                  value: !showPassword,
                  onChanged: (b) {
                    if (b != null) {
                      setState(() {
                        showPassword = !b;
                      });
                    }
                  }),
              const SizedBox(
                height: 30,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => login(), child: const Text("Login"))),
              Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => const RegisterPage()));
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.black),
                      ))),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
