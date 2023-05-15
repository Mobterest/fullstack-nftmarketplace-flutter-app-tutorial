import 'package:flutter/material.dart';
import 'package:nft_marketplace/features/article/presentation/index.dart';
import 'package:nft_marketplace/features/createArticle/presentation/index.dart';
import 'package:nft_marketplace/features/home/presentation/index.dart';
import 'package:nft_marketplace/features/landing/presentation/index.dart';
import 'package:nft_marketplace/features/magazine/presentation/index.dart';
import 'package:nft_marketplace/features/placeOnSale/presentation/index.dart';
import 'package:nft_marketplace/features/publishArticle/presentation/index.dart';
import 'package:nft_marketplace/features/subscribe/presentation/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Landing(),
        '/home': (context) => const Home(),
        '/subscribe': (context) => const Subscribe(),
        '/magazine': (context) => const Magazine(),
        '/article': (context) => const Article(),
        '/createArticle': (context) => const CreateArticle(),
        '/publishArticle': (context) => const PublishArticle(),
        '/placeOnSale': (context) => const PlaceOnSale(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
