import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ticket_ifma/core/exceptions/repository_exception.dart';
import 'package:ticket_ifma/features/dto/patch_system_config_dto.dart';
import 'package:ticket_ifma/features/models/registration_exception_ticket.dart';
import 'package:ticket_ifma/features/models/system_config.dart';
import 'package:ticket_ifma/features/repositories/cae/cae_repository_impl.dart';

class SystemConfigClassController extends ChangeNotifier {
  bool isLoading = false;
  bool error = false;
  String errorMessage = "Erro nas configurações do sistema";
  // LISTA DE CONFIGURAÇÕES DO SISTEMA EXISTENTES
  List<SystemConfig> systemConfig = [];
  // LISTA DE MATRICULAS QUE BURLAM A REGRA DE HORÁRIOS
  List<RegistrationExceptionTicket> registrationException = [];


  void loading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> loadData() async {
    try {
      error = false;
      isLoading = true;
      notifyListeners();
      await findAllSystemConfig();
      await findAllRegistrationExceptionTicket();
    } catch (e,s) {
      log('Erro ao iniciar tela de parâmetros do sistema', error: e, stackTrace: s);
      error = true;
      notifyListeners();
    } finally {
      loading();
    }
  }

  Future<void> deleteRegistrationExceptionTicket(int id) async {
    try {
      error = false;
      await CaeRepositoryImpl().deleteRegistrationExceptionTicket(id);
    } catch(e,s) {
      error = true;
      errorMessage = "Erro ao deletar a mátricula";
      notifyListeners();
      log("Erro ao buscar configurações do sistema: $e\n$s");
      throw RepositoryException(message: "Erro ao buscar configurações do sistema");
    } finally {
      loading();
    }
  }

  Future<void> findAllSystemConfig() async {
    try {
      error = false;
      systemConfig = await CaeRepositoryImpl().findAllSystemConfig();
    } catch(e,s) {
      error = true;
      notifyListeners();
      log("Erro ao buscar configurações do sistema: $e\n$s");
      throw RepositoryException(message: "Erro ao buscar configurações do sistema");
    }
  }

  Future<void> findAllRegistrationExceptionTicket() async {
    try {
      error = false;
      registrationException = await CaeRepositoryImpl().findAllRegistrationExceptionTicket();
    } catch(e,s) {
      error = true;
      notifyListeners();
      log("Erro ao buscar configurações do sistema: $e\n$s");
      throw RepositoryException(message: "Erro ao buscar configurações do sistema");
    }
  }

  Future<void> addRegistrationExceptionTicket(String value) async {
    try {
      error = false;
      await CaeRepositoryImpl().createRegistrationExceptionTicket(value);
    } on RepositoryException catch(e) {
      error = true;
      errorMessage = e.message;
    } catch(e,s) {
      error = true;
      errorMessage = "Erro ao inserir uma nova mátricula";
      notifyListeners();
      log("Erro ao adicionar nova mátricula: $e \n$s");
    } finally {
      loading();
    }
  }

  Future<void> updateMealTime(int id, String value) async {
    try {
      error = false;
      final formated = _formatTime(value);
      final valid = _isValidTime(formated);
      if (!valid) {
        error = true;
        errorMessage = "O intervalo de horas deve ser entre 00:00 e 23:59";
        notifyListeners();
        return;
      }
      PatchSystemConfigDTO patch = PatchSystemConfigDTO(value: formated);
      await CaeRepositoryImpl().updateSystemConfig(id,patch);
    } on RepositoryException catch(e) {
      error = true;
      errorMessage = e.message;
    } catch(e,s) {
      error = true;
      errorMessage = "Erro ao inserir uma nova mátricula";
      notifyListeners();
      log("Erro ao adicionar nova mátricula: $e \n$s");
    } finally {
      loading();
    }
  }

  Future<void> updateMealTimeStatus(int id, bool isActive) async {
    try {
      PatchSystemConfigDTO patch = PatchSystemConfigDTO(isActive: isActive);
      await CaeRepositoryImpl().updateSystemConfig(id,patch);
    } on RepositoryException catch(e) {
      error = true;
      errorMessage = e.message;
    } catch(e,s) {
      error = true;
      errorMessage = "Erro ao inserir uma nova mátricula";
      notifyListeners();
      log("Erro ao adicionar nova mátricula: $e \n$s");
    }
  }

  String _formatTime(String value) {
    value = value.replaceAll(' ', '');
    if (value.isEmpty) return '00:00';

    List<String> parts = value.split(':');
    String hour = parts[0].padLeft(2, '0');  // Adiciona zero à esquerda, se necessário
    String minute = parts.length > 1 ? parts[1].padLeft(2, '0') : '00';  // Adiciona minutos, se não houver, coloca 00

    return '$hour:$minute';
  }

  bool _isValidTime(String time) {
    List<String> parts = time.split(':');
    if (parts.length != 2) return false;

    int hour = int.tryParse(parts[0]) ?? -1;
    int minute = int.tryParse(parts[1]) ?? -1;

    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
      return false;
    }

    return true;
  }
}
