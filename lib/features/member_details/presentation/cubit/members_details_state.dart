part of 'members_details_cubit.dart';

@immutable
class MembersDetailsState extends Equatable {
  final MembersStatus membersStatus;

  const MembersDetailsState({required this.membersStatus});

  @override
  List<Object?> get props => [membersStatus];

  MembersDetailsState copyWith({MembersStatus? membersStatus}) {
    return MembersDetailsState(
      membersStatus: membersStatus ?? this.membersStatus,
    );
  }
}
