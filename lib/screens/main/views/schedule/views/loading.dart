import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

Widget initialPlaceholderScreen() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Image.asset("assets/icon_search_with_train.png",
              width: 64, height: 64),
          const SizedBox(
            width: 16,
          ),
          Column(
            children: [
              const Text(
                'Mau cari info kereta apa nih?',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const Text(
                'Yuk cari stasiun keberangkatanmu\ndan tujuanmu diatas!',
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
