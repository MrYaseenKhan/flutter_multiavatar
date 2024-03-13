import 'package:flutter/cupertino.dart';

class MultiAvatarProvider extends ChangeNotifier {
  String _nameAvatar = "Default User";

  String get geNameAvatar => _nameAvatar;

  set setNameAvatar(String value) {
    _nameAvatar = value;
    notifyListeners();
  }
}
