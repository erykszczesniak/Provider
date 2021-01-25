import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/models/CartModel.dart';
import 'package:untitled2/models/CatalogModel.dart';
import 'package:untitled2/screens/cart.dart';
import 'package:untitled2/screens/catalog.dart';
import 'package:untitled2/screens/login.dart';
import 'package:untitled2/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => CatalogModel()),
    // CartModel is implemented as a ChangeNotifier, which calls for the use
    // of ChangeNotifierProvider. Moreover, CartModel depends
    // on CatalogModel, so a ProxyProvider is needed.
    ChangeNotifierProxyProvider<CatalogModel, CartModel>(
    create: (context) => CartModel(),
    update: (context, catalog, cart) {
      cart.catalog = catalog;
      return cart;
    },
    ),
    ],
      child: MaterialApp(
        title: 'Provider Demo',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => MyLogin(),
          '/catalog': (context) => MyCatalog(),
          '/cart': (context) => MyCart(),
        },
      ),
    );
  }
}
