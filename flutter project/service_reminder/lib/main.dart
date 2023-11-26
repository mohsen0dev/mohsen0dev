import 'package:device_preview/device_preview.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:service_reminder/0-models/save_data_model.dart';
import 'package:service_reminder/gen/fonts.gen.dart';
import 'package:service_reminder/0-models/firest.dart';
import 'package:service_reminder/0-models/kilometr_model.dart';
import 'package:service_reminder/0-models/set_data_model.dart';
import 'package:service_reminder/0-models/user_models.dart';
import 'package:service_reminder/screen/intro/intro_screen.dart';
import 'package:service_reminder/screen/02-login/login_screen.dart';
import 'package:service_reminder/services/app_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SetDataModelAdapter());
  Hive.registerAdapter(KilometrModelAdapter());
  Hive.registerAdapter(UserModelsAdapter());
  Hive.registerAdapter(FirestModelAdapter());
  Hive.registerAdapter(AddDataModelAdapter());
  await Hive.openBox<SetDataModel>('SetData');
  await Hive.openBox<KilometrModel>('kilometr');
  await Hive.openBox<FirestModel>('firest');
  await Hive.openBox<AddDataModel>('addData');
  await Hive.openBox<UserModels>(UserDb.boxNameUser);
  runApp(const MyApp());
}

void saveToHive(bool value) async {
  var box = await Hive.openBox('myBox');
  await box.put('myKey', value);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? myValue = false; // مقدار پیش‌فرض
  @override
  void initState() {
    super.initState();

    _loadHiveData();
  }

  Future<void> _loadHiveData() async {
    var box = await Hive.openBox('myBox');
    bool value = await box.get('myKey', defaultValue: false) ?? false;
    saveToHive(value);

    // setState(() {

    myValue = value;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 103, 58, 183)),
            useMaterial3: true,
            textTheme: const TextTheme(
              displayLarge: TextStyle(fontFamily: FontFamily.digital2),
              titleMedium: TextStyle(fontFamily: FontFamily.sans, fontSize: 16),
              titleSmall: TextStyle(
                  fontFamily: FontFamily.sans,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            fontFamily: 'sans'),
        // home: IntroScreen(),
        home: Scaffold(
            body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Row(
              textDirection: TextDirection.rtl,
              children: [
                Text('برای خروج دوباره کلید برگشت را فشار دهید'),
                Spacer(),
                Icon(
                  Icons.undo,
                  color: Colors.white,
                )
              ],
            ),
          ),
          // child: OnBoardingPage(),
          // child: HomeScreen(),
          child: FutureBuilder(
              // استفاده از FutureBuilder برای نمایش صفحه مناسب به محض بارگیری اطلاعات از Hive
              future: _loadHiveData(), // اجرای تابع بارگیری اطلاعات
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // اگر بارگیری انجام شده است، صفحه مناسب را نمایش دهید
                  return MyWidget(myValue: myValue!);
                } else {
                  // اگر بارگیری هنوز انجام نشده است، می‌توانید یک ویجت پیش‌فرض نمایش دهید
                  return Scaffold(
                      backgroundColor: Theme.of(context).primaryColor,
                      body: const Center(child: CircularProgressIndicator()));
                }
              }),
        )));
  }
}

class MyWidget extends StatelessWidget {
  final bool myValue;
  const MyWidget({super.key, required this.myValue});

  @override
  Widget build(BuildContext context) {
    // Hive.box<AddDataModel>(AddCRUDdb.boxAddName).clear();
    // Hive.box<UserModels>(UserDb.boxNameUser).clear();
    // Hive.box<SetDataModel>(AppDatabase.boxNameData).clear();
    // Hive.box<KilometrModel>('kilometr').clear();

    return Scaffold(
      body: myValue == true ? const LoginScreen() : const OnBoardingPage(),
      // body: DelayedText(delay: Duration(microseconds: 500), text: 'text'),
    );
  }
}
