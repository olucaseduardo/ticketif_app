
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_ifma/features/models/permanent_model.dart';

class PermanentCache {

  static Future<void> savePermanents(List<PermanentModel> permanents) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> permanentsSerialize = permanents.map((e) => e.toJson()).toList();
    await sp.setStringList("permanents", permanentsSerialize);
  }

  static Future<List<PermanentModel>> getPermanents() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String>? permanentsSerialize = sp.getStringList("permanents");
    if (permanentsSerialize == null) {
      return [];
    }
    return List<PermanentModel>.from(permanentsSerialize.map((e) => PermanentModel.fromJson(e)));
  }
}