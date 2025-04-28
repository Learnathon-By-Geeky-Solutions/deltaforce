import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/features/Settings/view-model/settings_view_model.dart';
import 'package:voice_bridge/features/authentication/views/auth/change_password.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';
import 'package:voice_bridge/widgets/border_list_tile.dart';

class SettingsScreen extends StatelessWidget {
  final ThemeViewModel _themeController = Get.put(ThemeViewModel());

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: AppColor.whiteColor),
        ),
        backgroundColor: AppColor.appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => BorderedListTile(
                  leading: Icon(
                    _themeController.isDarkMode.value
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                  title: const Text(
                    'Dark Mode',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Switch(
                    value: _themeController.isDarkMode.value,
                    onChanged: (value) => _themeController.toggleTheme(),
                    activeColor: Colors.amber,
                  ),
                  borderColor: Theme.of(context).dividerColor,
                )),
            const SizedBox(height: 12),
            BorderedListTile(
              leading: const Icon(Icons.language),
              title: const Text(
                'Language',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {

              },
            ),
            SizedBox(height: 12),
            BorderedListTile(
              leading: Icon(Icons.update),
              title: Text(
                'Password Update',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Get.to(PasswordUpdateScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
