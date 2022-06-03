class Tafsir {
  final int surahId;
  final int ayatId;
  final String tafsir;

  const Tafsir({
    required this.surahId,
    required this.ayatId,
    required this.tafsir,
  });

  factory Tafsir.fromJson(Map<String, dynamic> json) {
    return Tafsir(
        surahId: json['surahId'], ayatId: json['id'], tafsir: json['tafsir']);
  }
}
