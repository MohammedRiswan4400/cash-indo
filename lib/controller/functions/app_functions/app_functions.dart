import 'package:firebase_auth/firebase_auth.dart';

class AppFunctions {
  static String uid = FirebaseAuth.instance.currentUser!.uid;
}
