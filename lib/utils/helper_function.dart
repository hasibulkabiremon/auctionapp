import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<bool> isConnectedToInternet() async {
  final result = await Connectivity().checkConnectivity();
  return result == ConnectivityResult.wifi ||
      result == ConnectivityResult.mobile;
}

getFormattedDate(DateTime dt, {String pattern = 'dd/MM/yyyy'}) =>
    DateFormat(pattern).format(dt);

showMsg(BuildContext context, String msg) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));