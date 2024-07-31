part of 'post_details.dart';

class PostMenuExtension {
  void triggerPostMenuBottomSheet(
    BuildContext context, {
    required Post post,
  }) {
    final bool isBottomSheetExpanded = post.postType == "Video" ? true : false;
    WedfluencerBottomSheets.generalBottomSheet(
      context: context,
      child: Column(
        children: [
          if (isBottomSheetExpanded) ...[
            WedfluencerButtons.transparentButton(
              text: 'Make Feed',
              textColor: Colors.white,
              iconData: Icons.system_update_alt_outlined,
              removeTransparency: true,
              borderColor: ThemeColors().themeDarkColor,
              func: () {
                PostService().makePostToFeed(
                  postId: post.id,
                  postType: post.postType,
                );
              },
            ),
            WedfluencerDividers.staticTransparentDivider(),
          ],
          WedfluencerButtons.transparentButton(
            text: 'Edit',
            iconData: Icons.edit_outlined,
            func: () {
              Navigator.push(
                context,
                WedfluencerHelper.createRoute(
                  page: UploadPostScreen(post: post, isEditPost: true),
                ),
              );
            },
          ),
          WedfluencerDividers.staticTransparentDivider(),
          WedfluencerButtons.transparentButton(
            text: 'Delete',
            textColor: Colors.red,
            iconData: Icons.delete_outline_outlined,
            borderColor: Colors.red,
            func: () {
              DI.i<PostBloc>().add(DeletePost(id: post.id));
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          WedfluencerDividers.staticTransparentDivider(),
        ],
      ),
      height: isBottomSheetExpanded
          ? ScreenConfig.screenSizeHeight * 0.4
          : ScreenConfig.screenSizeHeight * 0.3,
    );
  }
}
