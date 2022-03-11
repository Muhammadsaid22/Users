import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:users/user_cubit.dart';
import 'info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Albums extends StatelessWidget {
  List<dynamic> avatar = [
    "assets/avataaars(1).png",
    "assets/avataaars(2).png",
    "assets/avataaars(3).png",
    "assets/avataaars(4).png",
    "assets/avataaars(5).png",
    "assets/avataaars(6).png",
    "assets/avataaars(7).png",
    "assets/avataaars(8).png",
    "assets/avataaars(9).png",
    "assets/avataaars(10).png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          "Users",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocProvider(
        create: (context) => UserCubit()..userinfo(),
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserInitial || state is UserLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              return Container(
                  color: Colors.blueGrey[800],
                  height: double.infinity,
                  padding: EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: state.userslist.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Info(
                                    id: state.userslist[index].id,
                                    item: avatar[state.userslist[index].id - 1],
                                    name: '${state.userslist[index].username}',
                                    phone: state.userslist[index].phone,
                                    email: '${state.userslist[index].email}',
                                    address:
                                        '${state.userslist[index].address.street}',
                                  )),
                        );
                      },
                      child: Stack(clipBehavior: Clip.none, children: [
                        Card(
                            elevation: 4,
                            margin: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 6),
                            child: Hero(
                              tag: "${state.userslist[index].id}",
                              child: Container(
                                padding: EdgeInsets.all(12),
                                height: MediaQuery.of(context).size.height * .4,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Image.asset(
                                  '${avatar[index]}',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            )),
                        Positioned(
                          top: 20,
                          left: 20,
                          child: Text(
                            state.userslist[index].username,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ]),
                    ),
                  ));
            }
            else if (state is UserError) {
              return Center(
                child: Text("Error State!"),
              );
            }
            else {
              return Center(
                child: Text("Unknown State "),
              );
            }
          },
        ),
      ),
    );
  }
}
