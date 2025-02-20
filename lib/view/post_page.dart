import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test1_mevivu/controller/post_controller.dart';
import 'package:test1_mevivu/view/post_detail_page.dart';

class PostPage extends StatelessWidget {
  final controller = Get.put(PostController());
  PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Posts",
          style: GoogleFonts.ptSans(
            textStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: controller.posts.length,
              itemBuilder: (context, index) {
                var post = controller.posts[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(post.title,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.body,
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.thumb_up, size: 16, color: Colors.green),
                            SizedBox(width: 5),
                            Text(post.likes.toString()),
                            SizedBox(width: 10),
                            Icon(Icons.remove_red_eye,
                                size: 16, color: Colors.blue),
                            SizedBox(width: 5),
                            Text(post.views.toString()),
                          ],
                        )
                      ],
                    ),
                    onTap: () => Get.to(PostDetailPage(post: post)),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
