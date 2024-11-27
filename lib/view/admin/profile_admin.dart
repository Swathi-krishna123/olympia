import 'package:flutter/material.dart';
import 'package:olympia/constants/colors.dart';
import 'package:olympia/constants/fonts.dart';

class ProfileAdmin extends StatelessWidget {
  const ProfileAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Admin Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: const AssetImage('assets/images/profile_placeholder.png'), // Placeholder image
                backgroundColor: Colors.grey.shade200,
              ),
              const SizedBox(height: 16),
              Text(
                'Anil Krishnan',
                style:Appfonts.normaltext,
              ),
              const SizedBox(height: 8),
              Text(
                'admin@example.com',
                style: Appfonts.normaltext,
              ),
              const SizedBox(height: 24),
              ElevatedButton(style: ButtonStyle(backgroundColor:WidgetStatePropertyAll(Appcolors.themecolor)),
                onPressed: () {
                  // Implement edit profile functionality
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Edit Profile'),
                        content: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Name',
                              ),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Save changes
                              Navigator.of(context).pop();
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child:  Text('Edit Profile',style: Appfonts.normaltext,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
