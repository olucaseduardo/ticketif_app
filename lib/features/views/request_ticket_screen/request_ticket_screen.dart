import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:ticket_ifma/features/resources/widgets/common_button_widget.dart';
import 'package:ticket_ifma/features/resources/widgets/common_dropdown_widget.dart';
import 'package:ticket_ifma/features/resources/widgets/common_text_field.dart';

class RequestTicket extends ConsumerWidget {
  final bool? caeRequest;
  final int? idStudent;
  final String? title;

  const RequestTicket({
    Key? key,
    this.title,
    this.caeRequest = false,
    this.idStudent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(requestTicketProvider);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          title ?? 'Voltar',
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.black,
            )),
        titleTextStyle: const TextStyle(color: AppColors.black),
        backgroundColor: AppColors.white,
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Solicitar um novo ticket',
                      style: AppTextStyle.largeText,
                    ),
                    Text(
                      'Descreva as características de seu ticket para que seja analisada sua solicitação.',
                      style: AppTextStyle.smallText,
                    ),
                    const SizedBox(height: 12),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'Refeição',
                        style: AppTextStyle.titleSmall,
                      ),
                    ),
                    CommonDropDownButton(
                        hint: 'Selecione uma refeição',
                        validator: (value) =>
                            value == null ? 'Selecione um campus' : null,
                        items:
                            controller.meals.map((e) => e.description).toList(),
                        onChanged: (value) => controller.onMealsChanged(value)),
                    const Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Text(
                        'Validade',
                        style: AppTextStyle.titleSmall,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 26,
                          height: 26,
                          child: Checkbox(
                            value: !controller.isPermanent,
                            onChanged: (value) {
                              controller.onPermanentChanged(!value!);
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Apenas para hoje',
                          style: AppTextStyle.normalText,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SizedBox(
                          width: 26,
                          height: 26,
                          child: Checkbox(
                            value: controller.isPermanent,
                            onChanged: (value) {
                              controller.onPermanentChanged(value);
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Permanente',
                          style: AppTextStyle.normalText,
                        ),
                      ],
                    ),
                    controller.isPermanent
                        ? Wrap(
                            spacing: 8,
                            runSpacing: -4,
                            children: controller.days
                                .map<FilterChip>((value) => FilterChip(
                                    selected: controller
                                        .selectedDays(value.abbreviation),
                                    label: Text(value.abbreviation),
                                    onSelected: (isSelected) =>
                                        controller.onDaysChanged(
                                            value.abbreviation, isSelected)))
                                .toList(),
                          )
                        : Container(),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'Justificativa',
                        style: AppTextStyle.titleSmall,
                      ),
                    ),
                    CommonDropDownButton(
                      hint: 'Selecione uma justificativa',
                      validator: (value) =>
                          value == null ? 'Selecione um campus' : null,
                      items: controller.justifications
                          .map((e) => e.description)
                          .toList(),
                      onChanged: (value) =>
                          controller.onJustificationChanged(value),
                    ),
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
        ),
        Column(
          children: [
            const Divider(
              height: 0,
              thickness: 0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: CommonButton(
                label: 'Enviar solicitação',
                function: () => controller.onTapSendRequest(caeRequest ?? false,
                    idStudent: idStudent),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
