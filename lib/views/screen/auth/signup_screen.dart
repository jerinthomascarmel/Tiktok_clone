import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/views/screen/auth/login_screen.dart';

import '../../../constants.dart';
import '../../widgets/text_input_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'TikTok clone',
            style: TextStyle(
                color: buttonColor, fontWeight: FontWeight.w800, fontSize: 35),
          ),
          const Text(
            'Register ',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
          ),
          const SizedBox(
            height: 15,
          ),
          Stack(
            children: [
              const CircleAvatar(
                radius: 64,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
              ),
              Positioned(
                bottom: -3,
                left: 90,
                child: IconButton(
                    onPressed: () => authController.pickImage(),
                    icon: const Icon(Icons.add_a_photo)),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: TextInputField(
                controller: _userController,
                icon: Icons.person,
                labeltext: 'Username'),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: TextInputField(
                controller: _emailController,
                icon: Icons.email,
                labeltext: 'email'),
          ),
          const SizedBox(
            height: 15,
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
            onTap: () => authController.registerUser(
                _userController.text,
                _emailController.text,
                _passwordController.text,
                authController.profilePhoto),
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: const Center(
                child: Text(
                  "Register",
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
                    builder: (context) => LoginScreen(),
                  ));
                },
                child: Text("  Login ",
                    style: TextStyle(fontSize: 20, color: buttonColor)),
              )
            ],
          )
        ]),
      ),
    ));
  }
}
