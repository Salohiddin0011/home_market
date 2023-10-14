import 'package:flutter/material.dart';

import '../../services/constants/app_colors.dart';

class CommentTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function() funksiya;
  const CommentTextField(
      {super.key, required this.textEditingController, required this.funksiya});

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.sizeOf(context).width,
        height: 90,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: 60,
            child: Card(
              elevation: 9,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: TextField(
                controller: widget.textEditingController,
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: InputBorder.none,
                  hintText: 'Messenge',
                  hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  suffixIcon: IconButton(
                    splashRadius: 1,
                    onPressed: widget.funksiya,
                    icon: const Icon(
                      Icons.send,
                      color: AppColors.ff016FFF,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
