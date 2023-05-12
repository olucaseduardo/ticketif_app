import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/core/exceptions/repository_exception.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/features/app/app.dart';
import 'package:project_ifma_ticket/features/data/tickets/tickets_api_repository_impl.dart';
import 'package:project_ifma_ticket/features/data/user/user_api_repository_impl.dart';
import 'package:project_ifma_ticket/features/models/ticket.dart';
import 'package:project_ifma_ticket/features/models/user.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:project_ifma_ticket/features/resources/routes/arguments.dart';

class HomeController extends ChangeNotifier {
  User? user;
  List<Ticket>? userTickets = [];
  List<Ticket>? todayTickets = [];

  onRequestTicketTap() {
    Navigator.pushNamed(
        navigatorKey.currentContext!, AppRouter.requestTicketRoute);
  }

  onLogoutTap() {}
  onTicketsTap() {
    Navigator.pushNamed(navigatorKey.currentContext!, AppRouter.historicRoute,
        arguments: ScreenArguments('Seus tickets', []));
  }

  onAnalysisTap() {
    Navigator.pushNamed(navigatorKey.currentContext!, AppRouter.historicRoute,
        arguments: ScreenArguments('Tickets em análise', []));
  }

  onHistoricTap() {
    Navigator.pushNamed(navigatorKey.currentContext!, AppRouter.historicRoute,
        arguments: ScreenArguments('Histórico', []));
  }

  onQrCodeTap() {
    Navigator.pushNamed(
      navigatorKey.currentContext!,
      AppRouter.qrRoute,
    );
  }

  Future<void> loadData() async {
    try {
      final userData = await UserApiRepositoryImpl().loadUser();
      final tickets =
          await TicketsApiRepositoryImpl().findAllTickets(userData.id);

      user = userData;
      userTickets = tickets;

      for (var i = 0; i < userTickets!.length; i++) {
        if (DateTime.parse(userTickets!.elementAt(i).date).day == DateTime.now().day 
          && DateTime.parse(userTickets!.elementAt(i).date).month == DateTime.now().month) {
          todayTickets?.add(userTickets!.elementAt(i));
          log(userTickets!.elementAt(i).date);
        }
      }

      notifyListeners();
    } on DioError catch (e, s) {
      log('Erro ao buscar dados do usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar dados do usuário');
    }
  }
}
