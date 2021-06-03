import 'package:flutter/material.dart';

import 'providers.dart';

class Appointment with ChangeNotifier {
  static const fileName = 'lib/app/src/providers/appointment.dart';

  Auth _auth;
  Auth get auth => _auth;
}
