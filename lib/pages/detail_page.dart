import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_market/blocs/main/main_bloc.dart';
import 'package:home_market/blocs/post/post_bloc.dart';
import 'package:home_market/models/post_model.dart';
import 'package:home_market/views/detail_txt.dart';
import 'package:image_picker/image_picker.dart';

class DetailPage extends StatefulWidget {
  final Post? post;

  const DetailPage({this.post, Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final TextEditingController titleController;
  late final TextEditingController contentController;
  late bool isPublic;
  final ImagePicker picker = ImagePicker();
  File? file;
  List<File?> files = [];

  @override
  void initState() {
    super.initState();
    setup();
  }

  void setup() {
    if (widget.post != null) {
      isPublic = widget.post!.isPublic;
      context.read<PostBloc>().add(PostIsPublicEvent(isPublic));
      titleController = TextEditingController(text: widget.post!.title);
      contentController = TextEditingController(text: widget.post!.content);
    } else {
      isPublic = false;
      titleController = TextEditingController();
      contentController = TextEditingController();
    }
  }

  void getImage() async {
    final xFile = await picker.pickImage(source: ImageSource.gallery);
    file = xFile != null ? File(xFile.path) : null;
    if (file != null && mounted) {
      context.read<PostBloc>().add(ViewImagePostEvent(file!));
    }
  }

  void getMultiImage() async {
    final xFile = await picker.pickMultiImage(maxHeight: 1000, maxWidth: 1000);
    files = xFile.map((e) => File(e.path)).toList();
    if (files.isNotEmpty && mounted) {
      context.read<PostBloc>().add(ViewGridImagesPostEvent(files));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DetailPage"),
      ),
      body: BlocListener<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }

          if (state is CreatePostSuccess || state is UpdatePostSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Successfully completed!!!")));
            context.read<MainBloc>().add(const GetAllDataEvent());
            Navigator.of(context).pop();
          }

          if (state is PostIsPublicState) {
            isPublic = state.isPublic;
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: getImage,
                      child: BlocBuilder<PostBloc, PostState>(
                        buildWhen: (previous, current) =>
                            current is ViewImagePostSuccess,
                        builder: (context, state) {
                          return Card(
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).width - 40,
                              width: MediaQuery.sizeOf(context).width,
                              child: file == null
                                  ? const Icon(
                                      Icons.add,
                                      size: 175,
                                    )
                                  : Image.file(
                                      file!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomDetailTextField(
                        controller: titleController, title: "Title"),
                    CustomDetailTextField(
                        controller: contentController, title: "Content"),
                    Row(
                      children: [
                        BlocSelector<PostBloc, PostState, bool>(
                          selector: (state) {
                            if (state is PostIsPublicState)
                              return state.isPublic;

                            return isPublic;
                          },
                          builder: (context, value) {
                            return Checkbox(
                                value: value,
                                onChanged: (value) {
                                  context
                                      .read<PostBloc>()
                                      .add(PostIsPublicEvent(value!));
                                });
                          },
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Do you want to make your post public?",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    BlocBuilder<PostBloc, PostState>(
                        buildWhen: (previous, current) =>
                            current is ViewGridImagesPostSuccess,
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: getMultiImage,
                            child: files.isEmpty
                                ? Container(
                                    height: 150,
                                    width: 150,
                                    color: Colors.black,
                                  )
                                : GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: files.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    itemBuilder: (context, i) {
                                      return Card(
                                        child: Image.file(
                                          files[i]!,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                          );
                        })
                  ],
                ),
              ),
            ),
            if (context.read<PostBloc>().state is PostLoading)
              BlocBuilder<PostBloc, PostState>(builder: (context, state) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.post == null) {
            print('create');
            context.read<PostBloc>().add(CreatePostEvent(
                gridImages: files,
                file: file!,
                title: titleController.text,
                content: contentController.text,
                isPublic: isPublic,
                carPark: false,
                swimming: false,
                gym: false,
                restaurant: false,
                wifi: false,
                petCenter: false,
                medicalCentre: false,
                school: false,
                area: '121',
                bathrooms: '2',
                isApartment: false,
                phone: '1234',
                price: '2134',
                rooms: '7'));
          } else {
            context.read<PostBloc>().add(UpdatePostEvent(
                gridImages: files,
                postId: widget.post!.id,
                file: file!,
                title: titleController.text,
                content: contentController.text,
                isPublic: isPublic,
                carPark: false,
                swimming: false,
                gym: false,
                restaurant: false,
                wifi: false,
                petCenter: false,
                medicalCentre: false,
                school: false,
                area: '121',
                bathrooms: '2',
                isApartment: false,
                phone: '1234',
                price: '2134',
                rooms: '7'));
          }
        },
        child: const Icon(Icons.cloud_upload_rounded),
      ),
    );
  }
}
