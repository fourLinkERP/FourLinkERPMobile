import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/Reviews/reviews.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../common/login_components.dart';

class ExternalDetection extends StatefulWidget {
  const ExternalDetection({Key? key}) : super(key: key);

  @override
  State<ExternalDetection> createState() => _ExternalDetectionState();
}

class _ExternalDetectionState extends State<ExternalDetection> {

  File? imageFile;
  final comment1Controller = TextEditingController();
  final comment2Controller = TextEditingController();
  final comment3Controller = TextEditingController();
  final comment4Controller = TextEditingController();
  final comment5Controller = TextEditingController();
  final comment6Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ListTile(
          leading: Image.asset('assets/images/logowhite2.png', scale: 3),
          title: Text('external_detection'.tr(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),
      body: Center(
        child: ListView(
          children: [
            const SizedBox(height: 20.0,),
            imageFile == null
                ? Image.asset('assets/fitness_app/imageIcon.png', height: 220.0, width: 220.0,)
                : ClipRRect(
                borderRadius: BorderRadius.zero,
                child: Image.file(imageFile!, height: 220.0, width: 220.0, )//fit: BoxFit.fill,)
            ),
            const SizedBox(height: 10.0,),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 70, right: 70),
              child: InkWell(
                onTap: () async {
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.storage, Permission.camera,
                  ].request();
                  if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                    showImagePicker(context);
                  } else {
                    print('no permission provided');
                  }
                },
                child: Container(
                  height: 50,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(200, 16, 46, 1),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(-4, -4),
                        )
                      ]
                  ),
                  child: Center(
                    child: Text(
                      "select_image".tr(),
                      style: const TextStyle(
                        color: Color.fromRGBO(200, 16, 46, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            Center(
              child: Container(
                height: 50,
                width: 300,
                child: defaultFormField(
                  enable: true,
                  label: 'write_a_comment'.tr(),
                  prefix: Icons.edit,
                  controller: comment1Controller,
                  type: TextInputType.text,
                  colors: Colors.blueGrey,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'comment must be non empty';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            imageFile == null
                ? Image.asset('assets/fitness_app/imageIcon.png', height: 220.0, width: 220.0,)
                : ClipRRect(
                borderRadius: BorderRadius.zero,
                child: Image.file(imageFile!, height: 220.0, width: 220.0, )//fit: BoxFit.fill,)
            ),
            const SizedBox(height: 10.0,),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 70, right: 70),
              child: InkWell(
                onTap: () async {
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.storage, Permission.camera,
                  ].request();
                  if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                    showImagePicker(context);
                  } else {
                    print('no permission provided');
                  }
                },
                child: Container(
                  height: 50,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(200, 16, 46, 1),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(-4, -4),
                        )
                      ]
                  ),
                  child: Center(
                    child: Text(
                      "select_image".tr(),
                      style: const TextStyle(
                        color: Color.fromRGBO(200, 16, 46, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            Center(
              child: Container(
                height: 50,
                width: 300,
                child: defaultFormField(
                  enable: true,
                  label: 'write_a_comment'.tr(),
                  prefix: Icons.edit,
                  controller: comment2Controller,
                  type: TextInputType.text,
                  colors: Colors.blueGrey,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'comment must be non empty';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            imageFile == null
                ? Image.asset('assets/fitness_app/imageIcon.png', height: 220.0, width: 220.0,)
                : ClipRRect(
                borderRadius: BorderRadius.zero,
                child: Image.file(imageFile!, height: 220.0, width: 220.0, )//fit: BoxFit.fill,)
            ),
            const SizedBox(height: 10.0,),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 70, right: 70),
              child: InkWell(
                onTap: () async {
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.storage, Permission.camera,
                  ].request();
                  if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                    showImagePicker(context);
                  } else {
                    print('no permission provided');
                  }
                },
                child: Container(
                  height: 50,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(200, 16, 46, 1),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(-4, -4),
                        )
                      ]
                  ),
                  child: Center(
                    child: Text(
                      "select_image".tr(),
                      style: const TextStyle(
                        color: Color.fromRGBO(200, 16, 46, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            Center(
              child: Container(
                height: 50,
                width: 300,
                child: defaultFormField(
                  enable: true,
                  label: 'write_a_comment'.tr(),
                  prefix: Icons.edit,
                  controller: comment3Controller,
                  type: TextInputType.text,
                  colors: Colors.blueGrey,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'comment must be non empty';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            imageFile == null
                ? Image.asset('assets/fitness_app/imageIcon.png', height: 220.0, width: 220.0,)
                : ClipRRect(
                borderRadius: BorderRadius.zero,
                child: Image.file(imageFile!, height: 220.0, width: 220.0, )//fit: BoxFit.fill,)
            ),
            const SizedBox(height: 10.0,),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 70, right: 70),
              child: InkWell(
                onTap: () async {
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.storage, Permission.camera,
                  ].request();
                  if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                    showImagePicker(context);
                  } else {
                    print('no permission provided');
                  }
                },
                child: Container(
                  height: 50,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(200, 16, 46, 1),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(-4, -4),
                        )
                      ]
                  ),
                  child: Center(
                    child: Text(
                      "select_image".tr(),
                      style: const TextStyle(
                        color: Color.fromRGBO(200, 16, 46, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            Center(
              child: Container(
                height: 50,
                width: 300,
                child: defaultFormField(
                  enable: true,
                  label: 'write_a_comment'.tr(),
                  prefix: Icons.edit,
                  controller: comment4Controller,
                  type: TextInputType.text,
                  colors: Colors.blueGrey,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'comment must be non empty';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            imageFile == null
                ? Image.asset('assets/fitness_app/imageIcon.png', height: 220.0, width: 220.0,)
                : ClipRRect(
                borderRadius: BorderRadius.zero,
                child: Image.file(imageFile!, height: 220.0, width: 220.0, )//fit: BoxFit.fill,)
            ),
            const SizedBox(height: 10.0,),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 70, right: 70),
              child: InkWell(
                onTap: () async {
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.storage, Permission.camera,
                  ].request();
                  if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                    showImagePicker(context);
                  } else {
                    print('no permission provided');
                  }
                },
                child: Container(
                  height: 50,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(200, 16, 46, 1),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(-4, -4),
                        )
                      ]
                  ),
                  child: Center(
                    child: Text(
                      "select_image".tr(),
                      style: const TextStyle(
                        color: Color.fromRGBO(200, 16, 46, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            Center(
              child: Container(
                height: 50,
                width: 300,
                child: defaultFormField(
                  enable: true,
                  label: 'write_a_comment'.tr(),
                  prefix: Icons.edit,
                  controller: comment5Controller,
                  type: TextInputType.text,
                  colors: Colors.blueGrey,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'comment must be non empty';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            imageFile == null
                ? Image.asset('assets/fitness_app/imageIcon.png', height: 220.0, width: 220.0,)
                : ClipRRect(
                borderRadius: BorderRadius.zero,
                child: Image.file(imageFile!, height: 220.0, width: 220.0, )//fit: BoxFit.fill,)
            ),
            const SizedBox(height: 10.0,),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 70, right: 70),
              child: InkWell(
                onTap: () async {
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.storage, Permission.camera,
                  ].request();
                  if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                    showImagePicker(context);
                  } else {
                    print('no permission provided');
                  }
                },
                child: Container(
                  height: 50,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(200, 16, 46, 1),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(-4, -4),
                        )
                      ]
                  ),
                  child: Center(
                    child: Text(
                      "select_image".tr(),
                      style: const TextStyle(
                        color: Color.fromRGBO(200, 16, 46, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            Center(
              child: Container(
                height: 50,
                width: 300,
                child: defaultFormField(
                  enable: true,
                  label: 'write_a_comment'.tr(),
                  prefix: Icons.edit,
                  controller: comment6Controller,
                  type: TextInputType.text,
                  colors: Colors.blueGrey,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'comment must be non empty';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 70, right: 70),
              child: InkWell(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  Reviews()),);},
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(200, 16, 46, 1),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(-4, -4),
                        )
                      ]
                  ),
                  child: Center(
                    child: Text(
                      "next".tr(),
                      style: const TextStyle(
                        color: Color.fromRGBO(200, 16, 46, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  final picker = ImagePicker();

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder){
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/5.2,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                          child: const Column(
                            children: [
                              Icon(Icons.image, size: 60.0,),
                              SizedBox(height: 12.0),
                              Text(
                                "Gallery",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              )
                            ],
                          ),
                          onTap: () {
                            _imgFromGallery();
                            Navigator.pop(context);
                          },
                        )),
                    Expanded(
                        child: InkWell(
                          child: const SizedBox(
                            child: Column(
                              children: [
                                Icon(Icons.camera_alt, size: 60.0,),
                                SizedBox(height: 12.0),
                                Text(
                                  "Camera",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            _imgFromCamera();
                            Navigator.pop(context);
                          },
                        ))
                  ],
                )),
          );
        }
    );
  }

  _imgFromGallery() async {
    await  picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage(File(value.path));
      }
    });
  }

  _imgFromCamera() async {
    await picker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage(File(value.path));
      }
    });
  }

  _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ] : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [AndroidUiSettings(
            toolbarTitle: "Image Cropper",
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {

      imageCache.clear();
      setState(() {
        imageFile = File(croppedFile.path);
      });
      // reload();
    }
  }

}