import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:wedfluencer/src/infrastructure/resources/user/user_repository.dart';
import 'package:wedfluencer/src/models/referral_code.dart';

part 'create_proposal_event.dart';
part 'create_proposal_state.dart';

class CreateProposalBloc
    extends Bloc<CreateProposalEvent, CreateProposalState> {
  final repository = UserRepository();

  CreateProposalBloc() : super(CreateProposalInitial()) {
    on<GetCreateProposalDetails>((event, emit) async {
      emit(CreateProposalLoading());
      try {
        emit(CreateProposalDetailsProvided(
          title: event.title,
          weddingLocation: event.weddingLocation,
          isInWeddingShow: event.isInWeddingShow,
          referralCode: event.referralCode,
          weddingShowDate: event.weddingShowDate,
          weddingShowName: event.weddingShowName,
          vendorCategories: event.vendorCategories,
          eventId: event.eventId,
        ));
        // final result =
        // await repository.getVendorServicesOrCategories(isService: true);
        // emit(GotVendorService(vendorServices: result));
      } catch (e) {
        emit(CreateProposalError(error: e.toString()));
        emit(CreateProposalInitial());
      }
    });

    on<UploadCreateProposalVideo>((event, emit) async {
      emit(CreateProposalLoading());
      try {
        final result = await repository.uploadProposalVideo(
            video: event.file,
            title: event.title,
            description: event.description);
        emit(CreateProposalVideoUploaded(
          videoId: result,
          isInWeddingShow: event.isInWeddingShow,
          title: event.title,
          weddingShowName: event.weddingShowName,
          weddingShowDate: event.weddingShowDate,
          referralCode: event.referralCode,
          weddingLocation: event.weddingLocation,
          vendorCategories: event.vendorCategories,
          eventId: event.eventId,
        ));
        // emit(CreateProposalInitial());
      } catch (e) {
        emit(CreateProposalError(error: e.toString()));
        emit(CreateProposalInitial());
      }
    });

    on<UploadCreateProposalDetails>((event, emit) async {
      emit(CreateProposalLoading());
      try {
        final result = await repository.uploadProposalDetails(
            videoId: event.videoId,
            categoryIds: event.categoryIds,
            title: event.title,
            eventId: event.eventId,
            accessToken: event.accessToken);
        emit(CreateProposalDetailsUploaded());
        emit(CreateProposalInitial());
      } catch (e) {
        emit(CreateProposalError(error: e.toString()));
        emit(CreateProposalInitial());
      }
    });

    on<VerifyReferralCode>((event, emit) async {
      emit(CreateProposalLoading());
      try {
        final result = await repository.verifyReferralCode(
            referralCode: event.referralCode);
        emit(ReferralCodeVerified(referralCode: result));
        // emit(CreateProposalInitial());
      } catch (e) {
        emit(CreateProposalError(error: e.toString()));
        emit(CreateProposalInitial());
      }
    });
  }
}
