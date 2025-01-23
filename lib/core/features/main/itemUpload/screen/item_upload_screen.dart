// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_e_commerce/core/controllers/file_upload_controller.dart';
import 'package:furniture_e_commerce/core/helper/show_loading_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';

import 'package:furniture_e_commerce/core/components/custom_back_button.dart';
import 'package:furniture_e_commerce/core/global/config.dart';
import 'package:furniture_e_commerce/core/locator/locator.dart';
import 'package:furniture_e_commerce/core/routes/route_name.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';

class UploadView extends StatefulWidget {
  const UploadView({super.key});

  @override
  State<UploadView> createState() => _UploadViewState();
}

class _UploadViewState extends State<UploadView> {
  Uint8List? imageFileUint8List;
  Config config = locator<Config>();
  FileUploadController fileUploadController = locator<FileUploadController>();

  TextEditingController sellerNameTextEditingController =
      TextEditingController();
  TextEditingController sellerPhoneTextEditingController =
      TextEditingController();
  TextEditingController itemNameTextEditingController = TextEditingController();
  TextEditingController itemDescriptionTextEditingController =
      TextEditingController();
  TextEditingController itemPriceTextEditingController =
      TextEditingController();

  bool isUploading = false;
  String downloadUrlOfImage = "";
  String? downloadUrlOfBgRemovedImage = "";
  String? tempFilePath;

  final List<String> allCategories = [
    'Sofas',
    'Chairs',
    'Tables',
    'Beds',
    'Cabinets',
    'Others',
  ];
  String? selectedCategory;

  //upload form screen
  Widget uploadFormScreen() {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Upload new Item",
          style: TextStyle(
              color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Navigator.canPop(context) ? const CommonBackButton() : null,
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
                onPressed: () {
                  //validate upload fields
                  if (isUploading != true) {
                    // false
                    validateUploadFormAndUploadItemInfo();
                  }
                },
                icon: const Icon(Icons.cloud_upload),
                color: const Color.fromARGB(255, 217, 129, 85)),
          ),
        ],
      ),
      body: ListView(
        children: [
          isUploading == true
              ? LinearProgressIndicator(
                  minHeight: 20,
                  color: Theme.of(context).primaryColor,
                )
              : Container(),

          //image
          SizedBox(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
                child: imageFileUint8List != null
                    ? Image.file(
                        File(downloadUrlOfImage),
                      )
                    : const Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 50,
                      )),
          ),

          const Divider(
            color: Colors.grey,
            thickness: 2,
          ),

          //seller name

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.person_pin_rounded,
              ),
              title: SizedBox(
                width: 250,
                child: TextField(
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                    controller: sellerNameTextEditingController,
                    decoration: const InputDecoration(
                      hintText: "seller name",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                    )),
              ),
            ),
          ),
          const Divider(
            thickness: 1,
          ),

          ListTile(
            leading: const Icon(
              Icons.phone,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  controller: sellerPhoneTextEditingController,
                  decoration: const InputDecoration(
                    hintText: "seller phone",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  )),
            ),
          ),
          const Divider(
            thickness: 1,
          ),

          ListTile(
            leading: const Icon(
              Icons.title,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  controller: itemNameTextEditingController,
                  decoration: const InputDecoration(
                    hintText: "item name",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  )),
            ),
          ),
          const Divider(
            thickness: 1,
          ),

          ListTile(
            leading: const Icon(
              Icons.description,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                style: const TextStyle(
                  color: Colors.grey,
                ),
                controller: itemDescriptionTextEditingController,
                decoration: const InputDecoration(
                  hintText: "item description",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            thickness: 1,
          ),

          ListTile(
            leading: const Icon(
              Icons.price_change,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  controller: itemPriceTextEditingController,
                  decoration: const InputDecoration(
                    hintText: "item Price",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  )),
            ),
          ),
          const SizedBox(height: 20),
          DropdownButton<String>(
            value: selectedCategory,
            hint: const Text('Choose a category'),
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(fontSize: 16),
            underline: Container(
              height: 2,
              color: Colors.blue,
            ),
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue!;
              });
            },
            items:
                allCategories.map<DropdownMenuItem<String>>((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
          ),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }

  validateUploadFormAndUploadItemInfo() async {
    try {
      if (imageFileUint8List != null) {
        if (sellerNameTextEditingController.text.isNotEmpty &&
            sellerPhoneTextEditingController.text.isNotEmpty &&
            itemNameTextEditingController.text.isNotEmpty &&
            itemPriceTextEditingController.text.isNotEmpty &&
            itemDescriptionTextEditingController.text.isNotEmpty) {
          setState(() {
            isUploading = true;
          });
          if (tempFilePath == null) {
            Fluttertoast.showToast(
                msg: "Images Background remove failed",
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.red);
            context.pushNamed(RouteName.homeView);
          }

          showLoadingDialog(context);
          downloadUrlOfBgRemovedImage =
              await fileUploadController.uploadFileToCloudinary(
                  tempFilePath: tempFilePath!, uploadPreset: "furniture");
          downloadUrlOfImage =
              await fileUploadController.uploadFileToCloudinary(
                  tempFilePath: downloadUrlOfImage, uploadPreset: "furniture");
          downloadUrlOfBgRemovedImage != "" ? saveItemInfoToFireStore() : null;
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(
              gravity: ToastGravity.CENTER,
              msg: "Please complete upload form. Every field is mandatory");
        }
      } else {
        print("Validation failed. Image file is null.");
        Fluttertoast.showToast(
            gravity: ToastGravity.CENTER, msg: "Please select image file");
      }
    } catch (e) {
      Logger().e(e.toString());
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  saveItemInfoToFireStore() {
    String itemUniqueId = DateTime.now().millisecondsSinceEpoch.toString();

    FirebaseFirestore.instance.collection("items").doc(itemUniqueId).set({
      "itemID": itemUniqueId,
      "itemName": itemNameTextEditingController.text,
      "itemDescription": itemDescriptionTextEditingController.text,
      "itemImage": downloadUrlOfImage,
      "itemBgRemoveUrl": downloadUrlOfBgRemovedImage,
      "sellerName": sellerNameTextEditingController.text,
      "sellerPhone": sellerPhoneTextEditingController.text,
      "itemPrice": itemPriceTextEditingController.text,
      "category": selectedCategory ?? "Other",
      "publishedDate": DateTime.now(),
      "status": "available",
    });
    Logger().i("success 1");
    Fluttertoast.showToast(msg: "your new item upload successfully");
    setState(() {
      isUploading = false;
      imageFileUint8List = null;
    });
    context.pushNamed(RouteName.homeView);
    // Navigator.push(context, MaterialPageRoute(builder: (c) => const Home()));
  }

  // default screen
  Widget defaultScreen() {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: const CommonBackButton(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Upload New Item",
          style: TextStyle(
            color: AppColors.primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //add lotie cameraAnimation json file
            Lottie.asset(
              "assets/lottie/cameraAnimation.json",
              width: 400,
              height: 200,
            ),
            ElevatedButton(
              onPressed: () {
                showDialogBox();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              child: const Text(
                "Scan New Item",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showDialogBox() async {
    return showDialog(
      context: context,
      builder: (e) {
        return SimpleDialog(
          backgroundColor: Theme.of(context).canvasColor,
          title: const Text(
            "Select Image",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                imageFileUint8List = await fileUploadController
                    .chooseImageSource(ImageSource.camera, context,
                        (String path) {
                  downloadUrlOfImage = path;
                });
                tempFilePath = await fileUploadController
                    .saveToTemporaryFile(imageFileUint8List!);
                downloadUrlOfImage = imageFileUint8List.toString();
                setState(() {});
              },
              child: const Text(
                "Capture Image with Camera",
                style: TextStyle(color: Colors.lightBlue),
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                imageFileUint8List = await fileUploadController
                    .chooseImageSource(ImageSource.gallery, context,
                        (String path) {
                  downloadUrlOfImage = path;
                });

                tempFilePath = await fileUploadController
                    .saveToTemporaryFile(imageFileUint8List!);

                setState(() {});
              },
              child: const Text(
                "Choose image from Gallary",
                style: TextStyle(
                  color: Colors.lightBlue,
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return imageFileUint8List == null ? defaultScreen() : uploadFormScreen();
  }
}
