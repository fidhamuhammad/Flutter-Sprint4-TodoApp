import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoapp/login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void changeScreen() {
    Future.delayed(
      const Duration(seconds: 20),
      () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 189, 182, 250),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Todos_Logo.svg/1200px-Todos_Logo.svg.png',
              height: 70,
              width: 70,
            ),
            const Text('TODOS'),
            Icon(
              FontAwesomeIcons.addressCard,
              size: 50,
              color: Color.fromARGB(255, 127, 117, 216),
            ),
          ],
        ),
      ),
    );
  }
}
