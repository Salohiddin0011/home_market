import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:home_market/models/post_model.dart';

class PostPage extends StatefulWidget {
  final Post post;
  const PostPage({super.key, required this.post});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
