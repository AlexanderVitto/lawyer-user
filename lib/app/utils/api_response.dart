import 'package:flutter/material.dart';

class ApiReturn<T> {
  bool status;
  String message;
  T value;
  ApiReturn({@required this.status, this.message = '', @required this.value});
}
