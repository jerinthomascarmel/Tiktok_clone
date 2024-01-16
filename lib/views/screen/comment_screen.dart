import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controller/comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  CommentScreen({super.key, required this.id});
  final String id;
  final TextEditingController commentTextEditingController =
      TextEditingController();
  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePosId(id);
    return Scaffold(
      appBar: AppBar(title: const Text("Comments")),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Expanded(child: Obx(() {
              final comments = commentController.comments;
              return ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    subtitle: Row(
                      children: [
                        Text(
                          tago.format(comments[index].datePublished.toDate()),
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${comments[index].likes.length} likes',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: InkWell(
                      onTap: () =>
                          commentController.likeComment(comments[index].id),
                      child: Icon(
                        Icons.favorite,
                        size: 25,
                        color: comments[index]
                                .likes
                                .contains(authController.user.uid)
                            ? Colors.red
                            : Colors.white,
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:
                          NetworkImage(comments[index].profilePhoto),
                    ),
                    title: Row(children: [
                      Text(
                        comments[index].username,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        comments[index].comment,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ]),
                  );
                },
              );
            })),
            const Divider(),
            SafeArea(
              child: ListTile(
                title: TextFormField(
                  controller: commentTextEditingController,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  decoration: const InputDecoration(
                      labelText: 'Comment',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 221, 180, 180),
                        fontWeight: FontWeight.w700,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      )),
                ),
                trailing: TextButton(
                    onPressed: () => commentController
                        .postComment(commentTextEditingController.text),
                    child: const Text(
                      'Send',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
