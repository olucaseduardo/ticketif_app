
import 'dart:convert';

class PatchSystemConfigDTO {
  String? value;
  bool? isActive;

  PatchSystemConfigDTO({
    this.value,
    this.isActive,
  });

  Map<String,dynamic> toMap() {
    return {
      "value":value,
      "is_active":isActive,
    };
  }

  String toJson() => json.encode(toMap());
}