import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:nft_marketplace/utils/color.dart';
import 'package:nft_marketplace/utils/fonts.dart';

class PublishArticle extends StatefulWidget {
  const PublishArticle({super.key});

  @override
  State<PublishArticle> createState() => _PublishArticleState();
}

class _PublishArticleState extends State<PublishArticle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: brandColor,
        title: Text(
          "Creating...",
          style: TextStyle(fontFamily: titleFont),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  lorem(paragraphs: 1, words: 7).toUpperCase(),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: themeColor),
                ),
              ),
              AnimatedTextKit(animatedTexts: [
                TypewriterAnimatedText(lorem(paragraphs: 10, words: 200),
                    textStyle: TextStyle(fontFamily: bodyFont, fontSize: 16),
                    curve: Curves.ease)
              ]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          margin: const EdgeInsets.all(40),
          width: MediaQuery.of(context).size.width * 0.8,
          height: 50,
          child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Publish",
                style: TextStyle(fontFamily: buttonFont, fontSize: 24),
              ))),
    );
  }
}
