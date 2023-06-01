import 'package:flutter/material.dart';
import 'package:nft_marketplace/features/magazine/domain/magazineArguments.dart';
import 'package:nft_marketplace/features/magazine/presentation/index.dart';
import 'package:nft_marketplace/features/profile/application/profileProvider.dart';
import 'package:nft_marketplace/features/subscribe/domain/subscribeArguments.dart';
import 'package:nft_marketplace/features/subscribe/presentation/index.dart';
import 'package:nft_marketplace/utils/color.dart';
import 'package:nft_marketplace/utils/config.dart';
import 'package:provider/provider.dart';

class NftCard extends StatefulWidget {
  final Enum source;
  final List<dynamic> nft;
  const NftCard({required this.source, required this.nft, super.key});

  @override
  State<NftCard> createState() => _NftCardState();
}

class _NftCardState extends State<NftCard> {
  @override
  Widget build(BuildContext context) {
    final status = context.watch<ProfileProvider>();
    return GestureDetector(
      onTap: () {
        (widget.source == Source.home)
            ? Navigator.pushNamed(context, Subscribe.routeName,
                arguments: SubscribeArguments(widget.nft))
            : (status.profileStatus)
                ? Navigator.pushNamed(context, Magazine.routeName,
                    arguments:
                        MagazineArguments(widget.nft[0].toInt(), widget.source))
                : null;
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
                child: Image.network(
                  widget.nft[8],
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(imageUrl, fit: BoxFit.contain);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 5.0),
                tileColor: brandColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                leading: const CircleAvatar(
                  backgroundColor: themeColor,
                  // child: Text(
                  //   "J",
                  //   style: TextStyle(color: plainColor),
                  // ),
                ),
                title: Text(widget.nft[6], overflow: TextOverflow.ellipsis),
              ),
            )
          ],
        ),
      ),
    );
  }
}
