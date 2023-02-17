import 'package:flutter/material.dart';
import 'package:very_good_coffee_app/app/app.dart';
import 'package:very_good_coffee_app/app/injectable/injectable.dart';
import 'package:very_good_coffee_app/bootstrap.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupDependencies();

  bootstrap(() => const App());
}
