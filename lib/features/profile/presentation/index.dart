import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:nft_marketplace/features/nftCard/presentation/index.dart';
import 'package:nft_marketplace/utils/color.dart';
import 'package:nft_marketplace/utils/config.dart';
import 'package:nft_marketplace/utils/fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: FluttermojiCircleAvatar(
              backgroundColor: Colors.grey[200],
              radius: 70,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "${dummyAddress.substring(0, 8)}...",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: bodyFont,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "10",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: themeColor,
                        fontFamily: bodyFont),
                  ),
                  const Text("My NFTs")
                ],
              ),
              Column(
                children: [
                  Text(
                    "100",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: themeColor,
                      fontFamily: bodyFont,
                    ),
                  ),
                  const Text("Followers")
                ],
              ),
              Column(
                children: [
                  Text(
                    "2",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: themeColor,
                        fontFamily: bodyFont),
                  ),
                  const Text("Following")
                ],
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                  onPressed: () {}, child: const Text("Follow"))),
          DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TabBar(
                  labelColor: brandColor,
                  unselectedLabelColor: themeColor,
                  labelStyle: TextStyle(
                      fontFamily: bodyFont, fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(
                      text: "My NFTs",
                      icon: Icon(
                        Icons.pages,
                        color: brandColor,
                      ),
                    ),
                    Tab(
                      text: "Collectibles",
                      icon: Icon(
                        Icons.label,
                        color: brandColor,
                      ),
                    )
                  ],
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: TabBarView(
                      children: [
                        GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: (1 / 1.4),
                              crossAxisCount: 2,
                            ),
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                              return const NftCard(
                                source: Source.myNfts,
                              );
                            }),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 40.0, right: 40.0),
                          child: EmptyWidget(
                            image: null,
                            packageImage: PackageImage.Image_3,
                            title: 'No Collectables',
                            subTitle: 'No  collectables available yet',
                            titleTextStyle: const TextStyle(
                              fontSize: 22,
                              color: Color(0xff9da9c7),
                              fontWeight: FontWeight.w500,
                            ),
                            subtitleTextStyle: const TextStyle(
                              fontSize: 14,
                              color: Color(0xffabb8d6),
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
