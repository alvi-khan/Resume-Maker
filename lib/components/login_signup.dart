import 'package:flutter/material.dart';
import 'package:the_pixel_pioneers/services/authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Resume Creator",
            style: TextStyle(
              color: Colors.black,
              fontSize: 44.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 44.0,
          ),
          const Text(
            "Login",
            style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30.0,
          ),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "User Email",
              prefixIcon: Icon(Icons.mail, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 26.0,
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "User Password",
              prefixIcon: Icon(Icons.lock, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          const Text(
            "Don't Remember your Password?",
            style: TextStyle(color: Colors.blue),
          ),
          const SizedBox(
            height: 88.0,
          ),
          Container(
            width: double.infinity,
            child: Button(
              onPressed: () => Authentication.loginUsingEmailPassword(
                  email: _emailController.text,
                  password: _passwordController.text
              ),
              text: "Login",
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Container(
            width: double.infinity,
            child: Button(
              onPressed: () => Authentication.signInWithGoogle(),
              text: "Google Login",
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Container(
            width: double.infinity,
            child: Button(
              onPressed: () => Authentication.createUser(
                  email: _emailController.text,
                  password: _passwordController.text
              ),
              text: "Sign Up",
            ),
          )
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({super.key, required this.onPressed, required this.text});

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF0069FE),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)
          ),
        ),
        child: Text(text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )
        )
    );
  }
}