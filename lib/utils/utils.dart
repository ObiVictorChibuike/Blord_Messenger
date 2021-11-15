import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Utils {
  static String? getFormattedTimeDate(DateTime? date){
    // var dateString = DateFormat.yMMMEd().format(date) +", "+ DateFormat.jm().format(date);
    if (date == null) {
      return null;
    }  else {
      var dateString = DateFormat.yMMMEd().format(date);
      return dateString;
    }
  }

  static DateTime? toDateTime(Timestamp? value) {
    if (value == null) return null;
    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime? date) {
    if (date == null) return null;
    return date.toUtc();
  }
}
