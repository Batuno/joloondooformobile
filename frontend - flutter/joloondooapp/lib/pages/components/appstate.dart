import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppState extends ChangeNotifier {
  int? _userId;

  AppState() {
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    const storage = FlutterSecureStorage();
    String? userId = await storage.read(key: 'userId');
    if (userId != null) {
      _userId = int.parse(userId);
      notifyListeners();
    }
  }

  int get userId => _userId ?? 0;

  void setUserId(int userId) {
    _userId = userId;
    notifyListeners();
  }
}

// import 'package:flutter/material.dart';

// class AppState extends ChangeNotifier {
//   int _userId;

//   AppState(this._userId);

//   int get userId => _userId;

//   void setUserId(int userId) {
//     _userId = userId;
//     notifyListeners(); 
//   }
// }
