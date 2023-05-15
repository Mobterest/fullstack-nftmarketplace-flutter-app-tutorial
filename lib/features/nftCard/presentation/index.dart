import 'package:flutter/material.dart';
import 'package:nft_marketplace/utils/color.dart';
import 'package:nft_marketplace/utils/config.dart';

class NftCard extends StatefulWidget {
  final Enum source;
  const NftCard({required this.source, super.key});

  @override
  State<NftCard> createState() => _NftCardState();
}

class _NftCardState extends State<NftCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        (widget.source == Source.home)
            ? Navigator.pushNamed(context, "/subscribe")
            : Navigator.pushNamed(context, "/magazine");
      },
      child: Card(
        elevation: 3.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 5.0),
                tileColor: brandColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                leading: CircleAvatar(
                  backgroundColor: themeColor,
                  child: Text(
                    "J",
                    style: TextStyle(color: plainColor),
                  ),
                ),
                title: Text("Fashion", overflow: TextOverflow.ellipsis),
              ),
            )
          ],
        ),
      ),
    );
  }
}
