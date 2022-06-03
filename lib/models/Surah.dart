class Surah {
  final int id;
  final String namaSurah;
  final int ayat;

  Surah({required this.id, required this.namaSurah, required this.ayat});

  factory Surah.fromMap(Map<String, dynamic> json) => Surah(
      id: json["surahId"], namaSurah: json["surahName"], ayat: json["ayat"]);

  Map<String, dynamic> toMap() =>
      {"id": id, "namaSurah": namaSurah, "ayat": ayat};
}
