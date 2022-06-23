import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ti_lawah/constants.dart';
import 'package:ti_lawah/screens/tafsir/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

class AyatCard extends StatefulWidget {
  AyatCard({
    Key? key,
    required this.audioId,
    required this.ayat,
    required this.arti,
    required this.nomorAyat,
    required this.idSurah,
    required this.audioPlayer,
    required this.audioCache,
    required this.namaSurah,
  }) : super(key: key);

  int audioId, nomorAyat, idSurah;
  final String ayat, arti, namaSurah;
  final AudioPlayer audioPlayer;
  final AudioCache audioCache;

  @override
  _AyatCardState createState() => _AyatCardState();
}

class _AyatCardState extends State<AyatCard> {
  ArabicNumbers arabicNumber = ArabicNumbers();

//urusan penanda ayat
//menyimpan idSurah,nama surah, dan nomor yang terakhir dibaca
  void saveAyat(int idSurah, String namaSurah, int idAyat) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("idSurah", idSurah);
    pref.setString("namaSurah", namaSurah);
    pref.setInt("idAyat", idAyat);
    setData(idSurah, idAyat);
  }

  void getRecent() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    recentAyat = await pref.getInt("idAyat");
    recentSurah = await pref.getInt("idSurah");
  }

  void setData(int idSurah, int idAyat) async {
    recentSurah = idSurah;
    recentAyat = idAyat;
    setState(() {});
  }

//urusan audio
  PlayerState playerState = PlayerState.PAUSED;
  bool isPlaying = false; // penanda apakah sedang diputar
  bool isPaused = false; // penanda apakah sedang dipause

//icon untuk tombol
  List<IconData> _icons = [
    Icons.pause_circle_filled,
    Icons.play_circle_fill,
  ];

  @override
  void initState() {
    //memanggil fungsi set data
    getRecent();

    super.initState();

//menyimpan state audio
    widget.audioPlayer.onPlayerStateChanged.listen((PlayerState s) => {
          setState(() {
            playerState = s;
          }),
        });

    //saat audio selesai diputar, playing dijadikan null
    widget.audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        playing = null;
      });
    });
  }

//menandai ayat mana yg sedang diputar
  void prosesAudio(int? wannaplay) {
    if (playing == null) {
      playAudio();
    } else if (wannaplay == playing) {
      pauseAudio();
    } else {
      resetButton();
      playAudio();
    }
  }

//mereset tombol dan playing
  void resetButton() {
    setState(() {
      playing = null;
    });
  }

//memutar audio
  playAudio() async {
    await widget.audioCache.loop("audios/${widget.audioId}.mp3");
    setState(() {
      playing = widget.audioId;
    });

    //await widget.audioCache.loop("audios/${playing}.mp3");
  }

//pause audio
  pauseAudio() async {
    await widget.audioPlayer.pause();
    resetButton();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 1.0, color: Colors.grey.shade300),
      )),
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 7),
      padding: EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Text(widget.idSurah.toString() +
                    ":" +
                    widget.nomorAyat.toString()),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                    color: Colors.grey.shade300),
              ),
              IconButton(
                icon: Icon(
                  widget.audioId == playing ? _icons[0] : _icons[1],
                  size: 37,
                  color: bluePrimary,
                ),
                padding: EdgeInsets.only(left: 6),
                onPressed: () {
                  setState(() {
                    wannaplay = widget.audioId;
                  });
                  prosesAudio(wannaplay);
                },
              ),
              CupertinoButton(
                  child: Icon(
                    CupertinoIcons.book,
                    size: 26,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Tafsir(
                        namaSurah: widget.namaSurah,
                        nomorAyat: widget.nomorAyat,
                        idSurah: widget.idSurah,
                      );
                    }));
                  }),
              IconButton(
                  icon: Icon(
                    Icons.attachment_outlined,
                    color: bluePrimary,
                  ),
                  onPressed: () async {
                    if (await confirm(
                      context,
                      title: const Text('Confirm'),
                      content: const Text('Tandai sebagai terakhir dibaca?'),
                      textOK: const Text('Yes'),
                      textCancel: const Text('No'),
                    )) {
                      saveAyat(
                          widget.idSurah, widget.namaSurah, widget.nomorAyat);
                      setState(() {
                        getRecent();
                      });
                    }
                  })
            ],
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  widget.ayat +
                      " " +
                      arabicNumber.convert(widget.nomorAyat).toString(),
                  style: TextStyle(
                    fontFamily: 'IsepMisbah',
                    fontSize: 20,
                    height: 2.5,
                  ),
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.visible,
                ),
              ),
              Align(
                child: Text(
                  widget.arti,
                  style: TextStyle(height: 1.5),
                ),
                alignment: Alignment.bottomLeft,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
