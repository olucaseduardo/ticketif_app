import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_button_widget.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_text_field.dart';

import '../../resources/theme/app_colors.dart';

class RequestTicket extends StatelessWidget {
  const RequestTicket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Voltar',
          style: TextStyle(
              color: AppColors.gray200,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.gray200,
            )),
        titleTextStyle: const TextStyle(color: AppColors.gray200),
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Text(
                    'Solicitar um novo ticket',
                    style: AppTextStyle.largeText,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Text(
                    'Descreva as características de seu ticket para que seja analisada sua solicitação.',
                    style: AppTextStyle.smallText,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Text(
                    'Refeição',
                    style: AppTextStyle.normalText,
                  ),
                ),
                DropdownButtonFormField<String>(
                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.green500)),
                      focusColor: AppColors.green500,
                      fillColor: AppColors.green500,
                      hoverColor: AppColors.green500,
                      labelStyle: TextStyle(color: AppColors.gray700),
                      border: OutlineInputBorder(),
                    ),
                    borderRadius: BorderRadius.circular(4.h),
                    isExpanded: true,
                    items: [
                      const DropdownMenuItem(child: Text('teste 1')),
                    ],
                    onChanged: (test) {}),
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: Text(
                    'Validade',
                    style: AppTextStyle.normalText,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Transform.scale(
                        scale: 1.5,
                        child: Checkbox(value: false, onChanged: (teste) {})),
                    Text(
                      'Apenas para hoje',
                      style: AppTextStyle.normalText,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Transform.scale(
                        scale: 1.5,
                        child: Checkbox(value: true, onChanged: (teste) {})),
                    Text(
                      'Permanente',
                      style: AppTextStyle.normalText,
                    ),
                  ],
                ),
                Wrap(
                  spacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('Seg'),
                      selected: true,
                      onSelected: (teste) {},
                    ),
                    FilterChip(
                        label: const Text('Ter'), onSelected: (teste) {}),
                    FilterChip(
                        label: const Text('Qua'), onSelected: (teste) {}),
                    FilterChip(
                        label: const Text('Qui'), onSelected: (teste) {}),
                    FilterChip(
                        label: const Text('Sex'), onSelected: (teste) {}),
                    FilterChip(
                        label: const Text('Sab'), onSelected: (teste) {}),
                    FilterChip(
                        label: const Text('Dom'), onSelected: (teste) {}),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Text(
                    'Justificativa',
                    style: AppTextStyle.normalText,
                  ),
                ),
                DropdownButtonFormField<String>(
                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.green500)),
                      focusColor: AppColors.green500,
                      fillColor: AppColors.green500,
                      hoverColor: AppColors.green500,
                      labelStyle: TextStyle(color: AppColors.gray700),
                      border: OutlineInputBorder(),
                    ),
                    borderRadius: BorderRadius.circular(4.h),
                    isExpanded: true,
                    items: [
                      const DropdownMenuItem(child: Text('teste 1')),
                    ],
                    onChanged: (test) {}),
                const CommonTextField(
                  title: 'Justificativa detalhada (opcional)',
                  labelText: 'Digite sua justificativa detalhada',
                  keybordType: TextInputType.multiline,
                  maxline: 5,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.w),
        child: SizedBox(
            height: 50.h,
            child: CommomButton(label: 'Enviar solicitação', onPressed: () {})),
      ),
    );
  }
}
