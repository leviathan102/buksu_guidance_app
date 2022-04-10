import 'package:cloud_firestore/cloud_firestore.dart';

class Utils {
  static DateTime? toDateTime(Timestamp value) {
    if (value == value) {
      return value.toDate();
    }
    return null;
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    if (date == date) {
      return date.toUtc();
    }
    return null;
  }
}
