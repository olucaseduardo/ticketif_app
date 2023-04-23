import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_ticket_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HistoricScreen extends ConsumerWidget {
  final String title;
  const HistoricScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(historicProvider);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 120),
            child: AppBar(
              titleSpacing: 0,
              backgroundColor: AppColors.white,
              title: Text(
                'Voltar',
                style: TextStyle(
                    color: AppColors.gray200,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700),
              ),
              flexibleSpace: Padding(
                  padding: EdgeInsets.only(top: 80.h, left: 20.w, right: 20.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Expanded(
                            child: Container(
                                alignment: Alignment.centerLeft,
                                child:
                                    Text(title, style: AppTextStyle.largeText)))
                      ])),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.gray200,
                  )),
            )),
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: const ClassicHeader(),
          controller: controller.refreshController,
          onRefresh: () => controller.onRefresh(),
          onLoading: () => controller.onLoading(),
          child: ListView.builder(
            itemBuilder: (context, _) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: const CommonTicketWidget(),
            ),
            itemCount: controller.countOne, // controller.countOne,
            physics: const AlwaysScrollableScrollPhysics(),
          ),
        ));
  }
}
