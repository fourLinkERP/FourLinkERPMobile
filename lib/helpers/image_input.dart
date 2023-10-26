import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/size_config.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  Function _saveImage;
  File imageFile;
  bool _wrong;
  String userImage;

  ImageInput(this._saveImage, this.imageFile, this._wrong, this.userImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  @override
  Widget build(BuildContext context) {
    Widget imagePlace = GestureDetector(
        onTap: () => _showChooses(context),
        child: Image.asset(
          widget._wrong == false ? "assets/images/cam_user.png" : "assets/images/wrong_user.png",
          scale: 0.8,
          width: SizeConfig.screenWidth! * 0.2,
          height: SizeConfig.screenWidth! * 0.2,
          fit: BoxFit.fill,
        ));

    if (widget.imageFile != null) {
      imagePlace = GestureDetector(
        onTap: () => _showChooses(context),
        child: Image.file(
          widget.imageFile,
          alignment: Alignment.center,
          width: SizeConfig.screenWidth! * 0.2,
          height: SizeConfig.screenWidth! * 0.2,
          fit: BoxFit.fill,
        ),
      );
    } /*else if (widget.userImage != null) {
      imagePlace = GestureDetector(
        onTap: () => _showChooses(context),
        child: Image.network(
          widget.userImage,
          alignment: Alignment.center,
          width: SizeConfig.screenWidth * 0.2,
          height: SizeConfig.screenWidth * 0.2,
          fit: BoxFit.fill,
        ),
      );
    }*/

//    if(widget.ui_type=="small")// for small image
//      {
//        imagePlace=GestureDetector(
//          onTap: ()=>_showChooses(context),
//          child: Icon(
//            Icons.camera_alt,
//            color: white,
//            size: SizeConfig.safeBlockVertical*3,
//          ),
//        );
//      }

//    Widget imagePlace=Text('Please choose image of Your product With size smaller than 400 KB',
//      style: TextStyle(fontSize:  SizeConfig.fontSize14),);
//    if(imageFile!=null)
//    {
//      imagePlace=Image.file(imageFile, height: 300.0,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,
//        alignment: Alignment.center,);
//    }
//    else if(widget._product!=null)
//    {
//      imagePlace=Image.network(widget._product.image, height: 300.0,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,
//        alignment: Alignment.center,);
//    }

    return imagePlace;
  }

  _showChooses(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(10.5),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlinedButton(
                  //borderSide: BorderSide(width: 0.0),
                  onPressed: () => _getImage(ImageSource.camera), //_getImage(context,ImageSource.camera),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.camera,
                        color: Colors.amber,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text('Camera'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                OutlinedButton(
                  //borderSide: BorderSide(width: 0.0),
                  onPressed: () => _getImage(ImageSource.gallery),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.image,
                        color: Colors.deepPurple,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text('Gallary'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  _getImage(ImageSource source) {
    ImagePicker.platform.pickImage(source: source).then((image) {
      setState(() {
        File theImage= image as File;
        widget.imageFile = theImage;
        widget._saveImage(image);
      });
      Navigator.pop(context);
    });
  }
}
