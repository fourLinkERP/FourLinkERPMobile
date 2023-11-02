import'package:flutter/material.dart';
class NewRequest extends StatelessWidget {
  const NewRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: ListView(
        children:[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(80, 55),
              primary: const Color.fromRGBO(144, 16, 46, 1),
              padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80),
              ),
            ),
            onPressed: () {},
            child: const Text('Request Vacation',style: TextStyle(color: Colors.white, fontSize: 18.0,),),
          )
        ],
      ),
    );
  }
}
