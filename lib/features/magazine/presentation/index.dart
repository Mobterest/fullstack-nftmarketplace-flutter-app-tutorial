import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nft_marketplace/features/contract/application/nftProvider.dart';
import 'package:nft_marketplace/features/magazine/domain/magazineArguments.dart';
import 'package:nft_marketplace/features/placeOnSale/domain/placeOnSaleArguments.dart';
import 'package:nft_marketplace/features/placeOnSale/presentation/index.dart';
import 'package:nft_marketplace/features/renewSubscription/domain/renewArguments.dart';
import 'package:nft_marketplace/features/renewSubscription/presentation/index.dart';
import 'package:nft_marketplace/utils/color.dart';
import 'package:nft_marketplace/utils/config.dart';
import 'package:nft_marketplace/utils/fonts.dart';
import 'package:provider/provider.dart';

class Magazine extends StatefulWidget {
  const Magazine({super.key});

  @override
  State<Magazine> createState() => _MagazineState();

  static const routeName = "/magazine";
}

class _MagazineState extends State<Magazine> {
  List<Widget> magazine = [
    const ArticleImage(),
    const Spacer(),
    const ArticleTopic()
  ];

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as MagazineArguments;
    final nft = context.watch<NftProvider>();
    return Scaffold(
      appBar: AppBar(
        actions: (args.source == Source.profileCillectibles)
            ? []
            : [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ActionChip(
                      backgroundColor: themeColor,
                      onPressed: () {
                        Navigator.pushNamed(context, "/createArticle");
                      },
                      label: const Text(
                        "Create an Article",
                        style: TextStyle(color: plainColor),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ActionChip(
                      backgroundColor: plainColor,
                      onPressed: () {
                        Navigator.pushNamed(context, PlaceOnSale.routeName,
                            arguments: PlaceOnSaleArguments(args.tokenId));
                      },
                      label: const Text(
                        "Place on Sale",
                        style: TextStyle(color: themeColor),
                      )),
                ),
              ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          (args.source == Source.profileCillectibles)
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ActionChip(
                      backgroundColor: dangerColor,
                      label: const Text("Cancel Subscription",
                          style: TextStyle(color: plainColor)),
                      onPressed: () {
                        nft.cancelSubscription(args.tokenId);
                        Navigator.pushNamed(context, "/home");
                      },
                    ),
                  ),
                ),
          Text(
            "Fashion".toUpperCase(),
            style: TextStyle(
                fontFamily: headlineFont, fontSize: 34, color: themeColor),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: const Divider(
              thickness: 1,
              color: brandColor,
            ),
          ),
          FutureBuilder<int>(
              future: nft.expiresAt(args.tokenId),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  String days = NumberFormat('#,##,000').format(snapshot.data!);
                  return Text('Expires after: $days' " days");
                }
                return const SizedBox();
              }),
          Column(children: buildWidgets())
        ],
      )),
      floatingActionButton: (args.source == Source.profileCillectibles)
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, RenewSubscription.routeName,
                    arguments: RenewArguments(args.tokenId));
              },
              label: const Text('Renew'),
              icon: const Icon(Icons.thumb_up),
              backgroundColor: brandColor,
            ),
    );
  }

  List<Widget> buildWidgets() {
    List<Widget> x = [];

    for (int i = 0; i < 10; i++) {
      x.add(Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/article");
            },
            child: Card(
              child: Container(
                  padding: const EdgeInsets.all(15.0),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: magazine,
                  )),
            ),
          )));
    }

    return x;
  }
}

class ArticleTopic extends StatelessWidget {
  const ArticleTopic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const IntrinsicHeight(
      child: Row(
        children: [
          const VerticalDivider(
            width: 2.0,
            thickness: 1,
            color: brandColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Column(
              children: const [
                Text(
                  "- MARCH 9TH 2023",
                  style: TextStyle(fontSize: 12, color: dShadeColor),
                ),
                Text(
                  "COLOR MOOD",
                  style: TextStyle(
                      fontSize: 16,
                      color: themeColor,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "READ ARTICLE",
                    style: TextStyle(
                        fontSize: 11,
                        color: brandColor,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ArticleImage extends StatelessWidget {
  const ArticleImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        width: 200,
        child: Image.asset(
          imageUrl,
          fit: BoxFit.contain,
        ));
  }
}
