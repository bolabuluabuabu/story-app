import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:starter/app/screens/screens.dart';
import 'package:starter/app/screens/story/select_location_screen.dart';
import 'package:starter/data/model/page_configuration.dart';

class MyRouterDelegate extends RouterDelegate<PageConfiguration> with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  MyRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  String? selectedStory;
  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isRegister = false;
  bool? isUnknown;
  BuildContext? allStoriesContext;
  BuildContext? createStoryContext;
  bool isCreateStory = false;
  bool isSelectLocation = false;

  @override
  Widget build(BuildContext context) {
    if (isUnknown == true) {
      historyStack = _unknownStack;
    } else if (isLoggedIn == null) {
      historyStack = _splashStack;
    } else if (isLoggedIn == true) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }
    return Navigator(
      key: navigatorKey,
      pages: historyStack,
      // ignore: deprecated_member_use
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }

        isRegister = false;
        selectedStory = null;
        if (!isSelectLocation) {
          isCreateStory = false;
        }
        isSelectLocation = false;

        notifyListeners();

        return true;
      },
    );
  }

  @override
  PageConfiguration? get currentConfiguration {
    if (isLoggedIn == null) {
      return PageConfiguration.splash();
    } else if (isRegister == true) {
      return PageConfiguration.register();
    } else if (isLoggedIn == false) {
      return PageConfiguration.login();
    } else if (isUnknown == true) {
      return PageConfiguration.unknown();
    } else if (selectedStory == null) {
      return PageConfiguration.home();
    } else if (selectedStory != null) {
      return PageConfiguration.detailStory(selectedStory!);
    } else {
      return null;
    }
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) async {
    if (configuration.isUnknownPage) {
      isUnknown = true;
      isRegister = false;
    } else if (configuration.isRegisterPage) {
      isRegister = true;
    } else if (configuration.isHomePage || configuration.isLoginPage || configuration.isSplashPage) {
      isUnknown = false;
      selectedStory = null;
      isRegister = false;
    } else if (configuration.isDetailPage) {
      isUnknown = false;
      isRegister = false;
      selectedStory = configuration.storyID.toString();
    } else {
      if (kDebugMode) {
        print(' Could not set new route');
      }
    }

    notifyListeners();
  }

  List<Page> get _unknownStack => const [
        MaterialPage(
          key: ValueKey("UnknownPage"),
          child: UnknownScreen(),
        ),
      ];

  List<Page> get _splashStack => [
        MaterialPage(
          key: ValueKey("AuthenticationPage"),
          child: AuthenticationScreen(
            isAuthenticated: (val) {
              isLoggedIn = val;
              notifyListeners();
            },
          ),
        ),
      ];

  List<Page> get _loggedOutStack => [
        MaterialPage(
          key: const ValueKey("LoginPage"),
          child: LoginScreen(
            onLoggedIn: () {
              isLoggedIn = true;
              notifyListeners();
            },
            onRegister: () {
              isRegister = true;
              notifyListeners();
            },
          ),
        ),
        if (isRegister == true)
          MaterialPage(
            key: const ValueKey("RegisterPage"),
            child: RegisterScreen(
              onRegistered: () {
                isRegister = false;
                notifyListeners();
              },
            ),
          ),
      ];

  List<Page> get _loggedInStack => [
        MaterialPage(
          key: const ValueKey("AllStoriesPage"),
          child: AllStoriesScreen(
            onTapStory: (story) {
              selectedStory = story;
              isCreateStory = false;

              notifyListeners();
            },
            onCreateStory: () {
              isCreateStory = true;
              selectedStory = null;

              notifyListeners();
            },
            onLoggedOut: () {
              isLoggedIn = false;
              notifyListeners();
            },
            passContext: (context) {
              allStoriesContext = context;
            },
          ),
        ),
        if (selectedStory != null && !isCreateStory && allStoriesContext != null && !isSelectLocation)
          MaterialPage(
            key: ValueKey(selectedStory),
            child: DetailsStoryScreen(
              prevContext: allStoriesContext!,
              storyID: selectedStory!,
            ),
          ),
        if (selectedStory == null && isCreateStory && allStoriesContext != null)
          MaterialPage(
            key: const ValueKey("CreateStoryPage"),
            child: CreateStoryScreen(
              passContext: (context) {
                createStoryContext = context;
              },
              prevContext: allStoriesContext!,
              onAddLocation: () {
                isSelectLocation = true;
                notifyListeners();
              },
              onCreatedStroy: () async {
                isCreateStory = false;
                selectedStory = null;
                notifyListeners();
              },
            ),
          ),
        if (selectedStory == null && isCreateStory && allStoriesContext != null && isSelectLocation && createStoryContext != null)
          MaterialPage(
            key: const ValueKey("SelecLocationPage"),
            child: SelectLocationScreen(
              createStoryContext: createStoryContext!,
              onUpdatedLocation: () {
                isSelectLocation = false;
                notifyListeners();
              },
              // prevContext: allStoriesContext!,
              // onCreatedStroy: () async {
              //   isCreateStory = false;
              //   selectedStory = null;
              //   notifyListeners();
              // },
            ),
          ),
      ];
}
