import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/app/bloc/auth/authentication_bloc.dart';
import 'package:starter/data/api_service/auth_service.dart';
import 'package:starter/data/preferences/preferences_helper.dart';
import 'package:starter/app/routes/router_delegate.dart';
import 'package:starter/design/bloc/button/design_bloc.dart';

import 'common/url_strategy.dart';
import 'app/routes/route_information_parser.dart';

void main() {
  usePathUrlStrategy();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late MyRouterDelegate myRouterDelegate;
  late MyRouteInformationParser myRouteInformationParser;

  @override
  void initState() {
    super.initState();

    myRouterDelegate = MyRouterDelegate();

    myRouteInformationParser = MyRouteInformationParser();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(
            PreferencesHelper(SharedPreferences.getInstance()),
            AuthService(),
          )..add(CheckEvent()),
        ),
        BlocProvider(create: (context) => ButtonBloc()),
        BlocProvider(create: (context) => SnackbarBloc()),
      ],
      child: MaterialApp.router(
        title: 'Story App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          useMaterial3: true,
        ),
        routerDelegate: myRouterDelegate,
        routeInformationParser: myRouteInformationParser,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
