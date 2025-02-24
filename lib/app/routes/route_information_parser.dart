import 'package:flutter/material.dart';
import 'package:starter/data/model/page_configuration.dart';

class MyRouteInformationParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = routeInformation.uri;

    if (uri.pathSegments.isEmpty) {
      // without path parameter => "/"
      return PageConfiguration.home();
    } else if (uri.pathSegments.length == 1) {
      // path parameter => "/aaa"
      final first = uri.pathSegments[0].toLowerCase();
      if (first == 'home') {
        return PageConfiguration.home();
      } else if (first == 'login') {
        return PageConfiguration.login();
      } else if (first == 'register') {
        return PageConfiguration.register();
      } else if (first == 'create') {
        return PageConfiguration.createStory();
      } else if (first == 'splash') {
        return PageConfiguration.splash();
      } else {
        return PageConfiguration.unknown();
      }
    } else if (uri.pathSegments.length == 2) {
      // path parameter => "/aaa/bbb"
      final first = uri.pathSegments[0].toLowerCase();
      final second = uri.pathSegments[1].toLowerCase();
      if (first == 'story') {
        return PageConfiguration.detailStory(second);
      } else {
        return PageConfiguration.unknown();
      }
    } else {
      return PageConfiguration.unknown();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfiguration configuration) {
    if (configuration.isUnknownPage) {
      return RouteInformation(uri: Uri.parse('/unknown'));
    } else if (configuration.isSplashPage) {
      return RouteInformation(uri: Uri.parse('/splash'));
    } else if (configuration.isRegisterPage) {
      return RouteInformation(uri: Uri.parse('/register'));
    } else if (configuration.isLoginPage) {
      return RouteInformation(uri: Uri.parse('/login'));
    } else if (configuration.isHomePage) {
      return RouteInformation(uri: Uri.parse('/'));
    } else if (configuration.isCreatePage) {
      return RouteInformation(uri: Uri.parse('/create'));
    } else if (configuration.isDetailPage) {
      return RouteInformation(uri: Uri.parse('/story/${configuration.storyID}'));
    } else {
      return null;
    }
  }
}
