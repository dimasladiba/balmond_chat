import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as type;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Register to Balmond Chat",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: txtFirstName,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person), hintText: "First Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: txtLastName,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person), hintText: "Last Name"),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: txtEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.email_outlined), hintText: "Email"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: txtPhone,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.phone), hintText: "Phone"),
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
                      onPressed: () async {
                        try {
                          final credetial = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: txtEmail.text,
                                  password: txtPassword.text);
                          await FirebaseChatCore.instance.createUserInFirestore(
                              type.User(
                                  id: credetial.user!.uid,
                                  firstName: txtFirstName.text,
                                  metadata: {
                                    "phone": txtPhone.text,
                                    "email": txtEmail.text
                                  },
                                  lastName: txtLastName.text));
                          showToast("Register success, please re-login");
                          Navigator.pop(context);
                        } on Exception catch (e) {
                          showToast(e.toString());
                        }
                      },
                      child: const Text("Register"))),
            ],
          ),
        ),
      ),
    );
  }
}
