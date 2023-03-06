import 'package:flutter/material.dart';
import 'package:graphiceranotification/utils/sizeConfig.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final height, width;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: height,
        width: width,
        child: InkWell(
          onTap: onPressed,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: const Color(0xFF000C45),
              child: Center(
                  child: Text(
                text,
                style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Roboto',
                    fontSize: 14.5,
                    color: Colors.white),
              ))),
        ),
      ),
    );
  }
}
