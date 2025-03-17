import 'package:ticket_ifma/features/models/authorization.dart';
import 'package:ticket_ifma/features/models/permanent_model.dart';
import 'package:ticket_ifma/features/models/photo_request_model.dart';
import 'package:ticket_ifma/features/models/student_authorization.dart';
import 'package:ticket_ifma/features/models/ticket.dart';

class ScreenArguments {
  final String? title;
  final String? subtitle;
  final String? description;
  final List<Ticket>? tickets;
  final List<PermanentModel>? permanents;
  final Map<String, List<Authorization>>? authorizations;
  final bool? cae;
  final int? idStudent;
  final bool? isPermanent;
  final bool? orderDinner;
  final bool? orderLunch;
  final Ticket? ticket;
  final List<PhotoRequestModel>? photoRequests;
  final StudentAuthorization? authorizationStudent;

  ScreenArguments({
    this.ticket,
    this.title,
    this.tickets,
    this.permanents,
    this.cae,
    this.idStudent,
    this.isPermanent,
    this.subtitle,
    this.description,
    this.authorizations,
    this.orderDinner,
    this.orderLunch,
    this.photoRequests,
    this.authorizationStudent
  });
}
