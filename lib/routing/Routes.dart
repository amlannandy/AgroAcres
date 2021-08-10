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
  static const settings = '/settings/:language';
  static const chatbot = '/chatbot/:language';
  static const myFields = '/my-fields';
  static const addCropField = '/add-crop-field';
  static const myCropField = '/my-fields/:id';

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
    router.define(
      settings,
      handler: settingsHandler,
      transitionType: TransitionType.native,
    );
    router.define(
      chatbot,
      handler: chatbotHandler,
      transitionType: TransitionType.native,
    );
    router.define(
      myFields,
      handler: myFieldsHandler,
      transitionType: TransitionType.native,
    );
    router.define(
      addCropField,
      handler: addCropFieldsHandler,
      transitionType: TransitionType.native,
    );
    router.define(
      myCropField,
      handler: myCropFieldHandler,
      transitionType: TransitionType.native,
    );
  }
}
