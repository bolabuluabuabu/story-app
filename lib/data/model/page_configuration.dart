class PageConfiguration {
  final bool unknown;
  final bool register;
  final bool? loggedIn;
  final String? storyID;
  final bool createStory;

  PageConfiguration.splash()
      : unknown = false,
        register = false,
        loggedIn = null,
        storyID = null,
        createStory = false;

  PageConfiguration.login()
      : unknown = false,
        register = false,
        loggedIn = false,
        storyID = null,
        createStory = false;

  PageConfiguration.register()
      : unknown = false,
        register = true,
        loggedIn = false,
        storyID = null,
        createStory = false;

  PageConfiguration.home()
      : unknown = false,
        register = false,
        loggedIn = true,
        storyID = null,
        createStory = false;

  PageConfiguration.createStory()
      : unknown = false,
        register = false,
        loggedIn = true,
        storyID = null,
        createStory = false;

  PageConfiguration.detailStory(String id)
      : unknown = false,
        register = false,
        loggedIn = true,
        storyID = id,
        createStory = false;

  PageConfiguration.unknown()
      : unknown = true,
        register = false,
        loggedIn = null,
        storyID = null,
        createStory = false;

  bool get isSplashPage => unknown == false && loggedIn == null;
  bool get isLoginPage => unknown == false && loggedIn == false;
  bool get isHomePage => unknown == false && loggedIn == true && storyID == null && createStory == false;
  bool get isDetailPage => unknown == false && loggedIn == true && storyID != null && createStory == false;
  bool get isCreatePage => unknown == false && loggedIn == true && storyID == null && createStory == true;
  bool get isRegisterPage => register == true;
  bool get isUnknownPage => unknown == true;
}
