import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:nft_marketplace/utils/color.dart';
import 'package:nft_marketplace/utils/fonts.dart';
import 'package:turn_page_transition/turn_page_transition.dart';

class Article extends StatefulWidget {
  const Article({super.key});

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: plainColor,
      appBar: AppBar(
        backgroundColor: plainColor,
        iconTheme: const IconThemeData(color: brandColor),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 20.0, bottom: 100, left: 20.0, right: 20.0),
          child: Column(children: [
            Text(
              "COLOR MOOD",
              style: TextStyle(
                  color: brandColor, fontFamily: titleFont, fontSize: 18),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "09 March 2023",
                    style: TextStyle(color: themeColor),
                  )),
            ),
            Text(
              lorem(paragraphs: 5, words: 200),
              style: TextStyle(height: 1.6, fontFamily: bodyFont),
              textAlign: TextAlign.justify,
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            TurnPageRoute(
              overleafColor: Colors.grey,
              animationTransitionPoint: 0.5,
              transitionDuration: const Duration(milliseconds: 500),
              reverseTransitionDuration: const Duration(milliseconds: 300),
              builder: (context) => const Article(),
            ),
          );
        },
        label: const Text("Next"),
        icon: const Icon(Icons.navigate_next),
        backgroundColor: brandColor,
      ),
    );
  }
}
