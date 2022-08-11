class MWordMean {
  String id;
  MWordMeanParams params;
  DateTime? createdAt;
  DateTime? updateAt;

  MWordMean._({
    required this.id,
    required this.params,
    this.createdAt,
    this.updateAt,
  });

  factory MWordMean.fromJson(Map<String, dynamic> json) {
    return MWordMean._(
      id: json['id'],
      params: MWordMeanParams.fromJson(json['params']),
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

class MWordMeanParams {
  String value;
  String? user;
  String? addedBy;
  double note;

  MWordMeanParams._({
    required this.value,
    required this.user,
    this.addedBy,
    required this.note,
  });

  factory MWordMeanParams.fromJson(Map<String, dynamic> json) {
    return MWordMeanParams._(
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
