
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/features/resources/routes/app_routes.dart';
import 'package:ticket_ifma/features/resources/widgets/common_tile_options.dart';
import 'package:ticket_ifma/features/views/adm/cae/cae_home_screen/widgets/exclusion_options_modal.dart';

class SystemDefinitionsScreen extends ConsumerStatefulWidget {
  const SystemDefinitionsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SystemConfigScreenState();
}

class _SystemConfigScreenState extends ConsumerState<ConsumerStatefulWidget> {

  @override
  build(BuildContext context) {
    final controller = ref.watch(caeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Definições do sistema"),
          ]
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 8),
                CommonTileOptions(
                  leading: Icons.tune,
                  label: 'Parâmetros do sistema',
                  function: () => Navigator.pushNamed(context, AppRouter.systemConfig)
                ),
                const SizedBox(height: 8),
                CommonTileOptions(
                  leading: CupertinoIcons.add_circled_solid,
                  label: 'Adicionar Nova Turma (Médio)',
                  function: () => Navigator.pushNamed(
                    context,
                    AppRouter.addNewClass,
                  ),
                ),
                const SizedBox(height: 8),
                CommonTileOptions(
                  leading: Icons.delete,
                  label: 'Opções de Exclusão',
                  function: () => showModalBottomSheet(
                    context: context,
                    builder: (_) => ExclusionOptionsModal(controller: controller),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}