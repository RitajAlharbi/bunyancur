import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

class AppPreferences {
  static final AppPreferences _instance = AppPreferences._internal();
  SharedPreferences? _prefs;
  Completer<void>? _initCompleter;

  factory AppPreferences() {
    return _instance;
  }

  AppPreferences._internal();

  /// ✅ **تهيئة SharedPreferences**
  Future<void> init() async {
    if (_prefs != null) {
      return;
    }
    if (_initCompleter != null) {
      return _initCompleter!.future;
    }
    _initCompleter = Completer<void>();
    try {
      // Ensure platform is ready before getting SharedPreferences
      _prefs = await SharedPreferences.getInstance();
      _initCompleter!.complete();
    } catch (e) {
      _initCompleter!.completeError(e);
      _initCompleter = null;
      rethrow;
    }
  }

  /// ✅ **حفظ البيانات بأي نوع (`String, int, double, bool, List<String>`)**
  Future<void> setData(String key, dynamic value) async {
    if (_prefs == null) {
      await init();
    }
    if (_prefs == null) {
      throw Exception("Failed to initialize SharedPreferences");
    }
    if (value is String) {
      await _prefs!.setString(key, value);
    } else if (value is int) {
      await _prefs!.setInt(key, value);
    } else if (value is double) {
      await _prefs!.setDouble(key, value);
    } else if (value is bool) {
      await _prefs!.setBool(key, value);
    } else if (value is List<String>) {
      await _prefs!.setStringList(key, value);
    } else {
      throw Exception("Unsupported data type");
    }
  }

  /// ✅ **استرجاع البيانات (`String, int, double, bool, List<String>`)**
  dynamic getData(String key) {
    if (_prefs == null) {
      return null;
    }
    try {
      return _prefs!.get(key);
    } catch (e) {
      // If SharedPreferences is not ready, return null
      return null;
    }
  }

  /// ✅ **حذف بيانات مفتاح معين**
  Future<void> removeData(String key) async {
    if (_prefs == null) {
      await init();
    }
    if (_prefs == null) {
      throw Exception("Failed to initialize SharedPreferences");
    }
    await _prefs!.remove(key);
  }

  /// ✅ **حفظ كائن Model (`T`)**
  Future<void> saveModel<T>(
      String key, T model, Map<String, dynamic> Function(T) toJson) async {
    if (_prefs == null) {
      await init();
    }
    if (_prefs == null) {
      throw Exception("Failed to initialize SharedPreferences");
    }
    final String jsonString = jsonEncode(toJson(model));
    await _prefs!.setString(key, jsonString);
  }

  /// ✅ **استرجاع كائن Model (`T`)**
  T? getModel<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    if (_prefs == null) {
      return null;
    }
    try {
      final String? jsonString = _prefs!.getString(key);
      if (jsonString != null) {
        final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        return fromJson(jsonMap);
      }
    } catch (e) {
      // If SharedPreferences is not ready, return null
    }
    return null;
  }

  /// ✅ **حفظ قائمة من النماذج (`List<T>`)**
  Future<void> saveModels<T>(String key, List<T> models,
      Map<String, dynamic> Function(T) toJson) async {
    if (_prefs == null) {
      await init();
    }
    if (_prefs == null) {
      throw Exception("Failed to initialize SharedPreferences");
    }
    final List<String> jsonList =
        models.map((model) => jsonEncode(toJson(model))).toList();
    await _prefs!.setStringList(key, jsonList);
  }

  /// ✅ **استرجاع قائمة من النماذج (`List<T>`)**
  List<T> getModels<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    if (_prefs == null) {
      return [];
    }
    try {
      final List<String>? jsonList = _prefs!.getStringList(key);
      if (jsonList != null) {
        return jsonList.map((json) => fromJson(jsonDecode(json))).toList();
      }
    } catch (e) {
      // If SharedPreferences is not ready, return empty list
    }
    return [];
  }

  Future<void> clearExceptCredentials() async {
    if (_prefs == null) {
      await init();
    }
    if (_prefs == null) {
      throw Exception("Failed to initialize SharedPreferences");
    }
    // حفظ بيانات تسجيل الدخول قبل الحذف
    String? savedEmail = _prefs!.getString('saved_email');
    String? savedPassword = _prefs!.getString('saved_password');
    bool? rememberMe = _prefs!.getBool('remember_me');

    // مسح كل البيانات
    await _prefs!.clear();

    // استرجاع بيانات تسجيل الدخول
    if (savedEmail != null) await _prefs!.setString('saved_email', savedEmail);
    if (savedPassword != null) {
      await _prefs!.setString('saved_password', savedPassword);
    }
    if (rememberMe != null) await _prefs!.setBool('remember_me', rememberMe);
  }

  bool isLoggedInUser() {
    if (_prefs == null) {
      return false;
    }
    try {
      return _prefs!.containsKey("userModel");
    } catch (e) {
      // If SharedPreferences is not ready, return false
      return false;
    }
  }
}
