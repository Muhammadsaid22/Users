import 'package:users/models/comments_modul.dart';
import 'package:users/models/posts_model.dart';
import 'package:users/models/users_models.dart';
import 'package:users/services/http_service.dart';

class UserRepository{
  Future<List<User>?> getUser() async {
    final result = await ApiRequests().get(
        slug: "users");
    if (result.isSuccess) {
      try {
        return  userFromJson(result.body);
      }
      catch (error) {
        print("user error: $error");
        return null;
      }
    }
    else {
      print("user unsucces error: ${result.status}");
      return null;
    }
  }

  Future<List<Posts>?> getPosts(int id ) async {
    final result = await ApiRequests().get(
        slug: "posts?userId=$id");
    if(result.isSuccess) {
      try {
        return postsFromJson(result.body);
      }
      catch (error) {
        print("posts error : $error");
        return null;
      }
    }
      else{
      print("user unsucces error: ${result.status}");
      return null;
    }
  }

  Future<List<Comments>?> getComments(int id ) async {
    final result = await ApiRequests().get(
     slug: "comments?postId=$id");
    if(result.isSuccess){
      try{
        return commentsFromJson(result.body);
  }
  catch(error){
        print("comments $error");
        return null;
  }
  }
    else{
      print("Commennts unsecces error: ${result.status}");
      return null;
  }
}
}