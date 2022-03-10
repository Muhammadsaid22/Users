import 'package:flutter/material.dart';
class Info extends StatelessWidget {
  final item;
  String? info;
 Info({ this.info,  this.item});
  @override
  Widget build(BuildContext context) {
    print(item);
    return Scaffold(
      body:Container(
        height: double.infinity,
        child: ListView.builder(
          itemCount: 1,
          itemBuilder:(context,index)=> Hero(
              tag: "${info}",
              child: Image.asset("${item}")
          ),
        ),
      ) ,
    );
  }
}
