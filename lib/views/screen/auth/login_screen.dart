import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screen/auth/signup_screen.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'TikTok clone',
          style: TextStyle(
              color: buttonColor, fontWeight: FontWeight.w800, fontSize: 35),
        ),
        const Text(
          'login ',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: TextInputField(
              controller: _emailController,
              icon: Icons.email,
              labeltext: 'email'),
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: TextInputField(
            controller: _passwordController,
            icon: Icons.email,
            labeltext: 'password',
            isObscure: true,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        InkWell(
          onTap: () => authController.loginUser(
              _emailController.text, _passwordController.text),
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 50,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: const Center(
              child: Text(
                "Login",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account?",
                style: TextStyle(
                  fontSize: 20,
                )),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SignupScreen(),
                ));
              },
              child: Text("  Register ",
                  style: TextStyle(fontSize: 20, color: buttonColor)),
            )
          ],
        )
      ]),
    ));
  }
}
