import 'package:flutter/material.dart';
class Users extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            //mainAxisSpacing: 10,
            mainAxisExtent: 140,
           // crossAxisSpacing: 10,
          //childAspectRatio: 3/2
        ),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) => Container(
          height: 180,
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(15)
          ),
          child:Image(
            image: AssetImage(""),
              fit: BoxFit.cover
          )
        )

      ),
    );
  }
}
