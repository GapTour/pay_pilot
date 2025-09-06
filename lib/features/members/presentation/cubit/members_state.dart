part of 'members_cubit.dart';

enum MembersStatus { initial, loading, success, failure }

@immutable
class MembersState extends Equatable {
  final MembersStatus membersStatus;
  final List<Member> members;

  const MembersState({required this.membersStatus, required this.members});

  @override
  List<Object?> get props => [membersStatus, members];

  MembersState copyWith({MembersStatus? membersStatus, List<Member>? members}) {
    return MembersState(
      membersStatus: membersStatus ?? this.membersStatus,
      members: members ?? this.members,
    );
  }
}
