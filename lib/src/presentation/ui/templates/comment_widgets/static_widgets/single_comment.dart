import 'package:flutter/material.dart';
import 'package:wedfluencer/src/infrastructure/constants/font_sizes.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';

import '../../../../../models/comment/comment.dart';

class SingleComment extends StatelessWidget {
  const SingleComment({
    super.key,
    required this.comment,
  });
  final Comment comment;

  String _getTimeAgo(DateTime createdAt) {
    String timeAgo = "Just Now";
    Duration difference = DateTime.now().difference(createdAt);
    if (difference.inDays > 0) {
      timeAgo = "${difference.inDays}d";
    } else if (difference.inHours > 0) {
      timeAgo = "${difference.inHours}h";
    } else if (difference.inMinutes > 5) {
      timeAgo = "${difference.inMinutes}m";
    }
    return timeAgo;
  }

  String _getUserName(String userName) {
    int acceptedLength = 30;
    String acceptedName = userName;
    if (userName.length > acceptedLength) {
      acceptedName = userName.substring(0, 30);
      acceptedName = "$acceptedName...";
    }
    return acceptedName;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6.0,
            horizontal: 15,
          ),
          child: Row(
            children: [
              // const CircleAvatar(
              //   backgroundColor: Colors.grey,
              //   child: Icon(Icons.person, color: Colors.white),
              // ),
              // const SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        _getUserName(
                          comment.userName,
                        ),
                        style: FontSizes.size16SemiBold(),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        _getTimeAgo(comment.createdAt),
                        style: FontSizes.size14Medium(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  SizedBox(
                    width: ScreenConfig.screenSizeWidth * 0.9,
                    child: Text(
                      comment.comment,
                      style: FontSizes.size16Regular(),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  // Row(
                  //   children: [
                  // Text(
                  //   '${comment.} likes',
                  //   style: const TextStyle(color: Colors.grey),
                  // ),
                  // const SizedBox(width: 16.0),
                  if (comment.numberOfReplies != 0)
                    Text(
                      'View ${comment.numberOfReplies} more replies',
                      style: FontSizes.size14Regular(
                        color: Colors.grey,
                      ),
                    ),
                  //   ],
                  // ),
                ],
              ),
              // const Spacer(),
              // const Icon(Icons.favorite_border),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        const Divider(),
      ],
    );
  }
}
