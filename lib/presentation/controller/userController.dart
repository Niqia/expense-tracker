import 'package:expense_tracker/data/model/user.dart';
import 'package:get/get.dart';

class userController extends GetxController {
  final _data = User().obs;

  // GETTER
  User get data => _data.value;

  // SETTER
  setData(n) => _data.value = n;
}
