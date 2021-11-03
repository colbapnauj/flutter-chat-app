import 'package:flutter/material.dart';

class ButtonAzul extends StatelessWidget {
  @required
  final Function onPressed;
  @required
  final String text;
  const ButtonAzul({
    this.onPressed,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      onPressed: this.onPressed,
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(this.text,
              style: TextStyle(color: Colors.white, fontSize: 17)),
        ),
      ),
    );
  }
}
