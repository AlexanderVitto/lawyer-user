import 'package:flutter/material.dart';

import '../../../enum.dart' as localEnum;

class Preference with ChangeNotifier {
  final String id;
  final String name;
  final String queryStringKey;
  final String queryStringValue;
  final localEnum.Preference preferenceType;
  int groupId;
  bool isSelected;

  Preference(
      {this.id,
      this.name,
      this.queryStringKey,
      this.queryStringValue,
      this.preferenceType,
      this.groupId = 1,
      this.isSelected = false});

  toggleIsSelect() {
    this.isSelected = !isSelected;

    notifyListeners();
  }

  setIsSelet(bool data) {
    this.isSelected = data;

    notifyListeners();
  }
}
