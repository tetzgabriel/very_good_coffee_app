import 'package:flutter/material.dart';
import 'package:very_good_coffee_app/app/app.dart';
import 'package:very_good_coffee_app/bootstrap.dart';
import 'package:very_good_coffee_app/core/injectable/injectable.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupDependencies();

  bootstrap(() => const App());
}
