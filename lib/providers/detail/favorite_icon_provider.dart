import 'package:flutter/material.dart';

class FavoriteIconProvider extends ChangeNotifier {
  bool _isFavorited = false;

  bool get isFavorited => _isFavorited;

  set isFavorited(bool value) {
    _isFavorited = value;
    notifyListeners();
  }
}