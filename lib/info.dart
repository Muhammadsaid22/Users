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
  List<dynamic> comments =[];
  bool isLoading = true;
  bool isLoading1 = true;
  @override
  void initState() {
    super.initState();
    UsersInfo();
  }
  void UsersInfo() async {
    Uri url = Uri.parse("https://jsonplaceholder.typicode.com/posts?userId=${widget.id}");
    final response = await http.get(url);
    posts = json.decode(response.body);
    setState(() {
      isLoading = false;
    });
  }
  Future <void> UsersComments(int id) async {
    Uri url = Uri.parse("https://jsonplaceholder.typicode.com/comments?postId=${id}");
    final response = await http.get(url);
    comments = json.decode(response.body);
  }
  Future<void> showbottom(context) async {
    showModalBottomSheet(
      backgroundColor: Colors.blueGrey[800],
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
            color: Colors.blueGrey[800],
            margin: EdgeInsets.only(
                top: 16,
                left: 8,
                right: 8
            ),
            height: 350.0,
            width: 375.0,
            child: Column(
              children: [
                Text("Comments",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),),
                Container(
                   padding: EdgeInsets.only(
                top: 40.0,
                left:140,
                right: 140.0,
                  ),
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
                SizedBox(height: 20,),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context,index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                        padding: EdgeInsets.all(12),
                        height: 70,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                                color: Colors.black
                            )
                        ),
                        child: ListTile(
                          title: Text(comments[index]['name'],
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),),
                          subtitle: Text(comments[index]["body"],
                            maxLines: 2,),
                        ),
                      ),),
                ),
                Container(
                  height: 35,
                    padding: EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.black
                      )
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',

                      ),
                    )),

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
                    onTap: ()  async {
                     await UsersComments(posts[index]["id"]);
                      showbottom(context);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                      padding: EdgeInsets.all(12),
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.red
                        )
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
