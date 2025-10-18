import 'package:flutter/material.dart';

// สร้าง Custom Widget สำหรับ Profile Card
class ProfileCard extends StatelessWidget {
  final String name;
  final String position;
  final String email;
  final String phoneNumber;
  final String imageUrl;

  ProfileCard({
    required this.name,
    required this.position,
    required this.email,
    required this.phoneNumber,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ใช้ CircleAvatar สำหรับแสดงรูปโปรไฟล์
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(imageUrl),
            ),
            const SizedBox(height: 15),
            // ชื่อและตำแหน่ง
            Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              position,
              style: const TextStyle(color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            // แสดงอีเมลและเบอร์โทร
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.email, size: 16, color: Colors.blue),
                const SizedBox(width: 6),
                Text(
                  email,
                  style: const TextStyle(color: Color.fromARGB(255, 247, 139, 223)),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.phone, size: 16, color: Colors.green),
                const SizedBox(width: 6),
                Text(
                  phoneNumber,
                  style: const TextStyle(color: Color.fromARGB(255, 247, 139, 223)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
