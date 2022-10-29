import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 128),
      child: Column(
        children: [
          Image.asset('assets/images/LOGO.png'),
          SizedBox(height: 4.h,),
          Image.asset('assets/images/TICKETIF.png'),
        ],
      ),
    );
  }
}
