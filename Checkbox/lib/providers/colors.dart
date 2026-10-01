import 'package:flutter/material.dart';

import './color.dart';

class MultiColor with ChangeNotifier {
  List<SingleColor> _colors = [];

  List<SingleColor> get colors => _colors;

  void selectAll(bool nilai) {
    if (nilai) {
      _colors.forEach((element) {
        element.status = true;
      });
    } else {
      _colors.forEach((element) {
        element.status = false;
      });
    }
    notifyListeners();
  }

  checkAllStatus() {
    var hasil = _colors.every((element) => element.status == true);
    return hasil;
  }

  void addColor(String title) {
    _colors.add(
      SingleColor(
        id: DateTime.now().toString(),
        title: title,
      ),
    );
    notifyListeners();
  }

  void deleteColor(String id) {
    _colors.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
