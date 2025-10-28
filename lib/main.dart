import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/provider/detail/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/home/list_restaurant_provider.dart';
import 'package:restaurant_app/provider/navbar/index_nav_bar.dart';
import 'package:restaurant_app/provider/notification/daily_notification_provider.dart';
import 'package:restaurant_app/provider/search_restaurant/result_state.dart';
import 'package:restaurant_app/provider/search_restaurant/search_restaurant_provider.dart';
import 'package:restaurant_app/provider/shared_preferences/shared_preferences_provider.dart';
import 'package:restaurant_app/screen/detail/detail_page.dart';
import 'package:restaurant_app/screen/main/main_screen.dart';
import 'package:restaurant_app/service/local_notification_service.dart';
import 'package:restaurant_app/service/shared_preferences_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/theme/app_theme.dart';
import 'package:restaurant_app/theme/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  final prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IndexNavBar()),
        Provider(create: (context) => ApiServices()),
        Provider(create: (context) => SharedPreferencesService(prefs)),
        Provider(
          create: (context) => LocalNotificationService()
            ..init()
            ..configureLocalTimeZone(),

        ),
        ChangeNotifierProvider(create: (context) =>  DailyNotificationProvider(
          context.read<LocalNotificationService>()
              ..requestPermissions()
        ),),
        ChangeNotifierProvider(
          create: (context) => SharedPreferencesProvider(
            context.read<SharedPreferencesService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              ListRestaurantProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              DetailRestaurantProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantSearchResultProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(create: (context) => ResultState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Inter", "Inter");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: context.watch<SharedPreferencesProvider>().isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      initialRoute: NavigationRoute.mainRoute.name,
      debugShowCheckedModeBanner: false,
      routes: {
        NavigationRoute.mainRoute.name: (context) => MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailPage(
          id: ModalRoute.of(context)?.settings.arguments as String,
        ),
      },
    );
  }
}
