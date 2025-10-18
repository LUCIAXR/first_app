import 'package:flutter/material.dart';
import 'AssignmentWeek6.dart'; // เรียกใช้ไฟล์ AssignmentWeek6.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Widget ProfileCard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Custom Widget ProfileCard'),
        ),
        body: Center(
          child: ProfileCard(
            name: 'Techawat Maneeniyom',
            position: 'Programmer Rookie',
            email: 'Maneeniyom_t@silpakorn.edu',
            phoneNumber: '0802348293',
            imageUrl: 'https://scontent.fbkk7-3.fna.fbcdn.net/v/t39.30808-6/302726068_1414419302418230_8064932503394980913_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeHEWai9OoSJ8uzhuQ5fWKCcdg7rRkqNcFp2DutGSo1wWrWMi2tRODWPuhmPvsbYCNzOgNC2rc1FrzMs5xwCU6V9&_nc_ohc=EDrBxnleLK8Q7kNvwGQuKdy&_nc_oc=AdnfGu_SIbctOvau8MsldbR6P2zWv702ehZos7C66AxQtrvbcQIZeb8SmKEUIhOJnZY&_nc_zt=23&_nc_ht=scontent.fbkk7-3.fna&_nc_gid=TRIBzC8jDWJQ7Whe2vUFUg&oh=00_Afdavy4fDzlKppn_zko9SR12CrviEyh0eKsIC_i2UXt8NA&oe=68F8E417',
          ),
        ),
      ),
    );
  }
}
