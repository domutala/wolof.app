import 'package:flutter/cupertino.dart';
import 'package:wolofbat/utils/store.dart';

class MUser {
  String id;
  MUserParams params;
  DateTime? createdAt;
  DateTime? updateAt;

  MUser._({
    required this.id,
    required this.params,
    this.createdAt,
    this.updateAt,
  });

  factory MUser.fromJson(Map<String, dynamic> json) {
    return MUser._(
      id: json['id'],
      params: MUserParams.fromJson(json['params']),
      createdAt: DateTime.parse(json['createdAt']),
      updateAt:
          json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null,
    );
  }
}

class MUserParams {
  String name;
  String uid;
  String? avatar;

  MUserParams._({
    required this.name,
    required this.uid,
    this.avatar,
  });

  factory MUserParams.fromJson(Map<String, dynamic> json) {
    return MUserParams._(
      name: json['name'],
      uid: json['uid'],
      avatar: json['avatar'],
    );
  }
}

class MUserCurrent extends ValueNotifier<MUser?> {
  MUserCurrent() : super(null) {
    init();
  }

  init() async {
    var user = await Store.get('session.user');
    if (user == null) return;

    value = MUser.fromJson(user);
    notifyListeners();
  }
}

final mUser = MUserCurrent();
