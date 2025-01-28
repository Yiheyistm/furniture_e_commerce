// ignore_for_file: unused_local_variable

import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:furniture_e_commerce/core/components/custom_button.dart';
import 'package:furniture_e_commerce/core/components/custom_text.dart';
import 'package:furniture_e_commerce/core/features/main/profile/screen/profile_update_form.dart';
import 'package:furniture_e_commerce/core/features/main/services/storage_service.dart';
import 'package:furniture_e_commerce/core/locator/locator.dart';
import 'package:furniture_e_commerce/core/provider/auth_provider.dart';
import 'package:furniture_e_commerce/core/provider/theme_provider.dart';
import 'package:furniture_e_commerce/core/routes/route_name.dart';
import 'package:furniture_e_commerce/core/utils/app_assets.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final StorageService _storageService = locator<StorageService>();
  bool _receiveNotifications = true;
  bool _darkThemeEnabled = false;

  @override
  void initState() {
    super.initState();
    _darkThemeEnabled = _storageService.getData("isDarkMode") ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<MyAuthProvider>(context);
    final themeModeProvider = Provider.of<ThemeModeProvider>(context);
    return Scaffold(
      body: Center(
        child: FadeInLeft(
          child: Consumer<MyAuthProvider>(
            builder: (context, value, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      // const SizedBox(
                      //   height: 50,
                      // ),
                      Stack(children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  AppAssets.banner2,
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: 2, sigmaY: 2), // Blur intensity
                            child: Container(
                              color: Colors.black.withValues(
                                  alpha: .3), // Optional: Add a color overlay
                            ),
                          ),
                        ),
                        const Center(
                          child: IgnorePointer(
                            ignoring: true,
                            child: CustomText(
                              "Profile",
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () => value.selectImage(context),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(45),
                                      child: value.isLoading
                                          ? const SpinKitWaveSpinner(
                                              color: AppColors.primaryColor,
                                              size: 100,
                                            )
                                          : Image.network(
                                              value.userModel.img,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ProfileUpdateForm()));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: AppColors.primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.camera_alt,
                                          color: AppColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              value.userModel.userName,
                              fontSize: 16,
                              color: AppColors.greyColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              value.userModel.email,
                              fontSize: 13,
                              color: AppColors.greyColor,
                            ),
                          ],
                        ),
                      ]),
                    ],
                  ),
                  // const ProfileUpdateForm(),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(12)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Notification Settings',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SwitchListTile(
                                title: const Text('Receive Notifications'),
                                value: _receiveNotifications,
                                activeColor: Theme.of(context).primaryColor,
                                trackOutlineColor: WidgetStateProperty.all(
                                    Theme.of(context).primaryColor),
                                // trackColor: const MaterialStateProperty(
                                //     Colors.white),
                                isThreeLine: true,
                                subtitle:
                                    Text(_receiveNotifications ? "ON" : "OFF"),
                                onChanged: (value) {
                                  _receiveNotifications = value;
                                  // context.read<MyAuthProvider>().setReceiveNotification(value);
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(12)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Appearance Settings',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SwitchListTile(
                                title: const Text('Dark Theme'),
                                value: _darkThemeEnabled,
                                activeColor: Theme.of(context).primaryColor,
                                trackOutlineColor: WidgetStatePropertyAll(
                                    _darkThemeEnabled
                                        ? Theme.of(context).primaryColor
                                        : Colors.black),
                                trackColor:
                                    const WidgetStatePropertyAll(Colors.white),
                                isThreeLine: true,
                                subtitle:
                                    Text(_darkThemeEnabled ? "ON" : "OFF"),
                                thumbIcon: WidgetStatePropertyAll(Icon(
                                  _darkThemeEnabled
                                      ? Icons.nights_stay_sharp
                                      : Icons.light_mode_rounded,
                                )),
                                onChanged: (value) {
                                  setState(() {
                                    _darkThemeEnabled = value;
                                    themeModeProvider
                                        .toggleTheme(_darkThemeEnabled);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(12)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Account Settings',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).canvasColor,
                                    maximumSize: const Size(700, 50),
                                    padding: const EdgeInsets.all(0)),
                                onPressed: () {
                                  context.pushNamed(RouteName.editProfileView);
                                },
                                child: Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.color),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Theme.of(context).canvasColor,
                              maximumSize: const Size(700, 50),
                              padding: const EdgeInsets.all(0)),
                          onPressed: () {
                            context.pushNamed(RouteName.orderView, extra: {
                              'userId': value.userModel.uid,
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor,
                              borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(12)),
                            ),
                            child: Text(
                              'My Orders',
                              style: TextStyle(
                                  fontSize: 20,
                                  // fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.color),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: CustomButton(
                              text: "LogOut",
                              onTap: () async{
                                await Provider.of<MyAuthProvider>(context,
                                        listen: false)
                                    .logOut(context);
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // OrderScreen(userId: value.userModel.uid),

                  //const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
