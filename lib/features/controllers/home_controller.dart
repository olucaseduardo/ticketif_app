import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/core/exceptions/repository_exception.dart';
import 'package:project_ifma_ticket/features/app/app.dart';
import 'package:project_ifma_ticket/features/data/tickets/tickets_api_repository_impl.dart';
import 'package:project_ifma_ticket/features/data/user/user_api_repository_impl.dart';
import 'package:project_ifma_ticket/features/models/ticket.dart';
import 'package:project_ifma_ticket/features/models/user.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends ChangeNotifier {
  User? user;
  List<Ticket>? userTickets = [];
  List<Ticket>? todayTickets = [];

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  onRequestTicketTap() {
    Navigator.pushNamed(
        navigatorKey.currentContext!, AppRouter.requestTicketRoute);
  }

  onLogoutTap() {}

  onQrCodeTap() {
    Navigator.pushNamed(
      navigatorKey.currentContext!,
      AppRouter.qrRoute,
    );
  }

  bool isLoading = true;
  void loading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> loadData() async {
    try {
      final userData = await UserApiRepositoryImpl().loadUser();
      final tickets =
          await TicketsApiRepositoryImpl().findAllTickets(userData.id);

      final sp = await SharedPreferences.getInstance();
      sp.setInt('idStudent', userData.id);

      user = userData;

      for (var i = 0; i < tickets.length; i++) {
        if (tickets.elementAt(i).useDayDate != '') {
          if (DateTime.parse(tickets.elementAt(i).useDayDate).day ==
                  DateTime.now().day &&
              DateTime.parse(tickets.elementAt(i).useDayDate).month ==
                  DateTime.now().month) {
            todayTickets?.add(tickets.elementAt(i));
            userTickets?.add(tickets.elementAt(i));
          } else {
            userTickets?.add(tickets.elementAt(i));
          }
        }
      }
      notifyListeners();
      // loading();
    } on DioError catch (e, s) {
      log('Erro ao buscar dados do usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar dados do usuário');
    }
  }
}
