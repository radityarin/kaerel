import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaerel/screens/main/views/schedule/views/loading.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return loadingScreen();
  }
}
