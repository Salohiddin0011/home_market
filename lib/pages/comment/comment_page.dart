import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_market/services/constants/app_colors.dart';

import '../../blocs/post/post_bloc.dart';
import '../../models/post_model.dart';
import '../../services/firebase/auth_service.dart';
import '../../services/firebase/db_service.dart';
import '../../views/comment_view/comment_text_field.dart';

class CommentPage extends StatefulWidget {
  final Post post;
  const CommentPage({super.key, required this.post});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  var controller = TextEditingController();

  getSenderView(CustomClipper clipper, BuildContext context, String messenge,
          String userName, String time) =>
      ChatBubble(
        clipper: clipper,
        alignment: Alignment.topRight,
        margin: const EdgeInsets.only(top: 20),
        backGroundColor: AppColors.ff016FFF,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                userName,
                style: TextStyle(
                    color: AppColors.ff122D4D,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                messenge,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                time,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      );

  getReceiverView(CustomClipper clipper, BuildContext context, String messenge,
          String userName, String time) =>
      ChatBubble(
        clipper: clipper,
        backGroundColor: const Color(0xffE7E7ED),
        margin: const EdgeInsets.only(top: 20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                messenge,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 4.sp),
              Text(
                time,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 20),
                Image.network(
                  widget.post.imageUrl,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(
                  height: 10,
                ),
                StreamBuilder(
                  stream: DBService.db
                      .ref(Folder.post)
                      .child(widget.post.id)
                      .onValue,
                  builder: (context, snapshot) {
                    Post current = snapshot.hasData
                        ? Post.fromJson(
                            jsonDecode(
                                    jsonEncode(snapshot.data!.snapshot.value))
                                as Map<String, Object?>,
                            isMe: AuthService.user.uid == widget.post.userId)
                        : widget.post;

                    widget.post.comments = current.comments;
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: current.comments.length,
                      itemBuilder: (context, index) {
                        final msg = current.comments[index];

                        if (AuthService.user.uid == msg.userId) {
                          return getSenderView(
                            ChatBubbleClipper2(type: BubbleType.sendBubble),
                            context,
                            msg.message,
                            msg.username,
                            "${msg.writtenAt.hour}:${msg.writtenAt.minute}",
                          );
                        }

                        return getReceiverView(
                          ChatBubbleClipper2(type: BubbleType.receiverBubble),
                          context,
                          msg.message,
                          msg.username,
                          "${msg.writtenAt.hour}:${msg.writtenAt.minute}",
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 85),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CommentTextField(
                textEditingController: controller,
                funksiya: () {
                  context.read<PostBloc>().add(
                        WriteCommentPostEvent(widget.post.id,
                            controller.text.trim(), widget.post.comments),
                      );
                  controller.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
