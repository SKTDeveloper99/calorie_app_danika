import "package:firebase_database/firebase_database.dart";
import "package:firebase_auth/firebase_auth.dart";

class Database {
  final ref = FirebaseDatabase.instance.ref();
  final user = FirebaseAuth.instance.currentUser;

  Future<void> writeData(String path, Map<String, dynamic> data) async {
    await ref.child("users/${user?.uid}/$path").set(data);
  }

  Future<void> updateData(String path, Map<String, dynamic> data) async {
    await ref.child("users/${user?.uid}/$path").update(data);
  }

  Future<void> updateWeightTarget(double weightTarget) async {
    await ref
        .child("users/${user?.uid}/account_info/weight_target")
        .set(weightTarget);
  }
}
