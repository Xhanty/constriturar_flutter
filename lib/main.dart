import 'package:flutter/material.dart';
import 'package:constriturar/app.dart';
import 'package:constriturar/app/core/config/environment_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const String env = String.fromEnvironment('ENV', defaultValue: 'dev');
  await EnvironmentConfig.loadEnv(env);
  runApp(const MyApp());
}