import 'package:flutter/material.dart';
import 'package:nft_marketplace/utils/color.dart';
import 'package:nft_marketplace/utils/fonts.dart';

class CreateArticle extends StatefulWidget {
  const CreateArticle({super.key});

  @override
  State<CreateArticle> createState() => _CreateArticleState();
}

class _CreateArticleState extends State<CreateArticle> {
  final TextEditingController promptController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: brandColor,
        title: Text(
          "Create an Article",
          style: TextStyle(fontFamily: titleFont),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: promptController,
              minLines: 6,
              maxLines: null,
              decoration: InputDecoration(
                  hintText: "Enter prompt to generate your article",
                  hintStyle: TextStyle(fontFamily: bodyFont)),
            ),
            Container(
              margin: const EdgeInsets.all(40),
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/publishArticle");
                  },
                  child: Text(
                    "Create",
                    style: TextStyle(fontFamily: buttonFont, fontSize: 24),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
