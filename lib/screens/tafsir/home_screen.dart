import 'package:flutter/material.dart';
import 'package:ti_lawah/API/Repository.dart';

class Tafsir extends StatefulWidget {
  const Tafsir(
      {Key? key,
      required this.namaSurah,
      required this.idSurah,
      required this.nomorAyat})
      : super(key: key);

  final String namaSurah;
  final int nomorAyat, idSurah;

  @override
  State<Tafsir> createState() => _TafsirState();
}

class _TafsirState extends State<Tafsir> {
  String tafsir = "";
  Repository repo = Repository();

  getData() async {
    tafsir = await repo.getData(widget.idSurah, widget.nomorAyat);
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        child: Column(children: [
          Text(
            "Surah " +
                widget.namaSurah +
                " ayat " +
                widget.nomorAyat.toString(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(padding: EdgeInsets.only(bottom: 15)),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              tafsir,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ]),
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    elevation: 0,
    title: Text(
      'Tafsir Singkat',
      style: TextStyle(
          fontFamily: 'Roboto', fontSize: 22, fontWeight: FontWeight.bold),
    ),
  );
}
