import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:service_sentinel_fe_v2/firebase_options_auth.dart';

import 'app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase for hosting main app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Firebase for authentication
  await Firebase.initializeApp(
    name: 'lattui-auth',
    options: AuthFirebaseOptions.currentPlatform,
  );

  // Initialize Hive for local storage (Guest mode)
  await Hive.initFlutter();

  runApp(
    const ProviderScope(
      child: ServiceSentinelApp(),
    ),
  );
}
