import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:users/cubit/comment/comment_cubit.dart';
import 'package:users/cubit/posts/posts_cubit.dart';


class Info extends StatelessWidget {
  final item;
  int id;
  String username;

  Info(this.item, this.id, this.username);

  Future<void> showbottom(context, int id) async {
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
            margin: EdgeInsets.only(top: 16, left: 8, right: 8),
            height: 350.0,
            width: 375.0,
            child: Column(
              children: [
                Text(
                  "Comments",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 40.0,
                    left: 140,
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
                SizedBox(
                  height: 20,
                ),
                BlocProvider(
                  create: (context) => CommentCubit()..commentinfo(id),
                  child: BlocBuilder<CommentCubit, CommentState>(
                    builder: (context, state) {
                      if(state is CommentInitial || state is CommentLoading){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      else if(state is CommentLoaded){
                        return Container(
                          height: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: ListView.builder(
                            itemCount: state.comments.length,
                            itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              padding: EdgeInsets.all(12),
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(color: Colors.black)),
                              child: ListTile(
                                title: Text(
                                  state.comments[index].name,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                subtitle: Text(
                                  state.comments[index].body,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      else if(state is CommentError){
                        return Center(child: Text("Error State"),);
                      }
                      else{
                        return Center(child: Text('Unknown state !'),);
                      }
                    },

                  ),
                ),
                Container(
                    height: 35,
                    padding: EdgeInsets.only(left: 8,top: 8,right: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black)),
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
    return Scaffold(
      body: BlocProvider(
        create: (context) => PostsCubit()..postsInfo(id),
        child: BlocBuilder<PostsCubit, PostsState>(
          builder: (context, state) {
            if (state is PostsInitial || state is PostsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PostsLoaded) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: MediaQuery.of(context).size.height * .4,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(username),
                      background: Hero(tag: "${id}", child: Image.asset(item)),
                    ),
                    backgroundColor: Colors.blueGrey,
                  ),
                  SliverFillRemaining(
                    child: Container(
                      color: Colors.blueGrey[800],
                      child: ListView.builder(
                          itemCount: state.postList.length,
                          itemBuilder: (context, index) => InkWell(
                                onTap: () async {
                                  showbottom(context,state.postList[index].id);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  padding: EdgeInsets.all(12),
                                  height: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(color: Colors.red)),
                                  child: ListTile(
                                    title: Text(
                                      state.postList[index].title,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    subtitle: Text(
                                      state.postList[index].body,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  )
                ],
              );
            } else if (state is PostsError) {
              return Center(
                child: Text("Error state !"),
              );
            } else {
              return Center(
                child: Text("Unknown State !"),
              );
            }
          },
        ),
      ),
    );
  }
}
