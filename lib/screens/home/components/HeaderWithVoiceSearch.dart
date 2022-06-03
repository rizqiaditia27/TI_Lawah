import 'package:flutter/material.dart';
import 'package:ti_lawah/constants.dart';

class HeaderWithVoiceSearch extends StatelessWidget {
  const HeaderWithVoiceSearch({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      //ukuran container 20% dari ukuran layar
      height: size.height * 0.10,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 17.0, bottom: 35),
            height: size.height * 0.12 - 25,
            decoration: BoxDecoration(
                color: bluePrimary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36.0),
                  bottomRight: Radius.circular(36.0),
                )),
            child: Row(
              children: <Widget>[
                Text(
                  'TI_Lawah',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 27),
                ),
                Spacer(),
                Image.asset("assets/images/logo.png")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
