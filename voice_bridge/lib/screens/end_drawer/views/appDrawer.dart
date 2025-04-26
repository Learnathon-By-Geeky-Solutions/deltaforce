import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:voice_bridge/features/Settings/UI/settings_page_ui.dart';
import 'package:voice_bridge/features/authentication/services/firebase_auth_service.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  final services = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColor.appBarColor,
              image: DecorationImage(
                image: AssetImage('assets/images/drawer_header.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Text(
              "My App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to home screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to profile screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SettingsScreen()));
              // Navigate to settings screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to notifications screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Make Payment'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to notifications screen
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Feedback'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to help screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to about screen
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sign Out'),
            onTap: () {
              services.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
