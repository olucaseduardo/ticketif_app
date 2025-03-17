import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/models/authorization.dart';
import 'package:ticket_ifma/features/models/permanent_model.dart';
import 'package:ticket_ifma/features/models/photo_request_model.dart';
import 'package:ticket_ifma/features/models/student_authorization.dart';
import 'package:ticket_ifma/features/models/ticket.dart';
import 'package:ticket_ifma/features/resources/routes/screen_arguments.dart';
import 'package:ticket_ifma/features/views/adm/cae/add_new_class/add_new_class_screen.dart';
import 'package:ticket_ifma/features/views/adm/cae/authorizations_request_photo/authorization_classes/authorization_classes_screen.dart';
import 'package:ticket_ifma/features/views/adm/cae/authorizations_request_photo/authorization_evaluate/authorization_photo_requests_evaluate_screen.dart';
import 'package:ticket_ifma/features/views/adm/cae/authorizations_screens/authorization_classes/authorization_classes_screen.dart';
import 'package:ticket_ifma/features/views/adm/cae/authorizations_screens/authorization_evaluate/authorization_evaluate_screen.dart';
import 'package:ticket_ifma/features/views/adm/cae/authorizations_screens/authorization_evaluate/authorization_evaluate_student_screen.dart';
import 'package:ticket_ifma/features/views/adm/cae/cae_home_screen/cae_home_screen.dart';
import 'package:ticket_ifma/features/views/adm/cae/classes_screen/classes_screen.dart';
import 'package:ticket_ifma/features/views/adm/cae/period_report_screen/period_report_screen.dart';
import 'package:ticket_ifma/features/views/adm/cae/search_student_screen/search_student_screen.dart';
import 'package:ticket_ifma/features/views/adm/cae/system_config/system_config_screen.dart';
import 'package:ticket_ifma/features/views/adm/cae/system_definitions/system_definitions_screen.dart';
import 'package:ticket_ifma/features/views/adm/cae/ticket_evaluate_screen/ticket_evaluate_screen.dart';
import 'package:ticket_ifma/features/views/adm/daily_report_screen/daily_report_screen.dart';
import 'package:ticket_ifma/features/views/adm/list_tickets_screen/list_tickets_screen.dart';
import 'package:ticket_ifma/features/views/adm/restaurant/qr_screen/qr_screen.dart';
import 'package:ticket_ifma/features/views/adm/restaurant/restaurant_home/restaurant_screen.dart';
import 'package:ticket_ifma/features/views/auth_screens/auth_adm/login_adm_screen.dart';
import 'package:ticket_ifma/features/views/auth_screens/auth_check/auth_check.dart';
import 'package:ticket_ifma/features/views/auth_screens/auth_student/login_screen.dart';
import 'package:ticket_ifma/features/views/historic_screen/historic_screen.dart';
import 'package:ticket_ifma/features/views/home_screen/home_screen.dart';
import 'package:ticket_ifma/features/views/permanents_screen/permanents_screen.dart';
import 'package:ticket_ifma/features/views/request_ticket_screen/request_ticket_screen.dart';
import 'package:ticket_ifma/features/views/student/profile/new_solicitation/new_solicitation_photo_student_screen.dart';
import 'package:ticket_ifma/features/views/student/profile/photo_student_screen.dart';
import 'package:ticket_ifma/features/views/student/ticket/qr_code/use_ticket_qr_code_screen.dart';

class AppRouter {
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String historicRoute = '/historic';
  static const String permanentsRoute = '/permanents';
  static const String requestTicketRoute = '/requestTicket';
  static const String qrRoute = '/qrCode';
  static const String admLoginRoute = '/admLogin';
  static const String dailyReportRoute = '/dailyReport';
  static const String restaurantHomeRoute = '/restaurantHome';
  static const String authCheck = '/authCheck';
  static const String useTicketQrCodeScreen =
      '/useTicketQrCodeScreen'; // Rota para utilização de tickets por parte dos estudantes
  static const String photoStudentRoute =
      '/photoStudentRoute'; // Rota para visualização de troca de foto de perfil por parte dos estudantes
  static const String newSolicitationPhotoStudentRoute =
      '/newSolicitationPhotoStudentRoute'; // Rota para solicitação de foto de perfil
  // CAE ROUTES
  static const String caeHomeRoute = '/caeHome';
  static const String caeClassesRoute = "/classes";
  static const String authorizationClassesRoute = "/authorizationClasses";
  static const String authorizationEvaluateRoute = "/authorizationEvaluate";
  static const String authorizationEvaluateStudentRoute = "/authorizationEvaluateStudentRoute";
  static const String caePeriodReportRoute = '/periodReport';
  static const String caeTicketEvaluateRoute = '/ticketEvaluate';
  static const String caeSearchStudentRoute = '/searchStudent';
  static const String listTickets = '/listTickets';
  static const String addNewClass = '/addNewClass';
  static const String systemDefinitions = '/systemDefinitions';
  static const String systemConfig = '/systemConfig';
  static const String photoRequestAuthorizationClassesScreen =
      '/photoRequestAuthorizationClassesScreen';
  static const String photoRequestAuthorizationEvaluateRoute =
      '/photoRequestAuthorizationEvaluateRoute';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final ScreenArguments? args = settings.arguments as ScreenArguments?;

    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case admLoginRoute:
        return MaterialPageRoute(builder: (_) => const LoginAdmScreen());

      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case historicRoute:
        return MaterialPageRoute(
          builder: (_) => HistoricScreen(
            userTickets: args?.tickets as List<Ticket>,
          ),
        );

      case permanentsRoute:
        return MaterialPageRoute(
          builder: (_) => PermanentsScreen(
            permanents: args?.permanents as List<PermanentModel>,
          ),
        );

      case requestTicketRoute:
        return MaterialPageRoute(
          builder: (_) => RequestTicket(
            title: args?.title,
            caeRequest: args?.cae,
            idStudent: args?.idStudent,
            orderLunch: args?.orderLunch,
            orderDinner: args?.orderDinner,
          ),
        );

      // CAE ROUTES
      case caeHomeRoute:
        return MaterialPageRoute(builder: (_) => const CaeHomeScreen());

      case caeClassesRoute:
        return MaterialPageRoute(
          builder: (_) => ClassesScreen(
            title: args?.title as String,
            isPermanent: args?.isPermanent as bool,
          ),
        );

      case authorizationClassesRoute:
        return MaterialPageRoute(
          builder: (_) => AuthorizationClassesScreen(
            title: args?.title as String,
          ),
        );

      case authorizationEvaluateRoute:
        return MaterialPageRoute(
          builder: (_) => AuthorizationEvaluateScreen(
            title: args?.title as String,
            authorizations:
                args!.authorizations as Map<String, List<Authorization>>,
          ),
        );

        case authorizationEvaluateStudentRoute:
        return MaterialPageRoute(
          builder: (_) => AuthorizationEvaluateStudentScreen(
            title: args?.title as String,
            authorizationStudent: args!.authorizationStudent as StudentAuthorization,
          ),
        );

      case dailyReportRoute:
        return MaterialPageRoute(
          builder: (_) => DailyReportScreen(
            cae: args!.cae as bool,
          ),
        );

      case caePeriodReportRoute:
        return MaterialPageRoute(builder: (_) => const PeriodReportScreen());

      case caeTicketEvaluateRoute:
        return MaterialPageRoute(
          builder: (_) => TicketEvaluateScreen(
            title: args!.title as String,
            tickets: args.tickets as List<Ticket>,
          ),
        );

      case listTickets:
        return MaterialPageRoute(
          builder: (_) => ListTicketsScreen(
            title: args!.title as String,
            tickets: args.tickets as List<Ticket>,
            description: args.description as String,
            subtitle: args.subtitle as String,
          ),
        );

      case caeSearchStudentRoute:
        return MaterialPageRoute(builder: (_) => const SearchStudentScreen());

      case qrRoute:
        return MaterialPageRoute(builder: (_) => const QrScreen());

      case restaurantHomeRoute:
        return MaterialPageRoute(builder: (_) => const RestaurantScreen());

      case authCheck:
        return MaterialPageRoute(builder: (_) => const AuthCheck());

      case addNewClass:
        return MaterialPageRoute(builder: (_) => const AddNewClassScreen());

      case systemDefinitions:
        return MaterialPageRoute(
            builder: (_) => const SystemDefinitionsScreen());

      case systemConfig:
        return MaterialPageRoute(builder: (_) => const SystemConfigScreen());

      case useTicketQrCodeScreen:
        return MaterialPageRoute(
            builder: (_) =>
                UseTicketQrCodeScreen(ticket: args!.ticket as Ticket));

      case photoStudentRoute:
        return MaterialPageRoute(builder: (_) => const PhotoStudentScreen());

      case newSolicitationPhotoStudentRoute:
        return MaterialPageRoute(
            builder: (_) => const NewSolicitationPhotoStudentScreen());

      case photoRequestAuthorizationEvaluateRoute:
        return MaterialPageRoute(
            builder: (_) => PhotoRequestAuthorizationEvaluateRoute(
                  title: args!.title as String,
                  photoRequests: args.photoRequests as List<PhotoRequestModel>,
                ));

      case photoRequestAuthorizationClassesScreen:
        return MaterialPageRoute(
            builder: (_) => PhotoRequestAuthorizationClassesScreen(
                title: args!.title as String));

      default:
        return MaterialPageRoute(
          builder: (_) => const RouteErrorScreen(
              title: 'Rota não encontrada',
              message: 'Erro! A rota {settings.name} não foi encontrada.'),
        );
    }
  }
}

class RouteErrorScreen extends StatelessWidget {
  final String title;
  final String message;

  const RouteErrorScreen(
      {super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}
