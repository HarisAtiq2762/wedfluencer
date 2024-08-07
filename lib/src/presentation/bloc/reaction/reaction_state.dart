part of 'reaction_bloc.dart';

sealed class ReactionState extends Equatable {
  const ReactionState();

  @override
  List<Object> get props => [];
}

final class ReactionInitial extends ReactionState {}

final class AddingReaction extends ReactionState {}
