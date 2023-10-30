import 'package:flutter/material.dart';
import 'package:home_market/models/post_model.dart';

// ignore: must_be_immutable
class GalleryPage extends StatefulWidget {
  Post? post;
  GalleryPage({required this.post, super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GridView.builder(
          primary: true,
          itemCount: widget.post!.gridImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10, crossAxisSpacing: 10, crossAxisCount: 2),
          itemBuilder: (_, i) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                widget.post!.gridImages[i],
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            );
          }),
    );
  }
}
