import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/provider/detail/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/home/list_restaurant_provider.dart';
import 'package:restaurant_app/provider/navbar/index_nav_bar.dart';
import 'package:restaurant_app/provider/search_restaurant/result_state.dart';
import 'package:restaurant_app/provider/search_restaurant/search_restaurant_provider.dart';
import 'package:restaurant_app/screen/detail/detail_page.dart';
import 'package:restaurant_app/screen/main/main_screen.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/theme/app_theme.dart';
import 'package:restaurant_app/theme/util.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => IndexNavBar(),
        ),
        Provider(
            create: (context) => ApiServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => ListRestaurantProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailRestaurantProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantSearchResultProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(create: (context) => ResultState())

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
      themeMode: ThemeMode.system,
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
