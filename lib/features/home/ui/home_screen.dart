import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_options.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 78.h,
        elevation: 0,
        backgroundColor: AppColors.green500,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateUtil.todayDate(dateTime), style: TextStyle(fontSize: 18.sp, fontWeight:FontWeight.w700 ),),
              Text('20191BCC.CAX0003', style: TextStyle(fontSize: 10.sp,),)

            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.logout,
              ))
        ],
      ),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Olá, Fulano de tal', style: TextStyle(fontSize: 18.sp, fontWeight:FontWeight.w700, color: AppColors.gray200)),
                ElevatedButton(

                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.green500,
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.h),
                      child: Text("Solicitar um ticket",
                          style: TextStyle(fontSize: 12.sp,fontWeight:FontWeight.w700, )
                      ),),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1,thickness: 1.5, color: AppColors.gray800,),
          Padding(
            padding: EdgeInsets.all(20.h),
            child: Text('Suas refeições de hoje', style: TextStyle(fontSize: 18.sp, fontWeight:FontWeight.w700, color: AppColors.gray200)),
          ),
          Align(
            alignment: Alignment.center,
              child: Text('Nenhum ticket, faça sua solicitação e aguarde ser aprovado', style: TextStyle(fontSize: 12.sp, color: AppColors.gray700))),

          Padding(
            padding: EdgeInsets.all(20.h),
            child: Text('Outras opções', style: TextStyle(fontSize: 18.sp, fontWeight:FontWeight.w700, color: AppColors.gray200)),
          ),
          CommonTileOptions(leading: Icons.menu_rounded, label: 'Seus tickets', onTap: (){},),
          CommonTileOptions(leading: Icons.search_rounded, label: 'Tickets em análise', onTap: (){},),
          CommonTileOptions(leading: Icons.access_time_rounded, label: 'Histórico', onTap: (){},)
        ],
      )
    );
  }
}
