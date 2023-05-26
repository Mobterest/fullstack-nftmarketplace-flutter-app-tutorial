import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:nft_marketplace/features/contract/application/nftProvider.dart';
import 'package:nft_marketplace/utils/color.dart';
import 'package:nft_marketplace/utils/constants.dart';
import 'package:nft_marketplace/utils/fonts.dart';
import 'package:provider/provider.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    final nft = context.watch<NftProvider>();
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: CircularText(
              children: [
                TextItem(
                  text: Text(
                    "New Era".toUpperCase(),
                    style: TextStyle(
                        color: darkColor,
                        fontSize: 20,
                        fontFamily: headlineFont,
                        fontWeight: FontWeight.bold),
                  ),
                  space: 15,
                  startAngle: -90,
                  startAngleAlignment: StartAngleAlignment.center,
                  direction: CircularTextDirection.clockwise,
                ),
                TextItem(
                  text: Text("NFT Magazines".toUpperCase(),
                      style: TextStyle(
                          color: themeColor,
                          fontSize: 28,
                          fontFamily: headlineFont)),
                  space: 15,
                  startAngle: 90,
                  startAngleAlignment: StartAngleAlignment.center,
                  direction: CircularTextDirection.anticlockwise,
                )
              ],
              radius: 60,
              position: CircularTextPosition.outside,
              backgroundPaint: Paint()..color = brandColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(tagLine,
                style: TextStyle(
                    fontFamily: taglineFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: brandColor)),
          ),
          Text(
            description,
            style: TextStyle(
                fontFamily: bodyFont,
                fontSize: 17,
                fontWeight: FontWeight.w700),
          ),
        ]),
      )),
      bottomNavigationBar: Container(
          margin: const EdgeInsets.all(40),
          width: MediaQuery.of(context).size.width * 0.8,
          height: 50,
          child: ElevatedButton(
              onPressed: () {
                nft.addProfile();
                nft.getSubscriptions();
                Navigator.pushNamed(context, "/home");
              },
              child: Text(
                landingAction,
                style: TextStyle(fontFamily: buttonFont, fontSize: 24),
              ))),
    );
  }
}
