import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final bool? adm;
  const AppLogo({Key? key, this.adm = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Column(
        children: [
          adm!
              ? Image.asset(
                  'assets/images/ADMLOGO.png',
                  width: 207,
                )
              : Image.asset(
                  'assets/images/LOGOTICKET.png',
                  width: 207,
                )
        ],
      ),
    );
  }
}
