import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/core/utils/loader.dart';
import 'package:ticket_ifma/features/resources/routes/app_routes.dart';
import 'package:ticket_ifma/features/resources/routes/screen_arguments.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/features/resources/widgets/app_message.dart';
import 'package:ticket_ifma/features/resources/widgets/common_tile_class.dart';
import 'package:ticket_ifma/features/resources/widgets/error_results.dart';
import 'package:ticket_ifma/features/resources/widgets/without_results.dart';

class AuthorizationClassesScreen extends ConsumerStatefulWidget {
  final String title;
  const AuthorizationClassesScreen({
    super.key,
    required this.title,
  });

  @override
  ConsumerState<AuthorizationClassesScreen> createState() =>
      _ClassesScreenState();
}

class _ClassesScreenState extends ConsumerState<AuthorizationClassesScreen> {
  @override
  void initState() {
    ref.read(caePermanentProvider).loadDataAuthorizations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(caePermanentProvider);

    if (controller.error && !controller.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppMessage.i.showError('Erro ao carregar as solicitações por turmas');
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Visibility(
        visible: !controller.isLoading,
        replacement: Loader.loader(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Visibility(
            visible: !controller.error,
            replacement: const ErrorResults(
              msg: 'Voltar para a tela de início',
              msgError: 'Erro ao carregar as solicitações por turmas',
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (value) => controller.filterClasses(value),
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: "Busca",
                    prefixIcon: Icon(Icons.search, color: AppColors.green),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const Text("Turmas"),
                const SizedBox(
                  height: 8,
                ),
                Visibility(
                  visible: controller.filteredClasses.isNotEmpty,
                  replacement: const WithoutResults(
                      msg: 'Nenhuma solicitação encontrada'),
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: controller.filteredClasses.length,
                      itemBuilder: (context, index) => CommonTileClass(
                          title: 'Turma: ${controller.filteredClasses[index]}',
                          subtitle:
                              'Total: ${controller.sortedAuthorizationClasses[controller.filteredClasses[index]]!.length}',
                          // function: (){}, )
                          function: () async {
                            dynamic list = await Navigator.pushNamed(
                              context,
                              AppRouter.authorizationEvaluateRoute,
                              arguments: ScreenArguments(
                                  title: controller.filteredClasses[index],
                                  authorizations:
                                      controller.sortedAuthorizationClasses[
                                          controller.filteredClasses[index]]),
                            );
                            controller.updateClasses(
                                list as List<String>, index);
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
