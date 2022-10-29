import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/widgets/app_logo.dart';
import 'package:project_ifma_ticket/features/resources/widgets/commonTextField.dart';


import '../../../home/ui/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppLogo(),
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Text("Entre para continuar", style: TextStyle(fontSize: 16.sp, color: AppColors.gray400),),
              ),
              Form(
                  child: Column(
                children: [
                  const CommonTextField(title: 'Matrícula', labelText: 'Digite sua matrícula', textInputAction: TextInputAction.next,),
                  const CommonTextField(title: 'Senha (SUAP)', labelText: 'Digite sua senha', textInputAction: TextInputAction.done,obscureText: true,),
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const HomeScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green500,
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.h),
                          child: Text("Entrar na conta",
                              style: TextStyle(fontSize: 14.sp)
                        ),),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
