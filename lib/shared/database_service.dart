import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/model/skill_model.dart';

class DatabaseService {
  DatabaseService({this.user});
  final User? user;

  final CollectionReference skillsCollection =
      FirebaseFirestore.instance.collection('Skills');

  Future updateUserData(bool anonStatus, String name, List skills) async {
    return await skillsCollection.doc(user!.uid).set({
      'isAnon': anonStatus,
      'name': name,
      'skills': skills,
    }).onError((error, stackTrace) =>
        print('In Update user Data: ${error.toString()}'));
  }

  Future<Skill?> specificData(String uid) async {
    DocumentSnapshot documentSnapshot = await skillsCollection.doc(uid).get();
    if (documentSnapshot.exists) {
      Map _doc = documentSnapshot.data() as Map;
      // print(_doc);
      return Skill(_doc['isAnon'], _doc['name'], _doc['skills'], uid);
    }
    return null;
  }

  List<Skill> _skillListOfSnapshots(QuerySnapshot<Object?> snapshot) {
    return snapshot.docs.map((e) {
      Map _doc = e.data() as Map;
      return Skill(_doc['isAnon'] ?? true, _doc['name'] ?? '',
          _doc['skills'] ?? {}, e.id);
    }).toList();
  }

  Skill _skillDataFromSnapshot(DocumentSnapshot snapshot) {
    Map _doc = snapshot.data() as Map;
    return Skill(_doc['isAnon'] ?? true, _doc['name'] ?? '',
        _doc['skills'] ?? {}, snapshot.id);
  }

  Stream<List<Skill>> get skills =>
      skillsCollection.snapshots().map(_skillListOfSnapshots);

  Stream<Skill> get skillData =>
      skillsCollection.doc(user!.uid).snapshots().map(_skillDataFromSnapshot);
}
