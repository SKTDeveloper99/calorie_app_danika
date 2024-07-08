import "package:firebase_database/firebase_database.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:calorie_app_danika/services/singleton.dart';

class Database {
  final ref = FirebaseDatabase.instance.ref();
  final user = FirebaseAuth.instance.currentUser;
  final Singleton _singleton = Singleton();

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

  Future<void> createNewDayLog(String timestamp) async {
    int caloriesBudget = 2000;
    if (_singleton.userdata?["account_info"]?["calorie_budget"] != null) {
      caloriesBudget = _singleton.userdata?["account_info"]?["calorie_budget"];
    }
    await ref.child("users/${user?.uid}/daily_log/$timestamp").set({
      "burned_calories": 0,
      "calorie_budget": (caloriesBudget == 2000) ? 2000 : caloriesBudget
    });
  }
}
