import 'dart:developer';
import 'package:cash_indo/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserDb {
  //
  static final dataBase = Supabase.instance.client.from('users');

  //Create a User Profile DB
  static Future createUserProfile(UserModel userModel) async {
    try {
      final response = await dataBase.insert(userModel.toMap());
      log('Success User: $response');
    } catch (e) {
      log('Error creating user profile: $e');
      rethrow;
    }
  }

// Get All Users
  static final stream = dataBase.stream(primaryKey: ['id']).map(
      (data) => data.map((user) => UserModel.fromMap(user)).toList());

//Get User Profile

  static Stream<UserModel?> getUserByEmail() {
    return dataBase
        .stream(primaryKey: ['id'])
        .eq('email', UserDb.supaEmail)
        .map(
          (data) {
            if (data.isNotEmpty) {
              return UserModel.fromMap(
                data.first,
              );
            }
            return null;
          },
        );
  }

// get Current User ID
  static String? getCurrentUserId() {
    final supabase = Supabase.instance.client;
    final session = supabase.auth.currentSession;
    final user = session!.user;
    return user.id;
  }

  static String supaUID = UserDb.getCurrentUserId() ?? '1';

// get Current User Email

  static String? getCurrentUserEmail() {
    final supabase = Supabase.instance.client;
    final session = supabase.auth.currentSession;
    final user = session!.user;
    return user.email!;
  }

  static String supaEmail = UserDb.getCurrentUserEmail() ?? '1';
}
