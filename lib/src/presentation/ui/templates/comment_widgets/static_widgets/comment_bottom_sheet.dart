// comment_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/bloc/comment/comment_service.dart';
import 'package:wedfluencer/src/presentation/ui/templates/custom_widgets/height_spacer.dart';

import '../../../../../infrastructure/constants/font_sizes.dart';
import '../../../../../infrastructure/constants/spaces.dart';
import '../../custom_widgets/bottom_model_widgets/dash_display.dart';
import '../state_widgets/comment_bloc_wrapped_list.dart';

class CommentBottomSheet extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  CommentBottomSheet({
    super.key,
    required this.postId,
  });
  final String postId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: ScreenConfig.screenSizeHeight * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            const DashDisplay(),
            HeightSpacer(
              space: Spaces.smallestSpacingVertical * 2,
            ),
            Text(
              'Comments',
              style: FontSizes.size16SemiBold(),
            ),
            HeightSpacer(
              space: Spaces.smallestSpacingVertical * 2,
            ),
            const CommentBlocWrappedList(),
            Column(
              children: [
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 6.0,
                    left: 15,
                    right: 15,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Add a comment...',
                            border: InputBorder.none,
                            hintStyle: FontSizes.size14Medium(),
                          ),
                          style: FontSizes.size14Medium(),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (_controller.text.isNotEmpty) {
                            CommentService().sendComment(
                              postId: postId,
                              comment: _controller.text,
                            );
                            _controller.clear();
                          }
                        },
                        child: const Icon(
                          Icons.send,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
