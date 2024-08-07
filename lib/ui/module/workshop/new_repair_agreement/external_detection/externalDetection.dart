import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/dto.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class ExternalDetection extends StatefulWidget {
  const ExternalDetection({Key? key}) : super(key: key);

  @override
  State<ExternalDetection> createState() => _ExternalDetectionState();
}

class _ExternalDetectionState extends State<ExternalDetection> {

  File? imageFile1;
  File? imageFile2;
  File? imageFile3;
  File? imageFile4;
  File? imageFile5;
  File? imageFile6;

  String? imageString1 = "";
  String? imageString2 = "";
  String? imageString3 = "";
  String? imageString4 = "";
  String? imageString5 = "";
  String? imageString6 = "";

  final comment1Controller = TextEditingController();
  final comment2Controller = TextEditingController();
  final comment3Controller = TextEditingController();
  final comment4Controller = TextEditingController();
  final comment5Controller = TextEditingController();
  final comment6Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView(
          children: [
            const SizedBox(height: 10.0,),
            Column(
              children: [
                Row(
                  children: [
                    imageFile1 == null
                        ? Image.asset('assets/fitness_app/imageIcon.png', height: 150.0, width: 150.0,)
                        : ClipRRect(
                        borderRadius: BorderRadius.zero,
                        child: Image.file(imageFile1!, height: 150.0, width: 150.0,)//fit: BoxFit.fill,)
                    ),
                    const SizedBox(width: 10.0),
                        SizedBox(
                          height: 50,
                          width: 130,
                          //margin: const EdgeInsets.only(top: 20, left: 70, right: 70),
                          child: InkWell(
                            onTap: () async {
                              Map<Permission, PermissionStatus> statuses = await [
                                Permission.storage, Permission.camera,
                              ].request();
                              if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                                showImagePicker(context, _imgFromGallery, _imgFromCamera);

                              } else {
                                print('no permission provided');
                              }
                            },
                            child: Container(
                              height: 55,
                              width: 145,
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
                  ],
                ),
               // const SizedBox(height: 10.0,),
                SizedBox(
                  height: 90,
                  width: 300,
                  child: TextFormField(
                    controller: comment1Controller,
                    maxLines: 8,
                    decoration: InputDecoration(
                      labelText: 'write_a_comment'.tr(),
                      labelStyle: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      prefixIcon: const Icon (Icons.edit, color: Colors.blueGrey, size: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.blueGrey, width: 0.6),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.blue, width: 1.0)),
                    ),
                    onChanged: (value){
                      DTO.page4Comments["comment1"] = value;
                      print("DTO page4 comment1 " + DTO.page4Comments["comment1"]!);

                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10.0,),
            Column(
              children: [
                Row(
                  children: [
                    imageFile2 == null
                        ? Image.asset('assets/fitness_app/imageIcon.png', height: 150.0, width: 150.0,)
                        : ClipRRect(
                        borderRadius: BorderRadius.zero,
                        child: Image.file(imageFile2!, height: 150.0, width: 150.0, )//fit: BoxFit.fill,)
                    ),
                    const SizedBox(width: 10.0,),
                        SizedBox(
                          height: 50,
                          width: 130,
                          child: InkWell(
                            onTap: () async {
                              Map<Permission, PermissionStatus> statuses = await [
                                Permission.storage, Permission.camera,
                              ].request();
                              if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                                showImagePicker(context, _imgFromGallery2, _imgFromCamera2);
                              } else {
                                print('no permission provided');
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 120,
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
                  ],
                ),
                SizedBox(
                  height: 90,
                  width: 300,
                  child: TextFormField(
                    controller: comment2Controller,
                    maxLines: 8,
                    decoration: InputDecoration(
                      labelText: 'write_a_comment'.tr(),
                      labelStyle: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      prefixIcon: const Icon (Icons.edit, color: Colors.blueGrey, size: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.blueGrey, width: 0.6),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.blue, width: 1.0)),
                    ),
                    onChanged: (value){
                      DTO.page4Comments["comment2"] = value;
                      print("DTO page4 comment2 " + DTO.page4Comments["comment2"]!);

                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0,),
            Column(
              children: [
                Row(
                  children: [
                    imageFile3 == null
                        ? Image.asset('assets/fitness_app/imageIcon.png', height: 150.0, width: 150.0,)
                        : ClipRRect(
                        borderRadius: BorderRadius.zero,
                        child: Image.file(imageFile3!, height: 150.0, width: 150.0, )//fit: BoxFit.fill,)
                    ),
                    const SizedBox(width: 10.0,),
                        SizedBox(
                          height: 50,
                          width: 130,
                          child: InkWell(
                            onTap: () async {
                              Map<Permission, PermissionStatus> statuses = await [
                                Permission.storage, Permission.camera,
                              ].request();
                              if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                                showImagePicker(context, _imgFromGallery3, _imgFromCamera3);
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
                  ],
                ),
                SizedBox(
                  height: 90,
                  width: 300,
                  child:TextFormField(
                    controller: comment3Controller,
                    maxLines: 8,
                    decoration: InputDecoration(
                      labelText: 'write_a_comment'.tr(),
                      labelStyle: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      prefixIcon: const Icon (Icons.edit, color: Colors.blueGrey, size: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.blueGrey, width: 0.6),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.blue, width: 1.0)),
                    ),
                    onChanged: (value){
                      DTO.page4Comments["comment3"] = value;
                      print("DTO page4 comment3 " + DTO.page4Comments["comment3"]!);

                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0,),
            Column(
              children: [
                Row(
                  children: [
                    imageFile4 == null
                        ? Image.asset('assets/fitness_app/imageIcon.png', height: 150.0, width: 150.0,)
                        : ClipRRect(
                      borderRadius: BorderRadius.zero,
                      child: Image.file(imageFile4!, height: 150.0, width: 150.0, ),//fit: BoxFit.fill,)
                    ),
                    const SizedBox(width: 10.0,),
                        SizedBox(
                          height: 50,
                          width: 130,
                          child: InkWell(
                            onTap: () async {
                              Map<Permission, PermissionStatus> statuses = await [
                                Permission.storage, Permission.camera,
                              ].request();
                              if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                                showImagePicker(context, _imgFromGallery4, _imgFromCamera4);
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

                  ],
                ),
                SizedBox(
                  height: 90,
                  width: 300,
                  child: TextFormField(
                    controller: comment4Controller,
                    maxLines: 8,
                    decoration: InputDecoration(
                      labelText: 'write_a_comment'.tr(),
                      labelStyle: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      prefixIcon: const Icon (Icons.edit, color: Colors.blueGrey, size: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.blueGrey, width: 0.6),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.blue, width: 1.0)),
                    ),
                    onChanged: (value){
                      DTO.page4Comments["comment4"] = value;
                      print("DTO page4 comment4 " + DTO.page4Comments["comment4"]!);

                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 10.0,),
            Column(
              children: [
                Row(
                  children: [
                    imageFile5 == null
                        ? Image.asset('assets/fitness_app/imageIcon.png', height: 150.0, width: 150.0,)
                        : ClipRRect(
                        borderRadius: BorderRadius.zero,
                        child: Image.file(imageFile5!, height: 150.0, width: 150.0, )//fit: BoxFit.fill,)
                    ),
                    const SizedBox(width: 10.0,),
                        SizedBox(
                          height: 50,
                          width: 130,
                          child: InkWell(
                            onTap: () async {
                              Map<Permission, PermissionStatus> statuses = await [
                                Permission.storage, Permission.camera,
                              ].request();
                              if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                                showImagePicker(context, _imgFromGallery5, _imgFromCamera5);
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

                  ],
                ),
                SizedBox(
                  height: 90,
                  width: 300,
                  child: TextFormField(
                    controller: comment5Controller,
                    maxLines: 8,
                    decoration: InputDecoration(
                      labelText: 'write_a_comment'.tr(),
                      labelStyle: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      prefixIcon: const Icon (Icons.edit, color: Colors.blueGrey, size: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.blueGrey, width: 0.6),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.blue, width: 1.0)),
                    ),
                    onChanged: (value){
                      DTO.page4Comments["comment5"] = value;
                      print("DTO page4 comment5 " + DTO.page4Comments["comment5"]!);

                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 10.0,),
            Column(
              children: [
                Row(
                  children: [
                    imageFile6 == null
                        ? Image.asset('assets/fitness_app/imageIcon.png', height: 150.0, width: 150.0,)
                        : ClipRRect(
                        borderRadius: BorderRadius.zero,
                        child: Image.file(imageFile6!, height: 150.0, width: 150.0, )//fit: BoxFit.fill,)
                    ),
                    const SizedBox(width: 10.0,),
                        SizedBox(
                          height: 50,
                          width: 130,
                          child: InkWell(
                            onTap: () async {
                              Map<Permission, PermissionStatus> statuses = await [
                                Permission.storage, Permission.camera,
                              ].request();
                              if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                                showImagePicker(context, _imgFromGallery6, _imgFromCamera6);
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
                  ],
                ),
                SizedBox(
                  height: 90,
                  width: 300,
                  child: TextFormField(
                    controller: comment6Controller,
                    maxLines: 8,
                    decoration: InputDecoration(
                      labelText: 'write_a_comment'.tr(),
                      labelStyle: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      prefixIcon: const Icon (Icons.edit, color: Colors.blueGrey, size: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.blueGrey, width: 0.6),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.blue, width: 1.0)),
                    ),
                    onChanged: (value){
                      DTO.page4Comments["comment6"] = value;
                      print("DTO page4 comment6 " + DTO.page4Comments["comment6"]!);

                    },
                  ),
                )
              ],
            ),
          ],
        ),
    );
  }

  final picker1 = ImagePicker();
  final picker2 = ImagePicker();
  final picker3 = ImagePicker();
  final picker4 = ImagePicker();
  final picker5 = ImagePicker();
  final picker6 = ImagePicker();

  void showImagePicker(BuildContext context, VoidCallback pickerGallery, VoidCallback pickerCamera) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5.2,
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
                        ),
                      ],
                    ),
                    onTap: () {
                      pickerGallery();
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: const Column(
                      children: [
                        Icon(Icons.camera_alt, size: 60.0,),
                        SizedBox(height: 12.0),
                        Text(
                          "Camera",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                    onTap: () {
                      pickerCamera();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _imgFromGallery() async {
    final pickedFile = await picker1.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    if (pickedFile != null) {
      _cropImage(File(pickedFile.path));
    }
  }

  Future<void> _imgFromCamera() async {
    final pickedFile = await picker1.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    if (pickedFile != null) {
      _cropImage(File(pickedFile.path));
    }
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
        imageFile1 = File(croppedFile.path);
        convertImageToBase64String1(imageFile1);
      });
    }
  }

  _imgFromGallery2() async {
    await  picker2.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage2(File(value.path));
      }
    });
  }

  _imgFromCamera2() async {
    await picker2.pickImage(
        source: ImageSource.camera, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage2(File(value.path));
      }
    });
  }

  _cropImage2(File imgFile) async {
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
        imageFile2 = File(croppedFile.path);
        convertImageToBase64String2(imageFile2);
      });
      // reload();
    }
  }

  _imgFromGallery3() async {
    await  picker3.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage3(File(value.path));
      }
    });
  }

  _imgFromCamera3() async {
    await picker3.pickImage(
        source: ImageSource.camera, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage3(File(value.path));
      }
    });
  }

  _cropImage3(File imgFile) async {
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
        imageFile3 = File(croppedFile.path);
        convertImageToBase64String3(imageFile3);
      });
      // reload();
    }
  }

  _imgFromGallery4() async {
    await  picker4.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage4(File(value.path));
      }
    });
  }

  _imgFromCamera4() async {
    await picker4.pickImage(
        source: ImageSource.camera, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage4(File(value.path));
      }
    });
  }

  _cropImage4(File imgFile) async {
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
        imageFile4 = File(croppedFile.path);
        convertImageToBase64String4(imageFile4);
      });
    }
  }

  _imgFromGallery5() async {
    await  picker5.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage5(File(value.path));
      }
    });
  }

  _imgFromCamera5() async {
    await picker5.pickImage(
        source: ImageSource.camera, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage5(File(value.path));
      }
    });
  }

  _cropImage5(File imgFile) async {
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
        imageFile5 = File(croppedFile.path);
        convertImageToBase64String5(imageFile5);
      });
      // reload();
    }
  }

  _imgFromGallery6() async {
    await  picker6.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage6(File(value.path));
      }
    });
  }

  _imgFromCamera6() async {
    await picker6.pickImage(
        source: ImageSource.camera, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage6(File(value.path));
      }
    });
  }

  _cropImage6(File imgFile) async {
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
        imageFile6 = File(croppedFile.path);
        convertImageToBase64String6(imageFile6);
      });
    }
  }

  convertImageToBase64String1(File? image) async{
    if (image != null) {
      List<int> imageBytes = await image.readAsBytes();
      imageString1 = base64Encode(imageBytes);
      DTO.page4Images["image1"] = imageString1!;
      print("DTO page4 image1 " + DTO.page4Images["image1"]!);
    }
  }
  convertImageToBase64String2(File? image) async{
    if (image != null) {
      List<int> imageBytes = await image.readAsBytes();
      imageString2 = base64Encode(imageBytes);
      DTO.page4Images["image2"] = imageString2!;
      print("DTO page4 image2 " + DTO.page4Images["image2"]!);
    }
  }
  convertImageToBase64String3(File? image) async{
    if (image != null) {
      List<int> imageBytes = await image.readAsBytes();
      imageString3 = base64Encode(imageBytes);
      DTO.page4Images["image3"] = imageString3!;
      print("DTO page4 image3 " + DTO.page4Images["image3"]!);
    }
  }
  convertImageToBase64String4(File? image) async{
    if (image != null) {
      List<int> imageBytes = await image.readAsBytes();
      imageString4 = base64Encode(imageBytes);
      DTO.page4Images["image4"] = imageString4!;
      print("DTO page4 image4 " + DTO.page4Images["image4"]!);
    }
  }
  convertImageToBase64String5(File? image) async{
    if (image != null) {
      List<int> imageBytes = await image.readAsBytes();
      imageString5 = base64Encode(imageBytes);
      DTO.page4Images["image5"] = imageString5!;
      print("DTO page4 image5 " + DTO.page4Images["image5"]!);
    }
  }
  convertImageToBase64String6(File? image) async{
    if (image != null) {
      List<int> imageBytes = await image.readAsBytes();
      imageString6 = base64Encode(imageBytes);
      DTO.page4Images["image6"] = imageString6!;
      print("DTO page4 image6 " + DTO.page4Images["image6"]!);
    }
  }
}