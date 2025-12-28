import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

  static String convertStringTimeToDateChatting(DateTime time) {
    return DateFormat('EEE \'at\' ${_timeFormatter()}').format(time.toLocal());
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static DateTime convertStringToDatetime(String dateTime) {
    return DateFormat("yyyy-MM-dd hh:mm:ss").parse(dateTime);
  }


  static String dateStringMonthYear(DateTime ? dateTime) {
    return DateFormat('d MMM,y').format(dateTime!);
  }

  static String convertStringTimeToDate(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  static String dateTimeStringToDate(String dateTime) {
    return DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd').parse(dateTime));
  }

  static String convert24HourTimeTo12HourTime(DateTime time) {
    return DateFormat(_timeFormatter()).format(time);
  }


  static String timeToTimeString(TimeOfDay time) {
    DateTime dateTime = DateTime(2000, 01, 01, time.hour, time.minute);
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss').parse(dateTime).toLocal();
  }


  static String localDateToIsoStringAMPMOrder(DateTime dateTime) {
    //return DateFormat('dd MMM yyyy, h:mm a ').format(dateTime.toLocal());
    return DateFormat('dd/MM/yyyy, hh:mm a ').format(dateTime.toLocal());
  }

  static String localDateToIsoStringAMPMPackage(DateTime dateTime) {
    //return DateFormat('dd MMM yyyy, h:mm a ').format(dateTime.toLocal());
    return DateFormat('dd/MM/yyyy, hh:mm a ').format(dateTime.toLocal());
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    //return DateFormat('HH:mm').format(isoStringToLocalDate(dateTime));
    return DateFormat('hh:mm a').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd:MM:yy').format(isoStringToLocalDate(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MMTdd hh:mm:ss').format(dateTime.toLocal());
  }
  static String localDateToIsoStringAMPM(DateTime dateTime) {
    return DateFormat('${_timeFormatter()} | dd-MMM-yyyy ').format(dateTime.toLocal());
  }

  static String isoStringToLocalDateAndTime(String dateTime) {
    return DateFormat('MMM yyyy ddThh:mm a').format(isoStringToLocalDate(dateTime));
  }

  static String dateFormatForWalletBonus(String dateTime) {
    return DateFormat('dd MMM, yyyy').format(isoStringToLocalDate(dateTime));
  }
  static String dateTimeStringToDateTime(String dateTime) {
   // return DateFormat('dd MMM, yyyy hh:mm').format(DateFormat('yyyy-MM-ddTHH:mm:ss').parse(dateTime));
    return DateFormat('dd/MM/yyyy h:mm a').format(DateFormat('yyyy/M/-ddTh:mm:ss a').parse(dateTime));
  }

  static DateTime isoUtcStringToLocalTimeOnly(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
  }

  static String dateTimeStringToDateAndTime(String dateTime) {
    return DateFormat('HH:mm a, dd MMM yyyy').format(DateFormat('yyyy-MM-ddTHH:mm:ss').parse(dateTime));
  }

  static String convert24HourTimeTo12HourTimeWithDay(DateTime time, bool isToday) {
    if(isToday){
      return DateFormat('\'Today at\' ${_timeFormatter()}').format(time);
    }else{
      return DateFormat('\'Yesterday at\' ${_timeFormatter()}').format(time);
    }

  }

  static String isoStringToLocalDateAndTimeConversation(String dateTime) {
    return DateFormat('dd MMM yyyy \'at\' ${_timeFormatter()}').format(isoUtcStringToLocalDate(dateTime));
  }

  static String isoStringToDateTimeString(String dateTime) {
    return DateFormat('dd MMM yyyy  ${_timeFormatter()}').format(isoStringToLocalDate(dateTime));
  }
  static String estimatedDateYear(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }
  static String _timeFormatter() {
    return 'hh:mm a';
    // return Get.find<SplashController>().configModel.timeformat == '24' ? 'HH:mm' : 'hh:mm a';
  }

  static String dateMonthYearTime(DateTime ? dateTime) {
    //return DateFormat('d MMM,y HH:mm').format(dateTime!);
    return DateFormat('d/M/yyy hh:mm a').format(dateTime!);
  }

  static DateTime isoUtcStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
  }

  static String stringYear(DateTime ? dateTime) {
    return DateFormat('y').format(dateTime!);
  }

  static int countDays(DateTime ? dateTime) {
    final startDate = dateTime!;
    final endDate = DateTime.now();
    final difference = endDate.difference(startDate).inDays;
    return difference;
  }

  static String customTime(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime justNow = now.subtract(const Duration(minutes: 1));
    DateTime localDateTime = dateTime.toLocal();

    if (!localDateTime.difference(justNow).isNegative) {
      return 'just now';
    }

    String roughTimeString = DateFormat('jm').format(dateTime);

    if (localDateTime.day == now.day && localDateTime.month == now.month && localDateTime.year == now.year) {
      return roughTimeString;
    }

    DateTime yesterday = now.subtract(const Duration(days: 1));

    if (localDateTime.day == yesterday.day && localDateTime.month == now.month && localDateTime.year == now.year) {
      return 'yesterday';
    }

    if (now.difference(localDateTime).inDays < 4) {

      String weekday = DateFormat('EEEE').format(dateTime.toLocal());

      return weekday;
    }

    return localDateToIsoStringAMPM(dateTime);
  }

}
