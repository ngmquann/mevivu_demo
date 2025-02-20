import 'package:flutter/material.dart';
import 'package:test1_mevivu/model/post.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;
  const PostDetailPage({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(post.body, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: post.tags.map((tag) => Chip(label: Text(tag))).toList(),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.thumb_up, color: Colors.green),
                SizedBox(width: 5),
                Text(post.likes.toString()),
                SizedBox(width: 10),
                Icon(Icons.thumb_down, color: Colors.red),
                SizedBox(width: 5),
                Text(post.dislikes.toString()),
                SizedBox(width: 10),
                Icon(Icons.remove_red_eye, color: Colors.blue),
                SizedBox(width: 5),
                Text(post.views.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
