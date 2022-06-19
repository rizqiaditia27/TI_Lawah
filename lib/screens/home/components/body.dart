import 'package:flutter/material.dart';
import 'package:ti_lawah/screens/home/components/HeaderWithVoiceSearch.dart';
import 'package:ti_lawah/screens/home/components/TitleWithUnderline.dart';
import 'package:ti_lawah/screens/home/components/RecentAyat.dart';
import 'package:ti_lawah/models/Surah.dart';
import '../../../constants.dart';
import 'SurahCard.dart';
import 'package:ti_lawah/db/DBHelper.dart';
import 'package:ti_lawah/screens/murottal/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int ayatRecent = 1;
  int surahRecent = 1;
  String namaSurah = "Al-Fatihah";

  //urusan recent ayat
  //method untuk manggil data yang tersimpan di shared preferences
  void getRecent() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ayatRecent = await pref.getInt("idAyat") ?? 0;
    surahRecent = await pref.getInt("idSurah") ?? 1;
    namaSurah = await pref.getString("namaSurah") ?? "Al-Fatihah";
    print(ayatRecent);
    setState(() {});
  }

  //urusan data surah
  final List<Surah> surahName = [];

  late DBHelper db;
  List<Surah> datas = [];
  bool fetching = true;

  void initState() {
    getRecent();
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
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          width: size.width * 0.87,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Surah " + namaSurah + " ayat " + ayatRecent.toString(),
                style: TextStyle(fontSize: 16),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                color: bluePrimary,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ShowMurottalPerAyat(
                      ayatTarget: ayatRecent,
                      idSurah: surahRecent,
                      namaSurah: namaSurah,
                    );
                  })).then((value) => getRecent());
                },
              )
            ],
          ),
        ),
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
                          ayatTarget: 0,
                          idSurah: datas[index].id,
                          namaSurah: datas[index].namaSurah,
                        );
                      })).then((value) => getRecent());
                    },
                  );
                }),
          ),
        )
      ],
    );
  }
}
