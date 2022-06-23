import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:ti_lawah/constants.dart';
import 'package:ti_lawah/db/DBHelper.dart';
import 'package:ti_lawah/models/Ayat.dart';
import 'package:ti_lawah/screens/murottal/components/AyatCard.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ShowMurottalPerAyat extends StatefulWidget {
  const ShowMurottalPerAyat(
      {Key? key,
      required this.idSurah,
      required this.namaSurah,
      required this.ayatTarget})
      : super(key: key);
  final int idSurah;
  final String namaSurah;
  final int ayatTarget;

  @override
  _ShowMurottalPerAyatState createState() => _ShowMurottalPerAyatState();
}

class _ShowMurottalPerAyatState extends State<ShowMurottalPerAyat> {
  late DBHelper db;
  List<Ayat> datas = [];
  bool fetching = true;

  late AudioPlayer audioPlayer;
  late AudioCache audioCache;

  //urusan auto scroll
  final scrollController = AutoScrollController();

  @override
  void initState() {
    super.initState();
    db = DBHelper();
    getData();
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);

    if (widget.ayatTarget > 0) {
      scrollToIndex();
    }
  }

  void scrollToIndex() {
    scrollController.scrollToIndex(widget.ayatTarget - 1,
        preferPosition: AutoScrollPosition.begin);
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
          controller: scrollController,
          itemBuilder: (context, index) {
            return AutoScrollTag(
              key: ValueKey(index),
              controller: scrollController,
              index: index,
              child: AyatCard(
                audioId: datas[index].id,
                ayat: datas[index].text,
                arti: datas[index].arti,
                nomorAyat: datas[index].ayat,
                idSurah: widget.idSurah,
                audioPlayer: audioPlayer,
                audioCache: audioCache,
                namaSurah: widget.namaSurah,
              ),
            );
          }),
    );
  }
}
