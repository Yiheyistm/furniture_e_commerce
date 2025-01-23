import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/components/custom_back_button.dart';
import 'package:furniture_e_commerce/core/features/main/services/storage_service.dart';
import 'package:furniture_e_commerce/core/locator/locator.dart';
import 'package:furniture_e_commerce/core/provider/theme_provider.dart';
import 'package:furniture_e_commerce/core/routes/route_name.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final StorageService _storageService = locator<StorageService>();
  bool _receiveNotifications = true;
  bool _darkThemeEnabled = false;

  @override
  void initState() {
    super.initState();
    _darkThemeEnabled = _storageService.getData("isDarkMode");
  }

  @override
  Widget build(BuildContext context) {
    final themeModeProvider = Provider.of<ThemeModeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  CommonBackButton(),
                  Text(
                    'Settings',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style:
                        TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                    onPressed: () {
                      context.pushNamed(RouteName.profileView);
                    },
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.labelLarge?.color),
                    ),
                  ),
                  // SvgPicture.asset('assets/icons/edit.svg'),
                  const Icon(Icons.edit),
                ],
              ),
              // ProfileUpdateForm(),
              const SizedBox(height: 10),
              const Text(
                'Notification Settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SwitchListTile(
                title: const Text('Receive Notifications'),
                value: _receiveNotifications,
                activeColor: Theme.of(context).primaryColor,
                trackOutlineColor: MaterialStatePropertyAll(
                    _receiveNotifications
                        ? Theme.of(context).primaryColor
                        : Colors.black),
                trackColor: const MaterialStatePropertyAll(Colors.white),
                isThreeLine: true,
                subtitle: Text(_darkThemeEnabled ? "ON" : "OFF"),
                onChanged: (value) {
                  setState(() {
                    _receiveNotifications = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'Appearance',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SwitchListTile(
                title: const Text('Dark Theme'),
                value: _darkThemeEnabled,
                activeColor: Theme.of(context).primaryColor,
                trackOutlineColor: MaterialStatePropertyAll(_darkThemeEnabled
                    ? Theme.of(context).primaryColor
                    : Colors.black),
                trackColor: const MaterialStatePropertyAll(Colors.white),
                isThreeLine: true,
                subtitle: Text(_darkThemeEnabled ? "ON" : "OFF"),
                thumbIcon: MaterialStatePropertyAll(Icon(
                  _darkThemeEnabled
                      ? Icons.nights_stay_sharp
                      : Icons.light_mode_rounded,
                )),
                onChanged: (value) {
                  setState(() {
                    _darkThemeEnabled = value;
                    themeModeProvider.toggleTheme(_darkThemeEnabled);
                  });
                },
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
