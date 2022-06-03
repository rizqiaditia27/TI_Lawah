import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ti_lawah/constants.dart';
import 'package:ti_lawah/screens/tafsir/home_screen.dart';

class AyatCard extends StatefulWidget {
  const AyatCard({
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

  final int audioId, nomorAyat, idSurah;
  final String ayat, arti, namaSurah;
  final AudioPlayer audioPlayer;
  final AudioCache audioCache;

  @override
  _AyatCardState createState() => _AyatCardState();
}

class _AyatCardState extends State<AyatCard> {
  ArabicNumbers arabicNumber = ArabicNumbers();

//urusan audio
  PlayerState playerState = PlayerState.PAUSED;
  bool isPlaying = false;
  bool isPaused = false;

  List<IconData> _icons = [
    Icons.pause_circle_filled,
    Icons.play_circle_fill,
  ];

  @override
  void initState() {
    super.initState();

    widget.audioPlayer.onPlayerStateChanged.listen((PlayerState s) => {
          setState(() {
            playerState = s;
          }),
        });
    widget.audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        playing = null;
      });
    });
  }

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

  void resetButton() {
    setState(() {
      playing = null;
    });
  }

  playAudio() async {
    await widget.audioCache.loop("audios/${widget.audioId}.mp3");
    setState(() {
      playing = widget.audioId;
    });
  }

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
              IconButton(icon: Icon(Icons.bookmark_border), onPressed: () {})
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
