import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Info extends StatefulWidget {
  final item;
  final id;
  String name;
  final phone;
  String email;
  String address;
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
            child: Container(
              color: Colors.blueGrey[800],
              child: ListView.builder(
                itemCount: posts.length,
                  itemBuilder: (context,index) =>Container(
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
                  )),
            ),
          )
        ],
      ) ,
    );
  }
}
