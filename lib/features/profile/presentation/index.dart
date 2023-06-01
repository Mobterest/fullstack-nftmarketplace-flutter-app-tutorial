import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:nft_marketplace/features/contract/application/nftProvider.dart';
import 'package:nft_marketplace/features/nftCard/presentation/index.dart';
import 'package:nft_marketplace/features/profile/application/profileProvider.dart';
import 'package:nft_marketplace/utils/color.dart';
import 'package:nft_marketplace/utils/config.dart';
import 'package:nft_marketplace/utils/fonts.dart';
import 'package:nft_marketplace/utils/func.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with Func {
  @override
  Widget build(BuildContext context) {
    final status = context.watch<ProfileProvider>();
    return (status.profileStatus)
        ? const MainBody()
        : Scaffold(
            appBar: AppBar(
              title: const Text("User Profile"),
            ),
            body: const MainBody(),
          );
  }
}

class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> with Func {
  @override
  Widget build(BuildContext context) {
    final nft = context.watch<NftProvider>();
    final status = context.watch<ProfileProvider>();
    print(nft.myProfile);
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
              (status.profileStatus)
                  ? "${(nft.myProfile.isEmpty) ? dummyAddress : nft.myProfile[0].toString().substring(0, 8)}..."
                  : "${(nft.userProfile.isEmpty) ? dummyAddress : nft.userProfile[0].toString().substring(0, 8)}...",
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
                    nft.myNfts.length.toString(),
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
                    (nft.myProfile.isEmpty)
                        ? "0"
                        : (nft.myProfile.length < 2)
                            ? "0"
                            : nft.myProfile[1].length.toString(),
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
                    (nft.myProfile.isEmpty)
                        ? "0"
                        : (nft.myProfile.length < 3)
                            ? "0"
                            : nft.myProfile[2].length.toString(),
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
          (status.profileStatus)
              ? const SizedBox()
              : Padding(
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
                        (nft.myNfts.isNotEmpty)
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: (1 / 1.4),
                                  crossAxisCount: 2,
                                ),
                                itemCount: nft.myNfts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return NftCard(
                                    source: Source.myNfts,
                                    nft: nft.myNfts[index],
                                  );
                                })
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 40.0, right: 40.0),
                                child: EmptyWidget(
                                  image: null,
                                  packageImage: PackageImage.Image_3,
                                  title: 'No Magazine NFTS',
                                  subTitle: 'You do not own any nfts yet!',
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
                              ),
                        (nft.collectables.isNotEmpty)
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: (1 / 1.4),
                                  crossAxisCount: 2,
                                ),
                                itemCount: nft.collectables.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return NftCard(
                                    source: Source.profileCillectibles,
                                    nft: nft.collectables[index],
                                  );
                                })
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 40.0, right: 40.0),
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
