import 'package:intl/intl.dart';

class Appformat {
  static String date(String stringDate) { // 2022-02-05
    DateTime dateTime = DateTime.parse(stringDate);
    return DateFormat('d MMM yyyy', 'id_ID').format(dateTime); // 5 Feb 2022
  }
}
