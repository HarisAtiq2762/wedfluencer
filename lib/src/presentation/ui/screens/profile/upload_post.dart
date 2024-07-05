import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mime/mime.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:video_player/video_player.dart';
import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/models/post/post.dart';
import 'package:wedfluencer/src/presentation/ui/templates/headings.dart';
import 'package:wedfluencer/src/presentation/ui/templates/khairyat_appbar.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../../bloc/post/post_bloc.dart';
import '../../config/helper.dart';
import '../../templates/buttons.dart';
import '../../templates/dividers.dart';
import '../../templates/multiDropdown.dart';
import '../../templates/textfields.dart';

class UploadPostScreen extends StatefulWidget {
  final Post? post;
  final bool isEditPost;

  const UploadPostScreen({super.key, this.post, required this.isEditPost});

  @override
  State<UploadPostScreen> createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen> {
  final title = TextEditingController();
  final location = TextEditingController();
  final tags = TextEditingController();
  final description = TextEditingController();
  ValueItem selectedVendorCategory = const ValueItem(label: '', value: '');
  String fileType = '';
  bool isImagePicked = false;

  late File imageFile;

  late VideoPlayerController _controller;

  void getMedia() async {
    imageFile = await WedfluencerHelper.getMedia();
    setState(() {
      isImagePicked = true;
    });
    fileType = lookupMimeType(imageFile.path)!.split('/').first;
    _controller = VideoPlayerController.file(imageFile)
      ..initialize().then((value) {
        setState(() {});
      });
    _controller.setLooping(false);
  }

  @override
  void initState() {
    if (widget.isEditPost) {
      final post = widget.post!;
      title.text = post.title;
      location.text = post.location;
      description.text = post.description;
      setState(() {
        selectedVendorCategory =
            ValueItem(value: post.category.id, label: post.category.title);
      });

      if (widget.post!.postType == 'Video') {
        _controller = VideoPlayerController.networkUrl(Uri.parse(post.url))
          ..initialize().then((value) {
            setState(() {});
          });
        _controller.setLooping(false);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WedfluencerAppbar.generalAppbar(
          title: widget.isEditPost ? 'Edit Post' : 'Upload Post',
          context: context,
          showBackButton: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerHeadings.generalHeading(heading: 'Post Details'),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.iconTextField(
                controller: title,
                showIcon: false,
                hint: 'Title',
              ),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.iconTextField(
                controller: tags,
                showIcon: false,
                hint: 'HashTags',
              ),
              WedfluencerDividers.transparentDivider(),
              WedfluencerMultiDropdown.vendorServiceDropdown(
                isMulti: false,
                hint: 'Select category',
                category: selectedVendorCategory.label == ''
                    ? null
                    : selectedVendorCategory,
                onOptionSelected: (List<ValueItem> selectedOptions) {
                  selectedVendorCategory = selectedOptions.first;
                },
              ),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.iconTextField(
                controller: location,
                hint: 'Location',
                isGooglePlaces: true,
                showIcon: false,
                showSuffix: false,
              ),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.iconTextField(
                controller: description,
                showIcon: false,
                hint: 'Description',
              ),
              WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerHeadings.generalHeading(heading: 'Post Media'),
              WedfluencerDividers.transparentDivider(),
              InkWell(
                onTap: () => getMedia(),
                child: Center(
                  child: Container(
                    width: ScreenConfig.screenSizeWidth * 0.8,
                    height: ScreenConfig.screenSizeHeight * 0.24,
                    decoration: ShapeDecoration(
                      color: ScreenConfig.theme.colorScheme.secondary
                          .withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: isImagePicked
                        ? fileType == 'video'
                            ? VideoPlayer(_controller)
                            : Image(image: FileImage(imageFile))
                        : widget.isEditPost
                            ? widget.post!.postType == 'Video'
                                ? Image.network(widget.post!.url)
                                : Image.network(widget.post!.url)
                            : Icon(
                                Icons.upload,
                                size: 80,
                                color: ScreenConfig.theme.colorScheme.primary,
                              ),
                  ),
                ),
              ),
              WedfluencerDividers.transparentDividerForHeadings(),
              Center(
                child: BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    if (state is PostLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is UploadPostSuccess) {
                      DI.i<PostBloc>().add(GetPosts(isImage: true, posts: []));
                    }
                    return WedfluencerButtons.fullWidthButton(
                      text: widget.isEditPost ? 'Update' : 'Post',
                      func: () {
                        DI.i<PostBloc>().add(UploadPost(
                            title: title.text.trim(),
                            description: description.text.trim(),
                            categoryId: selectedVendorCategory.value,
                            location: location.text.trim(),
                            hashtags: tags.text.trim(),
                            isVideo: fileType == 'video' ? true : false,
                            file: imageFile,
                            id: widget.isEditPost ? widget.post!.id : '',
                            isEdit: widget.isEditPost));
                      },
                      hasIcon: false,
                      buttonColor: ScreenConfig.theme.primaryColor,
                      textColor: Colors.white,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
