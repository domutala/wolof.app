import 'package:flutter/material.dart';
import 'package:wolofbat/utils/store.dart';

class MWord {
  String id;
  MWordParams params;
  DateTime? createdAt;
  DateTime? updateAt;

  MWord._({
    required this.id,
    required this.params,
    this.createdAt,
    this.updateAt,
  });

  factory MWord.fromJson(Map<String, dynamic> json) {
    return MWord._(
      id: json['id'],
      params: MWordParams.fromJson(json['params']),
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

class MWordParams {
  String value;
  String? mean;
  String? addedBy;

  MWordParams._({
    required this.value,
    required this.mean,
    this.addedBy,
  });

  factory MWordParams.fromJson(Map<String, dynamic> json) {
    return MWordParams._(
      value: json['value'],
      mean: json['mean'],
      addedBy: json['addedBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "value": value,
      "mean": mean,
      'addedBy': addedBy,
    };
  }
}

class MBookmark extends ValueNotifier<List<String>> {
  MBookmark() : super([]) {
    init();
  }

  init() async {
    value = [];

    var list = await Store.get('bookmark');
    if (list != null) {
      value = (list as List).map((e) => e.toString()).toList();
    }

    notifyListeners();
  }

  toggle(String id) async {
    value.contains(id) ? value.remove(id) : value.add(id);
    notifyListeners();

    await Store.save(key: 'bookmark', value: value);
  }
}

final mBookmark = MBookmark();
