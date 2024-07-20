import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/resources/helper_services/response_popup_service.dart';

import '../../../infrastructure/dependency_injection.dart';
import '../../../infrastructure/navigation_service.dart';
import '../../../infrastructure/resources/helper_services/loader_service.dart';
import '../../../infrastructure/resources/post/post_repository.dart';
import '../../../models/post/post.dart';
import '../../ui/config/constants.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final repository = PostRepository();

  PostBloc() : super(PostInitial()) {
    on<UploadPost>((event, emit) async {
      emit(PostLoading());
      try {
        final result = await repository.uploadPost(
            title: event.title,
            file: event.file,
            description: event.description,
            hashtags: event.hashtags,
            categoryId: event.categoryId,
            location: event.location,
            isVideo: event.isVideo,
            isEdit: event.isEdit,
            id: event.id);
        emit(UploadPostSuccess());
        DI.i<NavigationService>().showSnackBar(message: 'Posted !');
      } catch (e) {
        DI.i<NavigationService>().showSnackBar(message: e.toString());
        emit(PostError(error: e.toString()));
        emit(PostInitial());
      }
    });

    on<GetPosts>((event, emit) async {
      try {
        emit(PostLoading());
        final posts = await repository.getPosts(isImage: event.isImage);
        emit(GotPosts(posts: posts, isImage: event.isImage));
      } catch (e) {
        emit(PostError(error: e.toString()));
        emit(PostInitial());
      }
    });

    on<DeletePost>((event, emit) async {
      try {
        final result = await repository.deletePost(id: event.id);
        if (result) {
          emit(PostDeleted());
          DI
              .i<NavigationService>()
              .showSnackBar(message: 'Post has been deleted');
        }
      } catch (e) {
        emit(PostError(error: e.toString()));
        emit(PostInitial());
      }
    });

    on<ConvertPostToFeed>((event, emit) async {
      final bool isPostImage = event.postType == "Image" ? true : false;
      try {
        LoaderService.setContextSafeLoader(
          startLoader: true,
          loaderKeyForBloc: 'convertingPostToFeed',
        );
        final bool isConvertionSuccessful = await repository.makeFeed(
          postId: event.postId,
        );
        if (isConvertionSuccessful) {
          emit(PostConvertedToFeed());
          final posts = await repository.getPosts(isImage: isPostImage);
          emit(
            GotPosts(
              posts: posts,
              isImage: isPostImage,
            ),
          );
          LoaderService.setContextSafeLoader(
            startLoader: false,
            loaderKeyForBloc: 'convertingPostToFeed',
          );
          ResponsePopUpService.showVerificationSuccessfullPopUp(
              heading: 'Feed Successful',
              message: 'Please check your post in the feed section',
              buttonText: 'Continue',
              buttonFunction: () {
                Navigator.pop(DI.i<NavigationService>().getContext());
                Navigator.pop(DI.i<NavigationService>().getContext());
              });
        } else {
          throw 'Error Occured';
        }
      } catch (e) {
        LoaderService.setContextSafeLoader(
          startLoader: false,
          loaderKeyForBloc: 'convertingPostToFeed',
        );
        ResponsePopUpService.showVerificationFailedPopUp(
            heading: 'Error updating post',
            message: WedfluencerConstants.errorMessage,
            buttonFunction: () {
              Navigator.pop(DI.i<NavigationService>().getContext());
              Navigator.pop(DI.i<NavigationService>().getContext());
            });
      }
    });
  }
}
