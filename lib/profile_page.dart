
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp( 
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'Amrutha',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Text(
                'Flutter Developer Intern',
                style: TextStyle(color: Colors.grey),
              ),

              const Divider(height: 30),

            
              Row(
                children: const [
                  Icon(Icons.email, color: Colors.blue),
                  SizedBox(width: 12),
                  Text('amrutha@example.com'),
                ],
              ),

              const SizedBox(height: 15),

              
              Row(
                children: const [
                  Icon(Icons.location_on, color: Colors.blue),
                  SizedBox(width: 12),
                  Text('Kerala, India'),
                ],
              ),

              const SizedBox(height: 15),

              
              Row(
                children: const [
                  Icon(Icons.school, color: Colors.blue),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'B.Tech in Information Technology',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
