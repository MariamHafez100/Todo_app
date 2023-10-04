import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/dataClass/dataClass.dart';
import 'package:todo/dataClass/my_user.dart';

class FireBase {
  static CollectionReference<Tasks> getCollection(String uId) {
    return getUserscollection()
        .doc(uId)
        .collection('Tasks')
        .withConverter<Tasks>(
          fromFirestore: (snapshot, options) =>
              Tasks.reciveFromFireBase(snapshot.data()!),
          toFirestore: (task, options) => task.sendToFireBase(),
        );
  }

  static Future<void> AddTodoTask(Tasks task, String uId) {
    var taskCollection = getCollection(uId);
    var docRef = taskCollection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<void> EditTodoTask(Tasks task, Tasks task2, String uId) {
    var taskCollection = getCollection(uId);
    var docRef = taskCollection.doc();
    task.id = docRef.id;
    return docRef.update({
      task.title!: task2.title,
      task.decription!: task2.decription,
      task.dateTime!: task2.dateTime,
    });
  }

  static Future<void> DeleteTask(Tasks task, String uId) {
    return getCollection(uId).doc(task.id).delete();
  }

  static CollectionReference<MyUser> getUserscollection() {
    return FirebaseFirestore.instance.collection('users').withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()!),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUserscollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String UId) async {
    var quierySnapshot = await getUserscollection().doc(UId).get();
    return quierySnapshot.data();
  }
}
