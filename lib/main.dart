import 'package:flutter/material.dart';
import 'package:flutter_ctx/presentation/pages/root_page/root_page.dart';
import 'package:get/get.dart';

Future<void> loadOtherInit() async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadOtherInit();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.Protocols
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
