import 'dart:io';

import 'package:flutter/material.dart';

class CreateProvider extends ChangeNotifier {
  File? _image;
  File? get image => _image;

  void setImageFile(File newImage) {
    _image = newImage;
    notifyListeners();
  }
}
