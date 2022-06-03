import 'package:flutter/material.dart';

class FiturWarna extends StatelessWidget {
  const FiturWarna({
    required Key key,
    required this.color,
    required this.icon,
    required this.press,
    required this.size,
  }) : super(key: key);

  final Size size;
  final Color color;
  final String icon;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 20),
                blurRadius: 50,
                color: color.withOpacity(0.35),
              )
            ]),
        child: Column(
          children: <Widget>[
            Image.asset(icon),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            Text(
              "Audio Al-Qur'an per Ayat",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            Row(
              children: <Widget>[
                Text(
                  "30 Juz",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.right,
                ),
              ],
            )
          ],
        ),
        width: size.width * 0.4,
      ),
    );
  }
}
