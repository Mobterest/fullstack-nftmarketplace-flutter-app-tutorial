import 'package:flutter/material.dart';
import 'package:nft_marketplace/features/article/presentation/index.dart';
import 'package:nft_marketplace/features/contract/application/nftProvider.dart';
import 'package:nft_marketplace/features/createArticle/presentation/index.dart';
import 'package:nft_marketplace/features/createNFT/application/createNftProvider.dart';
import 'package:nft_marketplace/features/home/presentation/index.dart';
import 'package:nft_marketplace/features/landing/presentation/index.dart';
import 'package:nft_marketplace/features/magazine/presentation/index.dart';
import 'package:nft_marketplace/features/placeOnSale/presentation/index.dart';
import 'package:nft_marketplace/features/profile/application/profileProvider.dart';
import 'package:nft_marketplace/features/publishArticle/presentation/index.dart';
import 'package:nft_marketplace/features/renewSubscription/presentation/index.dart';
import 'package:nft_marketplace/features/subscribe/presentation/index.dart';
import 'package:provider/provider.dart';

import 'features/profile/presentation/index.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NftProvider()),
      ChangeNotifierProvider(create: (_) => CreateProvider()),
      ChangeNotifierProvider(create: (_) => ProfileProvider())
    ],
    child: const MyApp(),
  ));
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
        Subscribe.routeName: (context) => const Subscribe(),
        Magazine.routeName: (context) => const Magazine(),
        '/article': (context) => const Article(),
        '/createArticle': (context) => const CreateArticle(),
        '/publishArticle': (context) => const PublishArticle(),
        PlaceOnSale.routeName: (context) => const PlaceOnSale(),
        RenewSubscription.routeName: (context) => const RenewSubscription(),
        '/profile': (context) => const Profile(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
