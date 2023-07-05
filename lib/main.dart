import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:pixels/providers/auth_provider.dart';
import 'package:pixels/shared/routes.dart';
import 'package:pixels/shared/style/colors.dart';
import 'package:provider/provider.dart';

import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  CacheHelper.init();
  DioHelper.init();

  runApp(OneNotification(
      builder: (_,__) {
        return MyApp(
          appRouter: AppRouter(),
        );
      }
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Pixels Gallery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: defaultColor,
          textTheme: const TextTheme(
            titleLarge: TextStyle(
                color: Colors.black, fontFamily: 'PoppinsMedium'),
            labelSmall: TextStyle(
                color: Colors.grey,
                fontFamily: 'PoppinsMedium',
                fontSize: 12.0),
            labelLarge: TextStyle(
                color: Colors.black, fontFamily: 'PoppinsMedium'),
          ),
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
