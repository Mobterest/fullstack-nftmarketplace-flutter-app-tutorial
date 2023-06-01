import 'package:flutter/material.dart';
import 'package:nft_marketplace/features/renewSubscription/domain/renewArguments.dart';
import 'package:nft_marketplace/utils/color.dart';
import 'package:nft_marketplace/utils/fonts.dart';
import 'package:nft_marketplace/utils/func.dart';
import 'package:select_card/select_card.dart';

class RenewSubscription extends StatefulWidget {
  const RenewSubscription({super.key});

  @override
  State<RenewSubscription> createState() => _RenewSubscriptionState();

  static const routeName = "/renew";
}

class _RenewSubscriptionState extends State<RenewSubscription> with Func {
  String setDuration = "";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as RenewArguments;

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.keyboard_arrow_left,
                color: brandColor,
                size: 30,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.rocket,
                  size: 100,
                  color: brandColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Renew for your subscribers to access your magazine NFTs daily",
                  style: TextStyle(
                      fontFamily: bodyFont,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SelectGroupCard(context,
                    cardBackgroundColor: brandColor,
                    cardSelectedColor: themeColor,
                    titleTextColor: themeColor,
                    titles: const ["1 week", "1 month", "3 months"],
                    onTap: (title) {
                  setState(() {
                    setDuration = title;
                  });
                }),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  setDuration,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: headlineFont,
                      color: themeColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    margin: const EdgeInsets.only(left: 40, right: 40, top: 10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Duration daysToSeconds = Duration(
                            days: (setDuration == "1 week")
                                ? 7
                                : (setDuration == "1 month")
                                    ? 28
                                    : 84);

                        renewSubscription(
                            args.tokenId, daysToSeconds.inDays, context);
                      },
                      child: Text(
                        "Renew",
                        style: TextStyle(fontFamily: buttonFont, fontSize: 24),
                      ),
                    ))
              ],
            ),
          )
        ],
      )),
    );
  }
}
