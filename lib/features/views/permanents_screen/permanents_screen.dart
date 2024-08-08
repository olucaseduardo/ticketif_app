import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/features/models/permanent_model.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:ticket_ifma/features/resources/widgets/common_permanent.dart';

class PermanentsScreen extends ConsumerStatefulWidget {
  final List<PermanentModel> permanents;

  const PermanentsScreen({ super.key, required this.permanents });

  @override
  ConsumerState<PermanentsScreen> createState() => _PermanentsScreenState();
}

class _PermanentsScreenState extends ConsumerState<PermanentsScreen> {
  @override
  void initState() {
    ref.read(permanentsProvider).loadData(widget.permanents);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(permanentsProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 108),
        child: AppBar(
          titleSpacing: 0,
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black,
          centerTitle: false,

          title: const Text(
            'Voltar',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 94, left: 16, right: 20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Autorizações permanentes",
                    style: AppTextStyle.largeText.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },

            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.black,
            ),
          ),
        ),
      ),

      body: Visibility(
        visible: controller.authorizations.isNotEmpty,

        replacement: const Center(
          child: Text('Sem tickets permanentes no momento'),
        ),

        child: ListView.builder(
          padding: const EdgeInsets.only(top: 14),
          itemCount: controller.authorizations.length,
          itemBuilder: (context, i) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: CommonPermanent(permanentModel: controller.authorizations.elementAt(i)),
          ),
        ),
      ),
    );
  }
}
