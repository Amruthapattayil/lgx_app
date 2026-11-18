
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,

        // Back button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
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

              const Row(
                children: [
                  Icon(Icons.email, color: Colors.blue),
                  SizedBox(width: 12),
                  Text('amrutha@example.com'),
                ],
              ),

              const SizedBox(height: 15),

              const Row(
                children: [
                  Icon(Icons.location_on, color: Colors.blue),
                  SizedBox(width: 12),
                  Text('Kerala, India'),
                ],
              ),

              const SizedBox(height: 15),

              const Row(
                children: [
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
