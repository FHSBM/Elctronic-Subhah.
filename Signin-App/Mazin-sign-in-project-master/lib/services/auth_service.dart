import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<File> _getSignFile() async {
  final dir = await getApplicationSupportDirectory();
  final file = File('${dir.path}/sign_file.txt');
  if (!await file.exists()) {
    await file.create(recursive: true);
  }
  return file;
}

/// الدالة save
/// تحفظ بيانات المستخدم في الملف بالشكل:
/// username_الاسم, password_الكلمة, department_التخصص
Future<void> save(String username, String password, String department) async {
  final file = await _getSignFile();
  final content =
      'username_$username, password_$password, department_$department';
  await file.writeAsString(content, flush: true);
}

/// قراءة بيانات المستخدم الحالية من الملف (إن وجدت)
Future<Map<String, String>?> readUser() async {
  final file = await _getSignFile();
  final content = await file.readAsString();
  if (content.trim().isEmpty) return null;

  final parts = content.split(',');
  if (parts.length < 3) return null;

  String? username;
  String? password;
  String? department;

  for (var part in parts) {
    final p = part.trim();
    if (p.startsWith('username_')) {
      username = p.replaceFirst('username_', '').trim();
    } else if (p.startsWith('password_')) {
      password = p.replaceFirst('password_', '').trim();
    } else if (p.startsWith('department_')) {
      department = p.replaceFirst('department_', '').trim();
    }
  }

  if (username == null || password == null || department == null) {
    return null;
  }

  return {
    'username': username,
    'password': password,
    'department': department,
  };
}

/// الدالة checkValue
/// تفحص هل الاسم وكلمة السر متطابقين مع الموجود في الملف أم لا
Future<bool> checkValue(String username, String password) async {
  final user = await readUser();
  if (user == null) return false;
  return user['username'] == username && user['password'] == password;
}
