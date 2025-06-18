import 'dart:async';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_customer_app/Models/notification_model.dart';
import 'package:water_customer_app/screens/dashboard/bottom_navigaton/bottom_navigation_bar_screen.dart';
import 'package:water_customer_app/utils/Common.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/globals.dart' as globals;
import 'package:water_customer_app/utils/notifi_service.dart';
import 'screens/dashboard/settings/settings_controller.dart';
import 'screens/signIn/start_screen/start_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';

void handleMessage(RemoteMessage? message) async {
  if (message == null) return;
  await NotificationService().showNotification(
      title: message.notification?.title ?? 'No Title',
      body: message.notification?.body ?? 'No Body');
}

void handleMessageForeground(RemoteMessage? message) async {
  print("message  $message");
  if (message == null) return;
  Fluttertoast.showToast(
    msg: message.notification?.title ?? 'No Title',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
  );
  await NotificationService().showNotification(
      title: message.notification?.title ?? 'No Title',
      body: message.notification?.body ?? 'No Body');
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
 // created by abhijith
  //await Firebase.initializeApp(); // Ensure Firebase is initialized
  print("Handling a background message: ${message.messageId}");
  await NotificationService().showNotification(
      title: message.notification!.title.toString(),
      body: message.notification!.body.toString());
}

Future<void> initPushNotification() async {
  FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  FirebaseMessaging.onMessage.listen(handleMessageForeground);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    //enable the options in sana
    // options: FirebaseOptions(
    //   apiKey: "AIzaSyDvjBmq0c35tMrhWO2kMTVq2rJQiwP_-ZM",
    //   appId: "1:512124116403:android:d92d193a4343e4ed717fc6",
    //   messagingSenderId: "512124116403",
    //   projectId: "sanawater-ff102",
    // ),
  );
 await loadUserData();
  NotificationService().initNotification();

  // Initialize package information
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  globals.appName = packageInfo.appName;
  globals.packageName = packageInfo.packageName;
  globals.version = packageInfo.version;
  globals.buildNumber = packageInfo.buildNumber;

  // Initialize Firebase messaging
  final messaging = FirebaseMessaging.instance;
  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (kDebugMode) {
    print('Permission granted: ${settings.authorizationStatus}');
  }

  // Get and print device token
  String? token = await messaging.getToken();
  globals.deviceId = token ?? "";
  if (kDebugMode) {
    print('Registration Token=$token');
  }

  initPushNotification();

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(NotificationModelAdapter().typeId)) {
    Hive.registerAdapter(NotificationModelAdapter());
    Hive.registerAdapter(DataAdapter());
  }

  await GetStorage.init();
  Get.put(SettingsController());



   bool hasToken = await _getUserToken();
  runApp(MyApp(hasToken: hasToken));
}

Future<bool> _getUserToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userToken = prefs.getString('userToken');
  return userToken != null;
}

class MyApp extends StatelessWidget {
  final bool hasToken;

  MyApp({super.key, required this.hasToken});

  final SettingsController settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Customer App',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: CustomColors.white,
        ),
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: CustomColors.white,
        ),
        themeMode: settingsController.isDarkModeEnabled.value
            ? ThemeMode.dark
            : ThemeMode.light,
        home: hasToken ? BottomNavigationBarScreen() : const StartScreen(),
      ),
    );
  }
}
final authData = AuthData();

Future<void> loadUserData() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('userToken');
    String? userType = prefs.getString('userType');
    int? id = int.tryParse(prefs.getString('userId') ?? '') ?? 0;
    String? username = prefs.getString('userName');
    String? salesType = prefs.getString('salesType');
    String? userPk = prefs.getString('userPk');
    String? password = prefs.getString('passWord');
    globals.waterId= prefs.getString('waterId')??'';
    globals.waterRate  = prefs.getDouble('waterRate')??0;

    if (token != null && username != null && password != null) {
      authData.setData(token, userType ?? '',salesType ??'', id, username, password,userPk);
    }
  } catch (e) {
    log('Error loading user data: $e');
  }
}
