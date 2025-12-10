import 'package:flutter/material.dart';
import 'package:mamyapp/features/auth/presentation/pages/log_in.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BabyCare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFFDFBF7),  
      ),
      home: Login(), 
    );
  }
}