import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/3dview/models.dart';
import 'package:furniture_e_commerce/core/provider/auth_provider.dart';
import 'package:furniture_e_commerce/core/routes/route_name.dart';
import 'package:furniture_e_commerce/settings/settings.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<MyAuthProvider>(context);
    final userModel = authProvider.userModel;

    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          // User Profile Header
          UserAccountsDrawerHeader(
            margin: const EdgeInsets.only(bottom: 0),
            onDetailsPressed: () {
              context.pop();
              context.pushNamed(RouteName.profileView);
            },
            accountName: Text(
              userModel.userName,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 20,
              ),
            ),
            accountEmail: Text(
              userModel.email,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 16),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(userModel.img),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(.3),
            ),
          ),

          // Drawer Body
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.view_in_ar),
                  title: const Text('AR View'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => ThreeDModelsList()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('About Us'),
                  onTap: () {
                    context.pushNamed(RouteName.aboutUsView);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.contact_mail),
                  title: const Text('Contact Us'),
                  onTap: () {
                    context.pushNamed(RouteName.contactUsView);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('Terms & Conditions'),
                  onTap: () {
                    context.pushNamed(RouteName.termsAndConditionsView);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => const SettingsPage()));
                  },
                ),
                // Add more items here
              ],
            ),
          ),

          // Sign out option
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title:
                  const Text('Sign Out', style: TextStyle(color: Colors.red)),
              onTap: () {
                authProvider.logOut(context);
                Navigator.of(context).pop(); // close the drawer
              },
            ),
          ),
        ],
      ),
    );
  }
}
