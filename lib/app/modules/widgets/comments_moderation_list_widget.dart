import 'package:flutter/material.dart';
import 'package:front_forum/app/models/comment/comment.dart';
import 'package:front_forum/app/modules/moderation/controllers/moderation_controller.dart';
import 'package:front_forum/app/repositories/comment_repository.dart';
import 'package:front_forum/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommentsModerationList extends StatelessWidget {
  final CommentsResponse comments;
  final ModerationController controller;

  CommentsModerationList({required this.comments, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: comments.when(
        loading: () => const CircularProgressIndicator(
          color: Colors.orange,
        ),
        success: (List<Comment> list) {
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              var item = list[index];
              var formattedDate =
                  DateFormat('yyyy-MM-dd HH:mm').format(item.date);
              return Card(
                elevation: 0,
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 2,
                  top: 8,
                  bottom: 8,
                  right: 8,
                ),
                clipBehavior: Clip.none,
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.PROFILE,
                              parameters: {"userId": item.author["_id"]});
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Row(
                            children: [
                              Text(
                                item.author['username'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                formattedDate,
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.data,
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                controller.approveComment(item.id);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.all(5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                  side: const BorderSide(color: Colors.green),
                                ),
                              ),
                              child: const Text(
                                "Одобрить",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                controller.rejectComment(item.id);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.all(5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                  side: const BorderSide(color: Colors.red),
                                ),
                              ),
                              child: const Text(
                                "Отклонить",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        failed: (er, obj) => Text(
          er.toString(),
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 40.0, color: Colors.red),
        ),
      ),
    );
  }
}
