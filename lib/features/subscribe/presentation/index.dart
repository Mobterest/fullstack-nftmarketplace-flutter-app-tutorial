import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:nft_marketplace/features/subscribe/domain/subscribeArguments.dart';
import 'package:nft_marketplace/utils/color.dart';
import 'package:nft_marketplace/utils/config.dart';
import 'package:nft_marketplace/utils/constants.dart';
import 'package:nft_marketplace/utils/fonts.dart';
import 'package:nft_marketplace/utils/func.dart';
import 'package:status_alert/status_alert.dart';
import 'package:web3dart/web3dart.dart';

class Subscribe extends StatefulWidget {
  const Subscribe({super.key});

  @override
  State<Subscribe> createState() => _SubscribeState();

  static const routeName = '/subscribe';
}

class _SubscribeState extends State<Subscribe> with Func {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as SubscribeArguments;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, "/home");
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    favorite = !favorite;
                  });
                },
                icon: Icon((favorite == true)
                    ? Icons.favorite
                    : Icons.favorite_outline)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.share))
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(
                    bottom: 10.0, right: 10.0, left: 10.0),
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  args.nft[8],
                  fit: BoxFit.contain,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                args.nft[6],
                style: TextStyle(
                    color: themeColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: titleFont),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                args.nft[7],
                style: TextStyle(fontSize: 16, fontFamily: bodyFont),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text(
                    "Created by: ",
                    style: TextStyle(fontFamily: bodyFont),
                  ),
                  const Spacer(),
                  ActionChip(
                    label: Text(
                      "${args.nft[1].toString().substring(0, 8)}...",
                      style: TextStyle(
                          color: plainColor,
                          fontSize: 16,
                          fontFamily: bodyFont,
                          fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {},
                    backgroundColor: brandColor,
                  )
                ],
              ),
            )
          ],
        )),
        bottomNavigationBar: Container(
          color: themeColor,
          padding: const EdgeInsets.only(bottom: 40.0, right: 20.0, left: 20.0),
          child: Row(
            children: [
              Text(
                "${args.nft[3]} ETH",
                style: TextStyle(
                    color: plainColor,
                    fontSize: 16,
                    fontFamily: bodyFont,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton.icon(
                  onPressed: () {
                    if (args.nft[1] == EthereumAddress.fromHex(dummyAddress)) {
                      showDialog();
                    } else {
                      buySubscription(
                          args.nft[0].toInt(), args.nft[3], context);
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_right_rounded,
                    color: plainColor,
                    size: 50,
                  ),
                  label: Text(
                    "Subscribe",
                    style: TextStyle(
                        fontFamily: buttonFont,
                        fontSize: 20,
                        color: plainColor),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  showDialog() {
    StatusAlert.show(context,
        duration: const Duration(seconds: 5),
        title: 'NFT Magazine',
        subtitle: 'Cannot subscribe to your own NFT',
        titleOptions: StatusAlertTextConfiguration(
            style: const TextStyle(
                color: plainColor, fontWeight: FontWeight.bold, fontSize: 20)),
        subtitleOptions: StatusAlertTextConfiguration(
            style: const TextStyle(color: plainColor)),
        configuration:
            const IconConfiguration(icon: Icons.cancel, color: brandColor),
        maxWidth: 260,
        backgroundColor: darkColor);
  }
}
