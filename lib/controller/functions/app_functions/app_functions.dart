import 'package:cash_indo/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppFunctions {
  static String uid = FirebaseAuth.instance.currentUser!.uid;
}
