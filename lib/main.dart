import 'package:flutter/material.dart';
import 'package:piscible_task/provider/image_picker_provider.dart';
import 'package:piscible_task/utils/permission_handler.dart';
import 'package:piscible_task/view/home_screen.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestPermissions();
  runApp(const MyApp());
}

Future<void> requestPermissions() async {
  await PermissionUtils.requestCameraPermission();
  await PermissionUtils.requestStoragePermission();
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImagePickerProvider(),
      child: MaterialApp(
        title: 'Image Upload App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueGrey,
            brightness: Brightness.light,
            primary: Colors.blueGrey.shade700,
            secondary: Colors.blueGrey.shade200,
            background: Colors.grey.shade50,
            surface: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.grey.shade50,
          cardTheme: CardTheme(
            color: Colors.white,
            elevation: 3,
            shadowColor: Colors.blueGrey.shade100,
          ),
          fontFamily: 'Roboto',
          appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.blueGrey.shade700,
            foregroundColor: Colors.white,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}