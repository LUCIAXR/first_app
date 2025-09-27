import 'package:flutter/material.dart';
import 'assignment2.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vapor AQI Dashboard', // ชื่อแอพสไตล์เฟี้ยวๆ
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // ตั้งค่าให้ใช้ Light Mode ที่สดใส เพื่อรองรับดีไซน์ Vibrant
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal, // ใช้สี Teal เป็นสีฐานที่ดูสดใส
          brightness: Brightness.light, // เปลี่ยนเป็น Light Mode เพื่อให้พื้นหลังสีขาวเข้ากับ Gradient
        ),
        useMaterial3: true,
      ),
      home: const AqiMonitorScreen(),
    );
  }
}