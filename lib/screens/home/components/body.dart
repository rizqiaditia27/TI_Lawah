import 'package:flutter/material.dart';
import 'package:ti_lawah/screens/home/components/HeaderWithVoiceSearch.dart';
import 'package:ti_lawah/screens/home/components/TitleWithUnderline.dart';
import 'package:ti_lawah/screens/home/components/RecentAyat.dart';
import 'package:ti_lawah/models/Surah.dart';
import 'SurahCard.dart';
import 'package:ti_lawah/db/DBHelper.dart';
import 'package:ti_lawah/screens/murottal/home_screen.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final List<Surah> surahName = [];

  late DBHelper db;
  List<Surah> datas = [];
  bool fetching = true;

  void initState() {
    super.initState();
    db = DBHelper();
    getData();
  }

  void getData() async {
    this.datas = await db.getSurah();
    setState(() {
      fetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //mengambil ukuran layar
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        HeaderWithVoiceSearch(size: size),
        TitleWithUnderline(text: "Terakhir dibaca"),
        RecentAyat(size: size),
        Expanded(
          child: SizedBox(
            child: ListView.builder(
                itemCount: datas.length,
                itemBuilder: (context, index) {
                  return SurahCard(
                    surahName: datas[index],
                    size: size,
                    press: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ShowMurottalPerAyat(
                          idSurah: datas[index].id,
                          namaSurah: datas[index].namaSurah,
                        );
                      }));
                    },
                  );
                }),
          ),
        )
      ],
    );
  }
}
