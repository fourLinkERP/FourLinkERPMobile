import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math';



class Compress{
  Future<File?> compressImage(File storedImage) async {
    File? imageFile;
    final dir = await getTemporaryDirectory();
    Random random = Random();
    int randomNumber = random.nextInt(100);
    String randomNumberString = randomNumber.toString();
    String uploadedImageUrl = '';
    imageFile = await FlutterImageCompress.compressAndGetFile(
      storedImage.absolute.path,
      '${dir.absolute.path}/test$randomNumberString.jpg',
      minWidth: 250,
      minHeight: 150,
      quality: 10,
    );
    print('000:: ${dir.absolute.path}/test$randomNumberString.jpg');
    return imageFile;
  }


}