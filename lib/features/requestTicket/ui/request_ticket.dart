import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_text_field.dart';

import '../../resources/theme/app_colors.dart';

class RequestTicket extends StatelessWidget {
  const RequestTicket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Voltar',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: AppColors.gray200,
            )),
        titleTextStyle: const TextStyle(color: AppColors.gray200),
        backgroundColor: AppColors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Solicitar um novo ticket'),
            Text(
                'Descreva as características de seu ticket para que seja analisada sua solicitação.'),
            Text('Refeição'),
            DropdownButton<String>(
                isExpanded: true,
                items: [
                  DropdownMenuItem(child: Text('teste 1')),
                ],
                onChanged: (test) {}),
            Text('Validade'),
            Row(
              children: [
                Checkbox(value: false, onChanged: (teste) {}),
                Text('Apenas para hoje'),
              ],
            ),
            Row(
              children: [
                Checkbox(value: false, onChanged: (teste) {}),
                Text('Permanente'),
              ],
            ),
            Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.all(6.w),
                  child: FilterChip(
                    label: Text('Seg'),
                    selected: true,
                    onSelected: (teste) {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.w),
                  child: FilterChip(label: Text('Ter'), onSelected: (teste) {}),
                ),
                Padding(
                  padding: EdgeInsets.all(6.w),
                  child: FilterChip(label: Text('Qua'), onSelected: (teste) {}),
                ),
                Padding(
                  padding: EdgeInsets.all(6.w),
                  child: FilterChip(label: Text('Qui'), onSelected: (teste) {}),
                ),
                Padding(
                  padding: EdgeInsets.all(6.w),
                  child: FilterChip(label: Text('Sex'), onSelected: (teste) {}),
                ),
                Padding(
                  padding: EdgeInsets.all(6.w),
                  child: FilterChip(label: Text('Sab'), onSelected: (teste) {}),
                ),
                Padding(
                  padding: EdgeInsets.all(6.w),
                  child: FilterChip(label: Text('Dom'), onSelected: (teste) {}),
                ),
              ],
            ),
            Text('Justificativa'),
            DropdownButton<String>(
                isExpanded: true,
                items: [
                  DropdownMenuItem(child: Text('teste 1')),
                ],
                onChanged: (test) {}),
            CommonTextField(
                title: 'Justificativa detalhada (opcional)',
                labelText: 'Digite sua justificativa detalhada')
          ],
        ),
      ),
    );
  }
}
