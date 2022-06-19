import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../murottal/home_screen.dart';

class RecentAyat extends StatefulWidget {
  const RecentAyat({
    Key? key,
    required this.namaSurah,
    required this.nomorAyat,
    required this.size,
    required this.idSurah,
  }) : super(key: key);

  final Size size;
  final String namaSurah;
  final int nomorAyat, idSurah;

  @override
  State<RecentAyat> createState() => _RecentAyatState();
}

class _RecentAyatState extends State<RecentAyat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      width: widget.size.width * 0.87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Surah " +
                widget.namaSurah +
                " ayat " +
                widget.nomorAyat.toString(),
            style: TextStyle(fontSize: 16),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            color: bluePrimary,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ShowMurottalPerAyat(
                  ayatTarget: widget.nomorAyat,
                  idSurah: widget.idSurah,
                  namaSurah: widget.namaSurah,
                );
              }));
            },
          )
        ],
      ),
    );
  }
}
