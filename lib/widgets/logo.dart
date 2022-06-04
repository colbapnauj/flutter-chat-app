import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String image;

  final String text;

  const Logo({required this.image, required this.text});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Image(image: AssetImage(image)),
            SizedBox(
              height: 20,
            ),
            Text(this.text, style: TextStyle(fontSize: 20))
          ],
        ),
      ),
    );
  }
}
