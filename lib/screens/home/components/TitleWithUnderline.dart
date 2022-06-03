import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleWithUnderline extends StatelessWidget {
  const TitleWithUnderline({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        margin: EdgeInsets.only(left: 20),
        height: 24,
        child: Stack(
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                  color: Color(0xFF616161),
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      )
    ]);
  }
}
