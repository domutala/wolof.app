class MWordValue {
  String id;
  MWordValueParams params;
  DateTime? createdAt;
  DateTime? updateAt;

  MWordValue._({
    required this.id,
    required this.params,
    this.createdAt,
    this.updateAt,
  });

  factory MWordValue.fromJson(Map<String, dynamic> json) {
    return MWordValue._(
      id: json['id'],
      params: MWordValueParams.fromJson(json['params']),
      createdAt: DateTime.parse(json['createdAt']),
      updateAt:
          json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "params": params.toJson(),
      "createdAt": createdAt.toString(),
      "updateAt": updateAt?.toString(),
    };
  }
}

class MWordValueParams {
  String value;
  String? user;
  String? addedBy;
  double note;

  MWordValueParams._({
    required this.value,
    required this.user,
    this.addedBy,
    required this.note,
  });

  factory MWordValueParams.fromJson(Map<String, dynamic> json) {
    return MWordValueParams._(
      value: json['value'],
      user: json['mean'],
      addedBy: json['addedBy'],
      note: double.parse(json['note'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "value": value,
      "user": user,
      'addedBy': addedBy,
      'note': note,
    };
  }
}
