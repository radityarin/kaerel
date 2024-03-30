import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget loadingScreen() {
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
              const SizedBox(
                height: 40,
              ),
              const Text('Loading...')
            ],
          ),
        );
}