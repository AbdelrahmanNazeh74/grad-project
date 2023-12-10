import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project/model/my_user.dart';

class DatabaseUtils{
  static CollectionReference<MyUser> getUsersCollection(){
    return  FirebaseFirestore.instance
        .collection(MyUser.collectionName)
    .withConverter(fromFirestore: (snapshot,_)=>MyUser.fromJson(snapshot.data()!), toFirestore: (user,_)=> user.toJson());
  }
    static Future<void> createDBUser(MyUser user)async{

   return getUsersCollection()
        .doc(user.id)
        .set(user);
  }
  static Future<MyUser?> readUser(String userId)async{
    var userDocSnapshot=await getUsersCollection().doc(userId).get();
    return userDocSnapshot.data();
  }
}