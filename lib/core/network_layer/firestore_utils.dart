import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/task_model.dart';

class FireStoreUtils {
  static CollectionReference<TaskModel> getCollection() {
    return FirebaseFirestore.instance
        .collection('TasksCollection')
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, options) =>
              TaskModel.fromFireStore(snapshot.data()!),
          toFirestore: (value, options) => value.toFireStore(),
        );
  }

  static Future<void> addDataToFireStore(TaskModel model) {
    var collectionRef = getCollection();
    DocumentReference<TaskModel> docRef = collectionRef.doc();
    model.id = docRef.id;
    return docRef.set(model);
  }

  static Future<void> deleteDataFromFireStore(TaskModel model) {
    var collectionRef = getCollection();
    return collectionRef.doc(model.id).delete();
  }

  static Future<List<TaskModel>> getDataFromFireStore() async {
    var snapshot = await getCollection().get();
    return snapshot.docs.map((element) => element.data()).toList();
  }

  static Stream<QuerySnapshot<TaskModel>> getRealTimeDataFromFireStore() {
    var snapshot = getCollection().snapshots();
    return snapshot;
  }

  static Future<void> isDone(TaskModel model) async {
    getCollection().doc(model.id).update({"isDone": !model.isDone});
  }

  static Future<void> updateTask(TaskModel model) async {
    getCollection().doc(model.id).update(model.toFireStore());
  }
}
