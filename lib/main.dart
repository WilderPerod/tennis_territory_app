import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tennis_territory_app/config/routes.dart';
import 'package:tennis_territory_app/config/theme.dart';
import 'package:tennis_territory_app/data/repositories/reserve_repository_impl.dart';
import 'package:tennis_territory_app/data/repositories/weather_repository_impl.dart';
import 'package:tennis_territory_app/ui/bloc/reserve_bloc.dart';

void main() async {
  await Jiffy.setLocale('es');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReserveBloc(
          reserveRepositoryImpl: ReserveRepositoryImpl(database: 'database.db'),
          weatherRepositoryImpl: WeatherRepositoryImpl()),
      child: MaterialApp(
        title: 'TennisTerritory',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es'),
        ],
        initialRoute: AppRoutes.home,
        routes: AppRoutes.getAppRoutes(),
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
