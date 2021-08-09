import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/InitScreen.dart';
import '../screens/HomeScreen.dart';
import '../screens/LoginScreen.dart';
import '../screens/WeatherScreen/WeatherScreen.dart';
import '../screens/ProductsScreen/AddProductScreen.dart';
import '../screens/ProductsScreen/MyProductsScreen.dart';
import '../screens/WeatherScreen/state/WeatherBloc.dart';
import '../screens/SettingsScreen/SetLanguageScreen.dart';
import '../screens/ProductsScreen/state/ProductsBloc.dart';

var initHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return InitScreen();
});

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginScreen();
});

var homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomeScreen();
});

var setLanguageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SetLanguageScreen();
});

var weatherHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return Provider<WeatherBloc>(
    create: (context) => WeatherBloc(),
    dispose: (context, bloc) => bloc.dispose(),
    child: WeatherScreen(),
  );
});

var myProductsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return Provider<ProductsBloc>(
      create: (context) => ProductsBloc(userId: params['userId'].first),
      dispose: (context, bloc) => bloc.dispose(),
      child: MyProductsScreen(),
    );
  },
);

var addProductHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return Provider<ProductsBloc>(
      create: (context) => ProductsBloc(fetchProducts: false),
      dispose: (context, bloc) => bloc.dispose(),
      child: AddProductScreen(),
    );
  },
);

var editProductHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return Provider<ProductsBloc>(
      create: (context) => ProductsBloc(fetchProducts: false),
      dispose: (context, bloc) => bloc.dispose(),
      child: AddProductScreen(
        productId: params['productId'].first,
        isEditing: true,
      ),
    );
  },
);
