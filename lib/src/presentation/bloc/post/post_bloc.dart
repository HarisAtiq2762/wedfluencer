import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../infrastructure/dependency_injection.dart';
import '../../../infrastructure/navigation_service.dart';
import '../../../infrastructure/resources/post/post_repository.dart';
import '../../../models/post/post.dart';

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
  }
}
