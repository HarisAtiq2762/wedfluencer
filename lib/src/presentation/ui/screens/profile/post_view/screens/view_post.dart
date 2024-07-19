import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/screens/profile/post_view/widgets/static_widgets/post_details.dart';
import 'package:wedfluencer/src/presentation/ui/templates/khairyat_appbar.dart';

import '../../../../../../models/post/post.dart';

class ViewPostScreen extends StatelessWidget {
  final Post selectedPost;
  final List<Post> posts;

  const ViewPostScreen(
      {super.key, required this.selectedPost, required this.posts});

  @override
  Widget build(BuildContext context) {
    posts.remove(selectedPost);
    posts.insert(0, selectedPost);
    return Scaffold(
      appBar: WedfluencerAppbar.generalAppbar(title: 'Posts', context: context),
      body: ListView.builder(
          itemCount: posts.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final post = posts[index];
            return PostDetails(post: post);
          }),
    );
  }
}
