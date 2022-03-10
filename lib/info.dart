import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:users/Users.dart';
class Info extends StatefulWidget {
  final item;
  final id;
  String name;
  final phone;
  String email;
  String address;
  bool isLoading = true;
 Info({
   required this.id,
   required this.item,
   required this.name,
   required this.phone,
   required this.email,
   required this.address
 });

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  List<dynamic> posts =[];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    UsersInfo();
  }
  void UsersInfo() async {
    Uri url = Uri.parse("https://jsonplaceholder.typicode.com/posts?userId=${widget.id}");
    final response = await http.get(url);
    posts = json.decode(response.body);
    print(posts);
    setState(() {
      isLoading = false;
    });
  }
  void showbottom(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            margin: EdgeInsets.only(
                top: 16,
                left: 8,
                right: 8
            ),
            height: 320.0,
            width: 375.0,
            child: Column(
              children: [
                Container(
                   padding: EdgeInsets.only(
                top: 40.0,
                left:140,
                right: 140.0),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        30.0,
                      ),
                    ),
                  ),
                  height: 5.0,
                  width: 130.0,
                ),
                Container(
                  height: 250,
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context,index) => Text("Yawasin gowo jamoasi !!!")),
                ),
                TextFormField(),

              ],
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    print(widget.item);
    return Scaffold(
      body:CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height*.4,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(widget.name),
              background: Hero(
                  tag: "${widget.id}",
                  child: Image.asset(widget.item)),
            ),
            backgroundColor: Colors.blueGrey,
          ),
          SliverFillRemaining(
            child: isLoading?Center(
              child: CircularProgressIndicator(),)
                :Container(
              color: Colors.blueGrey[800],
              child: ListView.builder(
                itemCount: posts.length,
                  itemBuilder: (context,index) =>InkWell(
                    onTap: (){
                      showbottom(context);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                      padding: EdgeInsets.all(12),
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: ListTile(
                        title: Text(posts[index]['title'],
                          maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),),
                        subtitle: Text(posts[index]["body"],
                        maxLines: 2,),
                      ),
                    ),
                  )),
            ),
          )
        ],
      ) ,
    );
  }
}
