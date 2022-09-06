import 'package:d_info/d_info.dart';
import 'package:expense_tracker/config/api.dart';
import 'package:expense_tracker/config/app_request.dart';
import 'package:expense_tracker/config/session.dart';
import 'package:expense_tracker/data/model/user.dart';

class SourceUser {
  static Future<bool> login(String email, String password) async {
    String url = '${Api.user}/login.php';
    Map? responseBody = await AppRequest.post(url, {
      'email': email,
      'password': password,
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      var mapUser = responseBody['data'];
      Session.saveUser(User.fromJson(mapUser));
    }
    return responseBody['success'];
  }

  static Future<bool> register(
      String name, String email, String password) async {
    String url = '${Api.user}/register.php';
    Map? responseBody = await AppRequest.post(url, {
      'name': name,
      'email': email,
      'password': password,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      // var mapUser = responseBody['data'];
      // Session.saveUser(User.fromJson(mapUser));
      DInfo.dialogSuccess('Sign Up Berhasil!');
      DInfo.closeDialog();
    } else {
      if (responseBody['message'] == 'email') {
        DInfo.dialogError('Email sudah terdaftar');
      } else {
        DInfo.dialogError('Sign Up Gagal');
      }
      DInfo.closeDialog();
    }
    return responseBody['success'];
  }
}
