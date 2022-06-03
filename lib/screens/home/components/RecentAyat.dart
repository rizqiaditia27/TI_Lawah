import 'package:flutter/material.dart';

class RecentAyat extends StatelessWidget {
  const RecentAyat({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      width: size.width * 0.87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Surah Ali Imron ayat 5",
            style: TextStyle(fontSize: 16),
          ),
          Icon(
            Icons.delete_outline,
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
