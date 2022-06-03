import 'package:flutter/material.dart';

class LongCard extends StatelessWidget {
  const LongCard({
    required this.mainText,
    required this.secondaryText,
    required this.icon,
    required this.color,
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;
  final String mainText, secondaryText, icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(15, 20, 20, 17),
          margin: EdgeInsets.only(top: 15, bottom: 7),
          width: size.width * 0.87,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: color.withOpacity(0.4))
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(icon),
              Padding(padding: EdgeInsets.only(left: 35)),
              Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    mainText,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Color(0xFF616161),
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        secondaryText,
                        style: TextStyle(fontSize: 12),
                      ),

                      //Text("114 surah", style: TextStyle(fontSize: 12)),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          width: 76,
          margin: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
              color: color.withOpacity(0.45),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(30),
              )),
          height: 77,
        )
      ]),
    );
  }
}
