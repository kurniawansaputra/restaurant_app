import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/static/navigation_route.dart';
import 'core/themes/theme.dart';
import 'core/themes/util.dart';
import 'data/api/api_service.dart';
import 'data/local/local_database_service.dart';
import 'providers/detail/favorite_list_provider.dart';
import 'providers/detail/restaurant_detail_provider.dart';
import 'providers/favorite/local_database_provider.dart';
import 'providers/home/restaurant_list_provider.dart';
import 'providers/main/index_nav_provider.dart';
import 'providers/search/restaurant_search_provider.dart';
import 'ui/detail/pages/detail_page.dart';
import 'ui/main/pages/main_pages.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => IndexNavProvider(),
        ),
        Provider(
          create: (context) => ApiService(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            context.read<ApiService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            context.read<ApiService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantSearchProvider(
            context.read<ApiService>(),
          ),
        ),
        Provider(
          create: (context) => LocalDatabaseService(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalDatabaseProvider(
            context.read<LocalDatabaseService>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainPage(),
        NavigationRoute.detailRoute.name: (context) => DetailPage(
              restaurantId:
                  ModalRoute.of(context)?.settings.arguments as String,
            ),
      },
    );
  }
}