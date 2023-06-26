import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_button_widget.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_dropdown_widget.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_text_field.dart';

class RequestTicket extends ConsumerWidget {
  const RequestTicket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(requestTicketProvider);

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
                  child: const Text(
                    'Solicitar um novo ticket',
                    style: AppTextStyle.largeText,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: const Text(
                    'Descreva as características de seu ticket para que seja analisada sua solicitação.',
                    style: AppTextStyle.smallText,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: const Text(
                    'Refeição',
                    style: AppTextStyle.normalText,
                  ),
                ),
                CommonDropDownButton(
                    hint: 'Selecione uma refeição',
                    items: controller.meals.map((e) => e.description).toList(),
                    onChanged: (value) => controller.onMealsChanged(value)),
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: const Text(
                    'Validade',
                    style: AppTextStyle.normalText,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          value: !controller.isPermanent,
                          onChanged: (value) {
                            controller.onPermanentChanged(!value!);
                          },
                        )),
                    const Text(
                      'Apenas para hoje',
                      style: AppTextStyle.normalText,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          value: controller.isPermanent,
                          onChanged: (value) {
                            controller.onPermanentChanged(value);
                          },
                        )),
                    const Text(
                      'Permanente',
                      style: AppTextStyle.normalText,
                    ),
                  ],
                ),
                controller.isPermanent
                    ? Wrap(
                        spacing: 8,
                        children: controller.days
                            .map<FilterChip>((value) => FilterChip(
                                selected:
                                    controller.selectedDays(value.abbreviation),
                                label: Text(value.abbreviation),
                                onSelected: (isSelected) =>
                                    controller.onDaysChanged(
                                        value.abbreviation, isSelected)))
                            .toList(),
                      )
                    : //TODO: notice of time to order
                    Container(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: const Text(
                    'Justificativa',
                    style: AppTextStyle.normalText,
                  ),
                ),
                CommonDropDownButton(
                    hint: 'Selecione uma justificativa',
                    items: controller.justifications
                        .map((e) => e.description)
                        .toList(),
                    onChanged: (value) =>
                        controller.onJustificationChanged(value)),
                CommonTextField(
                  controller: controller.justificationController,
                  title: 'Justificativa detalhada (opcional)',
                  labelText: 'Digite sua justificativa detalhada',
                  keyboardType: TextInputType.multiline,
                  maxLine: 5,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 60,
          child: CommonButton(
            label: 'Enviar solicitação',
            function: () => controller.onTapSendRequest(),
          ),
        ),
      ),
    );
  }
}
