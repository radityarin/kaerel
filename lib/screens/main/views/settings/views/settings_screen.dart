import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.translate(
            offset: Offset(0, -50),
            child: Lottie.asset(
              'assets/train_loading.json', // Replace 'your_animation.json' with the path to your Lottie animation JSON file
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text('Loading...')
        ],
      ),
    );
  }
}
