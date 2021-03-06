import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate/providers/image_provider.dart';
import 'package:translate/providers/language_provider.dart';
import 'package:translate/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TranslateViewModel>(
            create: (_) => TranslateViewModel()),
        ChangeNotifierProvider<ImageViewModel>(create: (_) => ImageViewModel())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
