import 'package:flutter/material.dart';

class ButtonBlue extends StatelessWidget {
  const ButtonBlue({
    Key? key,
    this.onPressed,
    required this.text,
  }) : super(key: key);

  final Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        shape: const StadiumBorder(
          side: BorderSide(width: 2, color: Colors.black),
        ),
        textStyle: const TextStyle(fontSize: 17),
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
