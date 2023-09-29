import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/dataClass/dataClass.dart';

class FireBase {
  static CollectionReference<Tasks> getCollection() {
    return FirebaseFirestore.instance.collection('Tasks').withConverter<Tasks>(
          fromFirestore: (snapshot, options) =>
              Tasks.reciveFromFireBase(snapshot.data()!),
          toFirestore: (task, options) => task.sendToFireBase(),
        );
  }

  static Future<void> AddTodoTask(Tasks task) {
    var taskCollection = getCollection();
    var docRef = taskCollection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<void> EditTodoTask(Tasks task, Tasks task2) {
    var taskCollection = getCollection();
    var docRef = taskCollection.doc();
    task.id = docRef.id;
    return docRef.update({
      task.title!: task2.title,
      task.decription!: task2.decription,
      task.dateTime!: task2.dateTime,
    });
  }

  static Future<void> DeleteTask(Tasks task) {
    return getCollection().doc(task.id).delete();
  }
}
