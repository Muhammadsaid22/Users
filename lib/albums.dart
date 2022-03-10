import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'info.dart';

class Albums extends StatefulWidget {
  @override
  State<Albums> createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  bool favorite = true;
  List<dynamic> avatar = [
    "assets/avataaars(10).png",
    "assets/avataaars(1).png",
    "assets/avataaars(2).png",
    "assets/avataaars(3).png",
    "assets/avataaars(4).png",
    "assets/avataaars(5).png",
    "assets/avataaars(6).png",
    "assets/avataaars(7).png",
    "assets/avataaars(8).png",
    "assets/avataaars(9).png",
  ];
  List<dynamic> newslist =[];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    UsersInfo();
  }
  void UsersInfo() async {
    Uri url = Uri.parse("https://jsonplaceholder.typicode.com/users");
    final response = await http.get(url);
    newslist = json.decode(response.body);
    print(newslist);
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Users",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold
        ),
        ),
      ),
      body: isLoading?Center(
          child: CircularProgressIndicator())
          :Container(
        color: Colors.blueGrey[800],
        height: double.infinity,
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: newslist.length,
            itemBuilder: (context,index)=> InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Info
                        (
                        id: newslist[index]['id'],
                        item: avatar[newslist[index]["id"]-1],
                        name: '${newslist[index]["username"]}',
                        phone: newslist[index]["phone"],
                        email: '${newslist[index]["email"]}',
                        address: '${newslist[index]["address"]["street"]}',
                      )
                  ),
                );
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
                    child: Hero(
                      tag: "${newslist[index]["id"]}",
                      child: Container(
                        padding:EdgeInsets.all(12),
                        height: MediaQuery.of(context).size.height*.4,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Image.asset('${avatar[index]}',
                        fit: BoxFit.fitHeight,
                        ),
                      ),
                    )
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Text(newslist[index]["username"],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:24,
                      fontWeight: FontWeight.bold
                    ),),
                  )
              ]
              ),
            ),
            ),
      ),
    );
  }
}
