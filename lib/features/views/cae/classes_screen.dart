import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:project_ifma_ticket/features/resources/routes/screen_arguments.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_class.dart';

class ClassesScreen extends ConsumerStatefulWidget {
  const ClassesScreen({super.key});

  @override
  ConsumerState<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends ConsumerState<ClassesScreen> {
  @override
  void initState() {
    ref
        .read(caeProvider)
        .loadDataTickets(DateUtil.getDateUSStr(DateUtil.dateTime));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(caeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitações por turmas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                fillColor: AppColors.gray800,
                filled: true,
                hintText: "Busca",
                prefixIcon: Icon(Icons.search, color: AppColors.green500),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
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
            controller.dailyClasses.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                        itemCount: controller.dailyClasses.length,
                        itemBuilder: (context, index) => CommonTileClass(
                            title:
                                controller.dailyClasses.keys.elementAt(index),
                            subtitle:
                                'Total: ${controller.dailyClasses.values.elementAt(index).length}',
                            function: () => Navigator.pushNamed(
                context,
                AppRouter.caeTicketEvaluateRoute,
                arguments: ScreenArguments(
                  tickets: controller.dailyClasses.values.elementAt(index)
                )
              ),),
                            ),)
                        
                : const Center(child: Text('Sem tickets')),
            // CommonTileClass(
            //   title: '20231A.CAX',
            //   subtitle: 'Total 3',
            //   function: () => Navigator.pushNamed(
            //     context,
            //     AppRouter.caeTicketEvaluateRoute,
            //   ),
            // ),
            // const CommonTileClass(title: '20231A.CAX', subtitle: 'Total 3'),
            // const CommonTileClass(title: '20231A.CAX', subtitle: 'Total 3'),
          ],
        ),
      ),
    );
  }
}
