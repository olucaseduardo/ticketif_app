import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 128),
      child: Column(
        children: [
          Image.asset('assets/images/LOGO.png'),
          const SizedBox(
            height: 4,
          ),
          Image.asset('assets/images/TICKETIF.png'),
        ],
      ),
    );
  }
}
