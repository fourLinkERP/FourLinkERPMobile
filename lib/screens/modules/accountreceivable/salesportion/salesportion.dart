import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fourlinkmobileapp/models/products.dart';

class SalesPortionListPage extends StatefulWidget {
  const SalesPortionListPage({Key? key}) : super(key: key);

  @override
  _SalesPortionListPageState createState() => _SalesPortionListPageState();
}

class _SalesPortionListPageState extends State<SalesPortionListPage> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade900,
        title: Container(
          height: 38,
          child: TextField(

            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[850],
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade500,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none),
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                hintText: "Search users"),
          ),
        ),
      ),
      body: Container(
        color: Colors.grey.shade900,
        child: 2 > 0
            ? ListView.builder(
            itemCount:10,
            // itemCount: _foundedUsers.length,
            itemBuilder: (context, index) {

            })
            : Center(
            child: Text(
              "No users found",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }

  userComponent({required User user}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Container(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(user.image),
                )),
            SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(user.name,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500)),
              SizedBox(
                height: 5,
              ),
              Text(user.username, style: TextStyle(color: Colors.grey[500])),
            ])
          ]),
          GestureDetector(
            onTap: () {
              setState(() {
                user.isFollowedByMe = !user.isFollowedByMe;
              });
            },
            child: AnimatedContainer(
                height: 35,
                width: 110,
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                    color: user.isFollowedByMe
                        ? Colors.blue[700]
                        : Color(0xffffff),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: user.isFollowedByMe
                          ? Colors.transparent
                          : Colors.grey.shade700,
                    )),
                child: Center(
                    child: Text(user.isFollowedByMe ? 'Unfollow' : 'Follow',
                        style: TextStyle(
                            color: user.isFollowedByMe
                                ? Colors.white
                                : Colors.white)))),
          )
        ],
      ),
    );
  }
}
