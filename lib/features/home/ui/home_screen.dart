import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/features/app/app.dart';
import 'package:project_ifma_ticket/features/historic/ui/historic_screen.dart';
import 'package:project_ifma_ticket/features/requestTicket/ui/request_ticket_screen.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_button_widget.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_ticket_widget.dart';
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
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateUtil.todayDate(dateTime),
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                ),
                Text(
                  '20191BCC.CAX0003',
                  style: TextStyle(
                    fontSize: 10.sp,
                  ),
                )
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Olá, Fulano de tal',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.gray200)),
                  CommomButton(
                    label: 'Solicitar um ticket',
                    textPadding: 8.h,
                    textStyle: AppTextStyle.smallButton,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const RequestTicket()));
                    },
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1.5,
              color: AppColors.gray800,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 18.h),
                    child: Text('Suas refeições de hoje',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.gray200)),
                  ),
                  const CommomTicketWidget(),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 20.h),
                  //   child: Align(
                  //       alignment: Alignment.center,
                  //       child: Text(
                  //           'Nenhum ticket, faça sua solicitação e aguarde ser aprovado',
                  //           style: TextStyle(
                  //               fontSize: 12.sp, color: AppColors.gray700))),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 18.h),
                    child: Text('Outras opções',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.gray200)),
                  ),
                  CommonTileOptions(
                    leading: Icons.menu_rounded,
                    label: 'Seus tickets',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => HistoricScreen(
                                    title: 'Seus tickets',
                                  )));
                    },
                  ),
                  CommonTileOptions(
                    leading: Icons.search_rounded,
                    label: 'Tickets em análise',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => HistoricScreen(
                                    title: 'Tickets em análise',
                                  )));
                    },
                  ),
                  CommonTileOptions(
                    leading: Icons.access_time_rounded,
                    label: 'Histórico',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => HistoricScreen(
                                    title: 'Histórico',
                                  )));
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
