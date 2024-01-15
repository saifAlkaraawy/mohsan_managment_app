import 'package:almosan_mangement/screens/home_page/home_made.dart';
import 'package:almosan_mangement/utilites/custom_color%20copy.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
      url: 'https://fzdbunxmofmpafbfpakw.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ6ZGJ1bnhtb2ZtcGFmYmZwYWt3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTY0Njc2MDYsImV4cCI6MjAxMjA0MzYwNn0.BQpCmJU0jfHwFVKgnwJRkHBxNtXyRrX69jBbBwNR8SY');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: kpramiryColor,
          appBarTheme: AppBarTheme(backgroundColor: kpramiryColor)),
      home: const HomePage(),
    );
  }
}
