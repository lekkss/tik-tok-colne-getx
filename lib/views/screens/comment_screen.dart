import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tok/viewmodel/comment_viewmodel.dart';

class CommentSceen extends StatelessWidget {
  final String id;
  CommentSceen({Key? key, required this.id}) : super(key: key);

  final TextEditingController _commentController = TextEditingController();
  CommentController commentController = Get.put(
    CommentController(),
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    commentController.updatePostId(id);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          backgroundImage: NetworkImage("pp"),
                        ),
                        title: Row(
                          children: [
                            Text(
                              "USername",
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "Comment Description",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              "date",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "10 likes",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        trailing: InkWell(
                          onTap: () {
                            print("liked");
                          },
                          child: Icon(
                            Icons.favorite,
                            size: 25,
                            color: Colors.red,
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
              const Divider(),
              ListTile(
                title: TextFormField(
                  controller: _commentController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "Comment",
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () => commentController.postComment(
                    _commentController.text,
                  ),
                  child: const Text(
                    "Send",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
