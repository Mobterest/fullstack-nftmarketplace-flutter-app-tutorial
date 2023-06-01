import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:nft_marketplace/features/createNFT/application/createNftProvider.dart';
import 'package:nft_marketplace/utils/color.dart';
import 'package:nft_marketplace/utils/constants.dart';
import 'package:nft_marketplace/utils/fonts.dart';
import 'package:nft_marketplace/utils/func.dart';
import 'package:provider/provider.dart';

class CreateNft extends StatefulWidget {
  const CreateNft({super.key});

  @override
  State<CreateNft> createState() => _CreateNftState();
}

class _CreateNftState extends State<CreateNft> with Func {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late File imageFile;

  @override
  Widget build(BuildContext context) {
    final exec = context.watch<CreateProvider>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                "Title:",
                style: TextStyle(
                    fontFamily: bodyFont,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              controller: titleController,
              maxLines: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text("Description:",
                  style: TextStyle(
                      fontFamily: bodyFont,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
            TextField(
              controller: descriptionController,
              maxLines: null,
              minLines: 4,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () async {
                    imageFile = await uploadMagazineCover();
                    exec.setImageFile(imageFile);
                  },
                  child: DottedBorder(
                      dashPattern: const [6, 3],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      padding: const EdgeInsets.all(6),
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: (exec.image == null)
                              ? Container(
                                  alignment: Alignment.center,
                                  width: 200,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  color: plainColor,
                                  child: const Text(uploadDescription),
                                )
                              : Image.file(imageFile))),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.all(40),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      createNft(imageFile, titleController.text,
                          descriptionController.text, context);
                      titleController.clear();
                      descriptionController.clear();
                      Navigator.pushNamed(context, "/home");
                    },
                    child: Text(
                      "Create NFT",
                      style: TextStyle(fontFamily: buttonFont, fontSize: 24),
                    )))
          ],
        ),
      ),
    );
  }
}
