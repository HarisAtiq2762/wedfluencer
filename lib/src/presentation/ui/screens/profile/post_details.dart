import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/auth_repository.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/bloc/post/post_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/screens/profile/upload_post.dart';
import 'package:wedfluencer/src/presentation/ui/templates/bottomsheets.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';

import '../../../../models/post/post.dart';
import '../../config/helper.dart';
import '../../templates/buttons.dart';

class PostDetails extends StatelessWidget {
  final Post post;

  const PostDetails({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    displayIconsWithCount(
            {required String iconName,
            required String count,
            bool isInverted = false}) =>
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotatedBox(
                quarterTurns: isInverted ? 2 : 0,
                child: SvgPicture.asset(
                  'assets/svg/$iconName.svg',
                  semanticsLabel: iconName,
                  color: Colors.black,
                  width: 20,
                ),
              ),
              // Icon(icon, size: 22),
              Text('  $count', style: ScreenConfig.theme.textTheme.titleSmall)
            ],
          ),
        );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: ScreenConfig.screenSizeWidth * 0.83,
                child: Text(
                  post.title,
                  style: ScreenConfig.theme.textTheme.titleLarge,
                ),
              ),
              IconButton(
                  onPressed: () {
                    WedfluencerBottomSheets.generalBottomSheet(
                      context: context,
                      child: Column(
                        children: [
                          WedfluencerButtons.transparentButton(
                            text: 'Edit',
                            iconData: Icons.edit_outlined,
                            func: () {
                              Navigator.push(
                                context,
                                WedfluencerHelper.createRoute(
                                  page: UploadPostScreen(
                                      post: post, isEditPost: true),
                                ),
                              );
                            },
                          ),
                          WedfluencerDividers.transparentDivider(),
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
                          WedfluencerDividers.transparentDivider(),
                        ],
                      ),
                      height: ScreenConfig.screenSizeHeight * 0.3,
                    );
                  },
                  icon: const Icon(Icons.more_horiz_outlined)),
            ],
          ),
        ),
        CachedNetworkImage(
          imageUrl: post.url,
          fit: BoxFit.cover,
          width: ScreenConfig.screenSizeWidth,
          errorWidget: (context, _, __) {
            return Image.asset(
              'assets/logos/logo.png',
              fit: BoxFit.contain,
              width: ScreenConfig.screenSizeWidth,
              height: ScreenConfig.screenSizeHeight * 0.6,
            );
          },
        ),
        // Image.network(
        //   post.url,
        //   fit: BoxFit.cover,
        //   width: ScreenConfig.screenSizeWidth,
        //   errorBuilder: (context, _, __) {
        //     return Image.asset(
        //       'assets/logos/logo.png',
        //       fit: BoxFit.contain,
        //       width: ScreenConfig.screenSizeWidth,
        //       height: ScreenConfig.screenSizeHeight * 0.6,
        //     );
        //   },
        // ),
        WedfluencerDividers.transparentDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  displayIconsWithCount(
                    iconName: 'like',
                    count: '${post.numberOfLikes}',
                  ),
                  displayIconsWithCount(
                    iconName: 'like',
                    isInverted: true,
                    count: '${post.numberOfDislikes}',
                  ),
                  displayIconsWithCount(
                    iconName: 'comment',
                    count: '${post.numberOfComments}',
                  ),
                  displayIconsWithCount(
                    iconName: 'view',
                    count: '${post.numberOfViews}',
                  ),
                  const Spacer(),
                  displayIconsWithCount(
                    iconName: 'share',
                    count: '${post.numberOfShares}',
                  ),
                ],
              ),
              WedfluencerDividers.transparentDivider(),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: ScreenConfig.theme.textTheme.titleMedium,
                  children: <TextSpan>[
                    TextSpan(
                      text: DI.i<AuthRepository>().user!.getFullName,
                      style: ScreenConfig.theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: post.description,
                      style: ScreenConfig.theme.textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
      ],
    );
  }
}
