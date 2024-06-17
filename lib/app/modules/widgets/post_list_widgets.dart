import 'package:flutter/material.dart';
import 'package:front_forum/app/models/post/post.dart';
import 'package:front_forum/app/models/user/user.dart';
import 'package:front_forum/app/repositories/post_repository.dart';
import 'package:front_forum/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PostList extends StatelessWidget {
  final PostResponse post;

  PostList({required this.post});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: post.when(
        loading: () => const CircularProgressIndicator(
          color: Colors.orange,
        ),
        success: (List<Post> list) {
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              var item = list[index];
              var formattedDate =
                  DateFormat('yyyy-MM-dd HH:mm').format(item.date);
              return FutureBuilder<User?>(
                future: item.getAuthor,
                builder: (context, authorSnapshot) {
                  if (!authorSnapshot.hasData) {
                    return const SizedBox();
                  }
                  var author = authorSnapshot.data!;

                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 10,
                        left: MediaQuery.of(context).size.width / 10,
                        top: 8,
                        bottom: 8),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.PROFILE,
                                  parameters: {"userId": item.author});
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${author.surname} ${author.name}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                  ),
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
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                Routes.READ_POST,
                                parameters: {"postId": item.id},
                              );
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Text(
                                item.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.description.length > 100
                                ? '${item.description.substring(0, 100)}...'
                                : item.description,
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const Icon(
                                Icons.thumb_up,
                                color: Colors.orange,
                                size: 16.0,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                item.likes.toString(),
                                style: const TextStyle(fontSize: 14.0),
                              ),
                              const SizedBox(width: 16.0),
                              const Icon(
                                Icons.comment,
                                color: Colors.orange,
                                size: 16.0,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                item.comments.length.toString(),
                                style: const TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  );
                },
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
