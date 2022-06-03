class Ayat {
  final int id, ayat;
  final String text, arti;

  Ayat(
      {required this.id,
      required this.ayat,
      required this.text,
      required this.arti});

  factory Ayat.fromMap(Map<String, dynamic> json) => Ayat(
        id: json["id"],
        ayat: json["verseId"],
        text: json["ayahText"],
        arti: json["indoText"],
      );
}
