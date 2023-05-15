import 'package:flutter/material.dart';
import 'package:nft_marketplace/utils/color.dart';
import 'package:nft_marketplace/utils/fonts.dart';

class PlaceOnSale extends StatefulWidget {
  const PlaceOnSale({super.key});

  @override
  State<PlaceOnSale> createState() => _PlaceOnSaleState();
}

class _PlaceOnSaleState extends State<PlaceOnSale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: brandColor,
        title: Text(
          "Place on Sale",
          style: TextStyle(fontFamily: titleFont),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Set a price",
              style: TextStyle(
                  fontFamily: bodyFont,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
            const TextField(
                decoration: InputDecoration(
              suffixText: ' ETH',
            )),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Set a duration",
                style: TextStyle(
                    fontFamily: bodyFont,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            ),
            const TextField(),
            Container(
                margin: const EdgeInsets.all(40),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Sell",
                      style: TextStyle(fontFamily: buttonFont, fontSize: 24),
                    )))
          ],
        ),
      ),
    );
  }
}
