import 'package:fluro/fluro.dart';

import './RouteHandler.dart';

class Routes {
  static const init = '/';
  static const home = '/home';
  static const login = '/login';
  static const setLanguage = '/set-language';

  static void configureRouter(FluroRouter router) {
    router.define(
      init,
      handler: initHandler,
      transitionType: TransitionType.native,
    );
    router.define(
      home,
      handler: homeHandler,
      transitionType: TransitionType.native,
    );
    router.define(
      login,
      handler: loginHandler,
      transitionType: TransitionType.native,
    );
    router.define(
      setLanguage,
      handler: setLanguageHandler,
      transitionType: TransitionType.native,
    );
  }
}
