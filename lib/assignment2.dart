import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// -------------------------------------------------------------------------
// 1. Class and State setup
// -------------------------------------------------------------------------
class AqiMonitorScreen extends StatefulWidget {
  const AqiMonitorScreen({super.key});

  @override
  State<AqiMonitorScreen> createState() => _AqiMonitorScreenState();
}

class _AqiMonitorScreenState extends State<AqiMonitorScreen> {
  Map<String, dynamic>? aqiSnapshot;
  bool dataIsLoading = true;

  @override
  void initState() {
    super.initState();
    loadAqiData();
  }

  // -------------------------------------------------------------------------
  // 2. Data Retrieval Logic (Refactored names)
  // -------------------------------------------------------------------------
  Future<void> loadAqiData() async {
    if (mounted) setState(() => dataIsLoading = true);

    // NOTE: Replace "YOUR_API_TOKEN" with your actual token
    final url = Uri.parse(
      "https://api.waqi.info/feed/here/?token=69465d3e8b078c31147440cb09855ce7dc7b4224",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'ok') {
          final data = responseData["data"];
          
          final aqiVal = data["aqi"] as int? ?? 0;
          final tempVal = data["iaqi"]?["t"]?["v"] as num? ?? 0;
          final locationName = data["city"]?["name"] as String? ?? "Location Data Missing";

          if (mounted) {
            setState(() {
              aqiSnapshot = {
                "aqiValue": aqiVal,
                "currentTemp": tempVal,
                "cityLocation": locationName,
              };
              dataIsLoading = false;
            });
          }
        } else {
           if (mounted) setState(() => dataIsLoading = false);
           print('API Status Not OK: ${responseData['data']}');
        }
      } else {
        if (mounted) setState(() => dataIsLoading = false);
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      if (mounted) setState(() => dataIsLoading = false);
      print('Network/Parsing Error: $e');
    }
  }

  // -------------------------------------------------------------------------
  // 3. AQI Style Mapping (Using vibrant colors)
  // -------------------------------------------------------------------------
  String getAqiStatusLabel(int aqi) {
    if (aqi <= 50) return "PERFECT VIBES ✨";
    if (aqi <= 100) return "CHILL ZONE 🌴";
    if (aqi <= 150) return "TAKE CARE ⚠️";
    if (aqi <= 200) return "RED FLAG 🚩";
    if (aqi <= 300) return "DANGER ZONE 🚨";
    return "SYSTEM CRITICAL ☠️";
  }

  Color getAqiVibrantColor(int aqi) {
    if (aqi <= 50) return Colors.greenAccent.shade700; // Perfect: Bright Green
    if (aqi <= 100) return Colors.limeAccent.shade700; // Chill: Lime Yellow
    if (aqi <= 150) return Colors.orangeAccent; // Take Care: Bright Orange
    if (aqi <= 200) return Colors.pinkAccent.shade700; // Red Flag: Hot Pink
    if (aqi <= 300) return Colors.redAccent.shade700; // Danger: Electric Red
    return Colors.deepPurpleAccent.shade700; // Critical: Deep Violet
  }

  Color getContrastTextColor(int aqi) {
    // Ensure text is readable on the vibrant background
    if (aqi <= 50 || aqi > 200) return Colors.white; 
    return Colors.black;
  }

  // -------------------------------------------------------------------------
  // 4. UI Build
  // -------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final aqi = aqiSnapshot?["aqiValue"] ?? 0;
    final primaryColor = getAqiVibrantColor(aqi);
    final textColor = getContrastTextColor(aqi);
    final temp = aqiSnapshot?["currentTemp"] ?? "--";
    final city = aqiSnapshot?["cityLocation"] ?? "Fetching Location...";

    return Scaffold(
      extendBodyBehindAppBar: true,
      // ใช้ AppBar แบบใส
      appBar: AppBar(
        title: Text(
          "V A P O R - A Q I",
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: TweenAnimationBuilder<Color?>(
        // TweenAnimationBuilder เพื่อให้การเปลี่ยนสีพื้นหลังดู Smooth
        tween: ColorTween(
          begin: primaryColor.withOpacity(0.9), 
          end: primaryColor, 
        ),
        duration: const Duration(milliseconds: 800),
        builder: (context, color, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color!, color.withOpacity(0.8), Colors.white], // ไล่สีจากสี AQI ไปหาสีขาว
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: dataIsLoading
                ? Center(
                    child: CircularProgressIndicator(color: textColor),
                  )
                : SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // 1. Location and Time (Top Bar)
                          Text(
                            city,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: textColor.withOpacity(0.9),
                              letterSpacing: 1.5,
                            ),
                          ),
                          
                          // 2. Main AQI Value (The big number)
                          Column(
                            children: [
                              Text(
                                "$aqi",
                                style: TextStyle(
                                  fontSize: 160, // ตัวเลขใหญ่สะใจ
                                  fontWeight: FontWeight.w900,
                                  color: textColor,
                                  height: 1, 
                                  shadows: [ // เงาเพื่อความเฟี้ยว
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: primaryColor.withOpacity(0.8),
                                      offset: const Offset(2, 2),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "AIR QUALITY INDEX",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: textColor.withOpacity(0.7),
                                  letterSpacing: 3,
                                ),
                              ),
                            ],
                          ),

                          // 3. Status and Temp Card
                          Card(
                            elevation: 15,
                            color: Colors.white.withOpacity(0.95), // Card สีขาวตัดกับพื้นหลัง
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 25,
                                horizontal: 20,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    getAqiStatusLabel(aqi),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: primaryColor, 
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const Divider(height: 25, thickness: 1, color: Colors.black12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.thermostat, color: primaryColor),
                                      const SizedBox(width: 10),
                                      Text(
                                        "TEMPERATURE: $temp °C",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
      // Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: dataIsLoading ? null : loadAqiData,
        label: const Text(
          "RE-SCAN ATMOSPHERE",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.radar_outlined),
        backgroundColor: Colors.pinkAccent, // ใช้สีชมพูตัดกับธีม
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 10,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
