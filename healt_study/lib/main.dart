import "dart:io";

import 'package:flutter/material.dart';
import "package:health/health.dart";
import "package:permission_handler/permission_handler.dart";

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: DashboardScreen()),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Kullanıcıdan izin aldığımız method.
  Future<void> authorize() async {
    try {
      Platform.isIOS ? await Permission.sensors.request() : await Permission.activityRecognition.request();

      bool? hasPermissions = await health.hasPermissions(types, permissions: permissions);
      bool authorized = false;

      if (hasPermissions == null || hasPermissions == false) {
        authorized = await health.requestAuthorization(types, permissions: permissions);

        if (authorized) {
          // İzinler alındı, sağlık verilerini çekebilirsiniz.
          fetchData();
        } else {
          // İzinler reddedildi, kullanıcıya bilgi ver.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Sağlık verilerine erişim izni reddedildi."),
            ),
          );
        }
      } else {
        // İzinler zaten verilmiş.
        fetchData();
      }
    } on HealthException catch (error) {
      print("HealthException: $error");
      // Hata çıkarsa girilecek blok
    }
  }

  // Biz health connect kullandığımız için
// useHealthConnectIfAvailable özelliğini true yapmamız gerekiyor
  HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);

// Verilerimizi koyacağımız listemiz
  List<HealthDataPoint> dataList = [];
  final List<HealthDataType> types = [
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.BLOOD_OXYGEN,
    HealthDataType.STEPS,
    HealthDataType.HEART_RATE,
    HealthDataType.BODY_TEMPERATURE,
  ];

  // Örnekte 5 adet veri çekiyoruz o sebeple 5 adet read-write izni ekliyoruz
  final permissions = [
    HealthDataAccess.READ_WRITE,
    HealthDataAccess.READ_WRITE,
    HealthDataAccess.READ_WRITE,
    HealthDataAccess.READ_WRITE,
    HealthDataAccess.READ_WRITE,
  ];
  Future<List<HealthDataPoint>>? fetchData() async {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));

    dataList.clear();

    try {
      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(yesterday, now, types);

      dataList.addAll((healthData.length < 50) ? healthData : healthData.sublist(0, 50));
      dataList = HealthFactory.removeDuplicates(dataList);

      return dataList;
    } on HealthException {
      // Hata olursa girilecek blok
    }
    return [];
  }

  Future<void> requestHealthPermissions() async {
    // Sağlık izinlerini kontrol et
    PermissionStatus status = await Permission.activityRecognition.status;

    if (status.isDenied) {
      // Eğer izin reddedilmişse, kullanıcıdan izin iste
      status = await Permission.activityRecognition.request();

      if (status.isGranted) {
        // İzin verildiyse, sağlık verilerini çekmeye devam et
        fetchData();
      } else {
        // İzin verilmediyse, kullanıcıya bilgi ver
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Sağlık verilerine erişim izni reddedildi."),
          ),
        );
      }
    } else if (status.isGranted) {
      // İzin zaten verilmişse, sağlık verilerini çekmeye devam et
      fetchData();
    }
  }

  @override
  Widget build(final BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              requestHealthPermissions();
            },
            child: const Text('0')),
        ElevatedButton(
            onPressed: () {
              authorize();
            },
            child: const Text('1')),
        ElevatedButton(
            onPressed: () {
              fetchData();
            },
            child: const Text('2'))
      ],
    ));
  }
}
