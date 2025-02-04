import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AppConst {
  static const appScreenHorizontalPadding =
      EdgeInsets.symmetric(horizontal: 20);
  // ignore: constant_identifier_names
  static const DashboardScreensHorizontalPadding =
      EdgeInsets.symmetric(horizontal: 10);

  static var storage = GetStorage();
  static var isLogged = 'isLogged';
  static String supaURL = 'https://vmehcxqtwrajjtccjtro.supabase.co';
  static String supaKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZtZWhjeHF0d3Jhamp0Y2NqdHJvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg2MDc2NTEsImV4cCI6MjA1NDE4MzY1MX0.TTpWnE2wV8i1vMjpfBHnEEBbfSpUn6DY7ju1pZ7MIJE';
}
