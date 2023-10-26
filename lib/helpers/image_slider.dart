import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/my_padding.dart';
import 'package:fourlinkmobileapp/helpers/size_config.dart';

class ImageSlider extends StatefulWidget {
  List<String> imgs; //images from API

  ImageSlider(this.imgs); //constractor

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  // to change the dots indecator
  int _current = 0;
  // to change the colors of buttons
  Color star = Colors.white;
  Color share = Colors.white;
  Color back = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _displayImages(context), // display the images
      Positioned(
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: Container(
//          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: map<Widget>(widget.imgs, (index, url) {
              return Container(
                width: 10,
                height: 10,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                decoration: BoxDecoration(shape: BoxShape.circle, color: _current == index ? Colors.white : Colors.grey),
              );
            }),
          ),
        ),
      )
      //set the indecators dots
//          Positioned(
//              top:  ScreenUtil().setSp(20),
//              left: 0.0,
//              //right: 0.0,
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  IconButton(
//                   icon: Icon(Icons.star_border,color: star,size:  ScreenUtil().setSp(30),),
//                    iconSize:  ScreenUtil().setSp(25),
//                    onPressed: (){
//                     print("yes1");
//                     setState(() {
//                       star=Colors.deepPurple;
//                     });
//                    },
//                  ),
//                  IconButton(
//                    icon: Icon(Icons.share,color: share,size:  ScreenUtil().setSp(30),),
//                    iconSize:  ScreenUtil().setSp(25),
//                    onPressed: (){
//                      print("yes2");
//                      setState(() {
//                        share=Colors.deepPurple;
//                      });
//                    },
//                  )
//                ],
//              )
//          ),//set the left buttons
//          Positioned(
//              top:  ScreenUtil().setSp(20),
//              right: 0.0,
//              //right: 0.0,
//              child:IconButton(
//                      icon: Icon(Icons.arrow_forward_ios,color: back,size:  ScreenUtil().setSp(20),),
//                      iconSize:  ScreenUtil().setSp(25),
//                      onPressed: (){
//                        print("yes1");
//                        setState(() {
//                          back=Colors.deepPurple;
//                        });
//                      },
//                   )
//          ),//set right arrow button
    ]);
  }

  //help functons
  //////////////////////////////////////////

// dynamic count and generate the dots number of images
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }


  //create full screen Carousel with context
  CarouselSlider _displayImages(BuildContext mediaContext) {
    return CarouselSlider(
      options: CarouselOptions(
        height: SizeConfig.screenHeight,
        // aspectRatio: 16/9,
        viewportFraction: 0.8,
        // initialPage: 0,
        // enableInfiniteScroll: true,
        // reverse: false,
        autoPlay: true,
       /* autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,*/
        onPageChanged:  (index,reason) {
          setState(() {
            _current = index;
          });
        },
        scrollDirection: Axis.horizontal,
      ),
      items: widget.imgs.map(
            (url) {
          // print("url is $url");
          return Padding(
//            padding: PADDING_symmetric(horizontalFactor: 1.5, verticalFactor: 1.5),
            padding: PADDING_only(
                left:  1.5,right: 1.5, top: 1.5,bottom: 4),
            child: Container(
              height: MediaQuery.of(context).size.height * 10,
              // color: Colors.green,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/dmy_1.png',
                  image: url,
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  fit: BoxFit.fill,
                ),
                // child: Image.network(url, fit: BoxFit.cover, width: 1000.0,height: 30,),
              ),
            ),
          );
        },
      ).toList(),
    );
}


}
