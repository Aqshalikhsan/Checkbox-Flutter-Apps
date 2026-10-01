import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './color.dart';

class MultiColor with ChangeNotifier {
  List<SingleColor> _colors = [];

  List<SingleColor> get colors => _colors;

  inisialData() async {
    Uri url = Uri.parse(
        "https://http-req-bec2d-default-rtdb.firebaseio.com/colors.json");

    try {
      var hasil = await http.get(url);
      if (hasil.statusCode >= 200 && hasil.statusCode < 300) {
        var hasilData = json.decode(hasil.body) as Map<String, dynamic>;

        hasilData.forEach((key, value) {
          _colors.add(
            SingleColor(
              id: key,
              title: value["title"],
              status: value["status"],
            ),
          );
        });
        notifyListeners();
      } else {
        throw (hasil.statusCode);
      }
    } catch (err) {
      throw (err);
    }
  }

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

  void addColor(String title) async {
    Uri url = Uri.parse(
        "https://http-req-bec2d-default-rtdb.firebaseio.com/colors.json");

    try {
      var hasil = await http.post(
        url,
        body: json.encode({
          "title": title,
          "status": false,
        }),
      );
      if (hasil.statusCode >= 200 && hasil.statusCode < 300) {
        _colors.add(
          SingleColor(
            id: json.decode(hasil.body)["name"].toString(),
            title: title,
          ),
        );
        notifyListeners();
      } else {
        throw (hasil.statusCode);
      }
    } catch (err) {
      throw (err);
    }
  }

  void deleteColor(String id) async {
    Uri url = Uri.parse(
        "https://http-req-bec2d-default-rtdb.firebaseio.com/colors/$id.json");

    try {
      var hasil = await http.delete(url);
      if (hasil.statusCode >= 200 && hasil.statusCode < 300) {
        _colors.removeWhere((element) => element.id == id);
        notifyListeners();
      } else {
        throw (hasil.statusCode);
      }
    } catch (err) {
      throw (err);
    }
  }
}
