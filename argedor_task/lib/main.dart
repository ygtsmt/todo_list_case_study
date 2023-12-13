import 'package:argedor_task/app/ui/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: const ColorScheme.dark(), useMaterial3: false),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Column(
            children: [
              const Text(
                'BTC',
              ),
              Text(
                'Global average',
                style:
                    Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.grey, fontWeight: FontWeight.w200),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          actions: [
            Row(
              children: [
                const Icon(Icons.notification_add_outlined),
                const SizedBox(
                  width: 16,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow.shade300,
                ),
                const SizedBox(
                  width: 16,
                )
              ],
            )
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 14, 17, 44),
        body: const SafeArea(
          child: HomeScreen(),
        ),
      ),
    );
  }
}
