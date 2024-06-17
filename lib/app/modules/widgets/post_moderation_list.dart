import 'package:flutter/material.dart';
import 'package:front_forum/app/models/post/post.dart';
import 'package:front_forum/app/models/user/user.dart';
import 'package:front_forum/app/repositories/post_repository.dart';
import 'package:front_forum/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PostModerationList extends StatelessWidget {
  final PostResponse post;

  PostModerationList({required this.post});

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
                    elevation: 0,
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 2,
                        left: 20,
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
                                children: [
                                  Text(
                                    "${author.surname} ${author.name}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
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
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.description,
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    //TODO запрос на одобрение поста
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: const EdgeInsets.all(5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      side:
                                          const BorderSide(color: Colors.green),
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
                                    //TODO запрос на отклонение поста
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
