import 'package:shamsi_date/shamsi_date.dart';

String jalali2string(Date d) {
  final f = d.formatter;
  return '${f.yyyy}/${f.mm}/${f.dd}';
}

Jalali string2jalali(String d) {
  final f = d.split('/');
  return Jalali(toInt(f[0]), toInt(f[1]), toInt(f[2]));
}

int toInt(String data) {
  // print('toInt===== $data');
  if (data.isNotEmpty) {
    return int.parse(data);
  } else {
    return 0;
  }
}
