import 'package:ti_lawah/constants.dart';
import 'package:flutter/material.dart';
import 'package:ti_lawah/models/Surah.dart';

class SurahCard extends StatelessWidget {
  final Surah surahName;

  const SurahCard({
    Key? key,
    required this.surahName,
    required this.size,
    required this.press,
  }) : super(key: key);

  final Size size;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
          padding: EdgeInsets.only(top: 25, left: 10),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                color: bluePrimary,
                child: Text(
                  surahName.id.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              Container(
                width: size.width * 0.78,
                padding: EdgeInsets.only(left: 20, top: 8, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      surahName.namaSurah,
                      style: TextStyle(fontSize: 19),
                    ),
                    Text(surahName.ayat.toString() + " ayat",
                        style: TextStyle(fontSize: 12, color: Colors.grey))
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.3, color: bluePrimary),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
