import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:ti_lawah/constants.dart';
import 'package:ti_lawah/db/DBHelper.dart';
import 'package:ti_lawah/models/Ayat.dart';
import 'package:ti_lawah/screens/murottal/components/AyatCard.dart';

class ShowMurottalPerAyat extends StatefulWidget {
  const ShowMurottalPerAyat(
      {Key? key, required this.idSurah, required this.namaSurah})
      : super(key: key);
  final int idSurah;
  final String namaSurah;

  @override
  _ShowMurottalPerAyatState createState() => _ShowMurottalPerAyatState();
}

class _ShowMurottalPerAyatState extends State<ShowMurottalPerAyat> {
  late DBHelper db;
  List<Ayat> datas = [];
  bool fetching = true;

  late AudioPlayer audioPlayer;
  late AudioCache audioCache;

  @override
  void initState() {
    super.initState();
    db = DBHelper();
    getData();
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);
  }

  void getData() async {
    this.datas = await db.getAyat(widget.idSurah);
    setState(() {
      fetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.idSurah.toString() + ". " + widget.namaSurah,
          style: TextStyle(
              fontFamily: 'Roboto', fontSize: 22, fontWeight: FontWeight.bold),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            audioPlayer.release();
            audioCache.clearAll();
            playing = null;
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
          itemCount: datas.length,
          itemBuilder: (context, index) {
            return AyatCard(
              audioId: datas[index].id,
              ayat: datas[index].text,
              arti: datas[index].arti,
              nomorAyat: datas[index].ayat,
              idSurah: widget.idSurah,
              audioPlayer: audioPlayer,
              audioCache: audioCache,
              namaSurah: widget.namaSurah,
            );
          }),
    );
  }
}
