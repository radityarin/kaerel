import 'package:flutter/material.dart';
import 'package:kaerel/resources/colors/colors.dart';

Widget customDivider(double dividerHeight) {
  return SizedBox(height: dividerHeight);
}

Widget mainButton(String text, bool isEnable, VoidCallback onConfirmation) {
  return GestureDetector(
    onTap: () {
      onConfirmation();
    },
    child: Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32), color: isEnable ? KaerelColor.green1 : KaerelColor.greyBorder),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
    ),
  );
}
