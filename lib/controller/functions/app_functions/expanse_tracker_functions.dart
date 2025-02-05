import 'dart:developer';

import 'package:cash_indo/controller/functions/app_functions/app_functions.dart';
import 'package:cash_indo/model/income_model.dart';
import 'package:cash_indo/widget/helper/dialoge_helper_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExpanseTrackerFunctions {
  // static Future<void> updateIncomeCategory({
  //   required IncomeModel income,
  //   required String month,
  // }) async {
  //   final String uID = AppFunctions.uid;
  //   DocumentReference totalAmountRef = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uID)
  //       .collection('income_data')
  //       .doc(AppDateFormates.yearFormattedDate(income.createdAt));
  //   // .collection(income.category)
  //   // .doc('${income.category}_total');

  //   await totalAmountRef.set(
  //     {
  //       '${income.category}_total': FieldValue.increment(income.amount),
  //     },
  //     SetOptions(merge: true),
  //   );
  // }

  // static Future<void> updateIncomeMonthly({
  //   required IncomeModel income,
  //   required String month,
  // }) async {
  //   final String uID = AppFunctions.uid;

  //   DocumentReference totalAmountRef = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uID)
  //       .collection('income_data')
  //       .doc(AppDateFormates.yearFormattedDate(income.createdAt));

  //   await totalAmountRef.set(
  //     {
  //       '$month total': FieldValue.increment(income.amount),
  //     },
  //     SetOptions(merge: true),
  //   );
  // }

  // static Future<void> writeIncome({
  //   required IncomeModel income,
  //   required String month,
  // }) async {
  //   try {
  //     AppRoutes.popNow();
  //     final String uID = AppFunctions.uid;
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(uID)
  //         .collection('income_data')
  //         .doc(AppDateFormates.yearFormattedDate(income.createdAt))
  //         .collection(month)
  //         .doc(AppDateFormates.barFormattedDate(income.createdAt))
  //         .collection(income.category)
  //         .add({
  //       'amount': income.amount,
  //       'category': income.category,
  //       'comment': income.comment,
  //       'currency': income.currency,
  //       'createdAt': DateTime.now(),
  //     });
  //     updateIncomeCategory(income: income, month: month);
  //     updateIncomeMonthly(income: income, month: month);
  //     SnackBarHelper.snackBarSuccess(
  //       'Succesfull',
  //       'Income added succesfull',
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     DailogHelper.hideDailoge();
  //     SnackBarHelper.snackBarFaild(
  //       'Oops!',
  //       e.message,
  //     );
  //     log(e.message.toString());
  //   } catch (e) {
  //     log('Error: $e');
  //   }
  // }

  static Stream<List<Map<String, dynamic>>> getIncomeDataStream(String month) {
    final String uID = AppFunctions.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .collection('income_data')
        .snapshots()
        .asyncMap((yearSnapshot) async {
      List<Map<String, dynamic>> incomeData = [];

      if (yearSnapshot.docs.isEmpty) {
        debugPrint('No year documents found in income_data');
      }

      for (var yearDoc in yearSnapshot.docs) {
        debugPrint('Year Document: ${yearDoc.id}');

        var monthSnapshot = await yearDoc.reference.collection(month).get();

        if (monthSnapshot.docs.isEmpty) {
          debugPrint('No month documents found for month: $month');
        }

        for (var monthDoc in monthSnapshot.docs) {
          debugPrint('Month Document: ${monthDoc.id}');

          var dateSnapshot = await monthDoc.reference.collection('date').get();

          if (dateSnapshot.docs.isEmpty) {
            debugPrint('No date documents found for month: $month');
          }

          for (var dateDoc in dateSnapshot.docs) {
            debugPrint('Date Document: ${dateDoc.id}');

            var categorySnapshot =
                await dateDoc.reference.collection('category').get();

            if (categorySnapshot.docs.isEmpty) {
              debugPrint('No category documents found for date: ${dateDoc.id}');
            }

            for (var categoryDoc in categorySnapshot.docs) {
              debugPrint('Category Document: ${categoryDoc.id}');
              incomeData.add(categoryDoc.data());
            }
          }
        }
      }

      return incomeData;
    });
  }

  // static Stream<List<Map<String, dynamic>>> getIncomeDataStream(String month) {
  //   final String uID = AppFunctions.uid;
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uID)
  //       .collection('income_data')
  //       .snapshots()
  //       .asyncMap((yearSnapshot) async {
  //     List<Map<String, dynamic>> incomeData = [];

  //     for (var yearDoc in yearSnapshot.docs) {
  //       var monthSnapshot = await yearDoc.reference.collection(month).get();

  //       for (var monthDoc in monthSnapshot.docs) {
  //         var dateSnapshot = await monthDoc.reference.collection('date').get();

  //         for (var dateDoc in dateSnapshot.docs) {
  //           var categorySnapshot =
  //               await dateDoc.reference.collection('category').get();

  //           for (var categoryDoc in categorySnapshot.docs) {
  //             incomeData.add(categoryDoc.data() as Map<String, dynamic>);
  //           }
  //         }
  //       }
  //     }

  //     return incomeData;
  //   });
  // }

  static Stream<List<String>> streamDatesInMonth({
    required String year,
    required String month,
  }) {
    final String uID = AppFunctions.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .collection('income_data')
        .doc(year)
        .collection(month)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.id).toList();
    });
  }

  // static Stream<List<IncomeModel>> streamIncomeForCategory({
  //   required String year,
  //   required String month,
  //   required String date,
  //   required String category,
  // }) {
  //   final String uID = AppFunctions.uid;

  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uID)
  //       .collection('income_data')
  //       .doc(year)
  //       .collection(month)
  //       .doc(date)
  //       .collection(category) // Query for category inside date
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs
  //         .map((doc) => IncomeModel.fromMap(doc.data()))
  //         .toList();
  //   });
  // }
  static Stream<List<IncomeModel>> streamIncomeForCategory({
    required String year,
    required String month,
    required String date,
    required String category,
  }) {
    final String uID = AppFunctions.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .collection('income_data')
        .doc(year)
        .collection(month)
        .doc(date)
        .collection(category)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        log("Fetched ${snapshot.docs.length} income records for $category on $date");
        return snapshot.docs
            .map((doc) => IncomeModel.fromMap(doc.data()))
            .toList();
      } else {
        log("No income records found for $category on $date");
        return [];
      }
    });
  }

//   static Stream<List<IncomeModel>> streamIncomeForCategory({
//   required String year,
//   required String month,
//   required String date,
//   required String category,
// }) {
//   final String uID = AppFunctions.uid;

//   return FirebaseFirestore.instance
//       .collection('users')
//       .doc(uID)
//       .collection('income_data')
//       .doc(year)
//       .collection(month)
//       .doc(date)
//       .collection(category)
//       .snapshots()
//       .map((snapshot) {
//         if (snapshot.docs.isNotEmpty) {
//           log("Fetched ${snapshot.docs.length} income records for $category on $date");
//           return snapshot.docs.map((doc) => IncomeModel.fromMap(doc.data())).toList();
//         } else {
//           log("No income records found for $category on $date");
//           return [];
//         }
//       });
// }

  static Stream<List<String>> streamCategoriesForDate({
    required String year,
    required String month,
    required String date,
  }) {
    final String uID = AppFunctions.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .collection('income_data')
        .doc(year)
        .collection(month)
        .doc(date)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        List<String> categories =
            List<String>.from(snapshot.data()?['categories'] ?? []);
        log("Fetched Categories for $date: $categories");
        return categories;
      }
      log("No categories found for $date");
      return [];
    });
  }

  // static Stream<List<String>> streamCategoriesForDate({
  //   required String year,
  //   required String month,
  //   required String date,
  // }) {
  //   final String uID = AppFunctions.uid;

  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uID)
  //       .collection('income_data')
  //       .doc(year)
  //       .collection(month)
  //       .doc(date)
  //       .snapshots()
  //       .map((snapshot) {
  //     if (snapshot.exists && snapshot.data() != null) {
  //       return List<String>.from(snapshot.data()?['categories'] ?? []);
  //     }
  //     return [];
  //   });
  // }

  static Stream<List<IncomeModel>> readIncomeDataByDate() async* {
    final String uID = AppFunctions.uid;
    try {
      yield* FirebaseFirestore.instance
          .collection('users')
          .doc(uID)
          .collection('contacts')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => IncomeModel.fromMap(doc.data()))
              .toList());
    } on FirebaseAuthException catch (e) {
      DailogHelper.shoeErrorDailog(description: e.message);
      rethrow;
    } catch (e) {
      DailogHelper.shoeErrorDailog(
          description: "An unknown error occurred: $e");
      rethrow;
    }
  }
}
