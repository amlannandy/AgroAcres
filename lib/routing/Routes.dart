import 'package:fluro/fluro.dart';

import './RouteHandler.dart';

class Routes {
  static const init = '/';
  static const home = '/home';
  static const login = '/login';
  static const setLanguage = '/set-language';
  static const weather = '/weather';
  static const myProducts = '/my-products/:userId';
  static const addProduct = '/add-product';
  static const editProduct = '/edit-product/:productId';

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
    router.define(
      weather,
      handler: weatherHandler,
      transitionType: TransitionType.native,
    );
    router.define(
      myProducts,
      handler: myProductsHandler,
      transitionType: TransitionType.native,
    );
    router.define(
      addProduct,
      handler: addProductHandler,
      transitionType: TransitionType.native,
    );
    router.define(
      editProduct,
      handler: editProductHandler,
      transitionType: TransitionType.native,
    );
  }
}
