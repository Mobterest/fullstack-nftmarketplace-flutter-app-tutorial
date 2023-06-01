import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  bool _profileStatus = true;
  bool get profileStatus => _profileStatus;

  void setProfile(bool newProfileStatus) {
    _profileStatus = newProfileStatus;
    notifyListeners();
  }
}
