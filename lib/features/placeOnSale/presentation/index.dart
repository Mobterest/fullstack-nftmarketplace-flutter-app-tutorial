import 'package:flutter/material.dart';
import 'package:nft_marketplace/features/placeOnSale/domain/placeOnSaleArguments.dart';
import 'package:nft_marketplace/utils/color.dart';
import 'package:nft_marketplace/utils/fonts.dart';
import 'package:nft_marketplace/utils/func.dart';

class PlaceOnSale extends StatefulWidget {
  const PlaceOnSale({super.key});

  @override
  State<PlaceOnSale> createState() => _PlaceOnSaleState();

  static const routeName = "/placeonsale";
}

class _PlaceOnSaleState extends State<PlaceOnSale> with Func {
  final TextEditingController priceController = TextEditingController();
  final List<String> list = ["1 week", "1 month", "3 months"];
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PlaceOnSaleArguments;
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
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    suffixText: ' ETH',
                  )),
            ),
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
            DropdownButton<String>(
              isExpanded: true,
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: darkColor),
              underline: Container(
                height: 2,
                color: brandColor,
              ),
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Container(
                margin: const EdgeInsets.all(40),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      Duration daysToSeconds = Duration(
                          days: (dropdownValue == "1 week")
                              ? 7
                              : (dropdownValue == "1 month")
                                  ? 28
                                  : 84);

                      sellSubscription(
                          args.tokenId,
                          int.parse(priceController.text),
                          daysToSeconds.inDays,
                          context);
                      Navigator.pushNamed(context, "/home");
                    },
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
