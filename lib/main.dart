import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Laout', style: TextStyle(color: Colors.white)),
        centerTitle: false,
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              height: 300, 
              width: 120, 
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15)
              )
            ),

            Positioned(
            top: 22,
            right: 20,
            child :Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
            )),

            Positioned(
            top: 112,
            right: 20,
            child :Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellow,
              ),
            )),

            Positioned(
            top: 202,
            right: 20,
            child :Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
            ))
          ],
        ),
      ),

      // body: Stack(
      //   alignment: AlignmentDirectional.center,
      //   children: [
      //     Container(height: 150, width: 150, color: Colors.red),

      //     Container(
      //       height: 100,
      //       width: 100,
      //       decoration: BoxDecoration(
      //         shape: BoxShape.circle,
      //         color: Colors.green,
      //       ),
      //     ),

      //     Positioned(
      //       top: 20,
      //       right: 20,
      //       child: Container(
      //         height: 50,
      //         width: 50,
      //         decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: Colors.yellow,
      //         ),
      //         child: Text('99+', textAlign: TextAlign.right),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
