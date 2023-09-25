part of 'contacts_bloc.dart';

abstract class ContactsState {}

final class ContactsInitial extends ContactsState {}

final class ContactsLoading extends ContactsState {}

final class ContactsLoaded extends ContactsState {
  final List<List<ContactModel>> users;

  ContactsLoaded(this.users);
}

final class ContactsError extends ContactsState {
  final String errorMessage;

  ContactsError(this.errorMessage);
}

final class ContactsSorted extends ContactsState {
  final List<List<ContactModel>> sortedUsers;
  final SortTypes selectedSortType;
  final SortOptions selectedSortOption;
  final int indexTab;

  ContactsSorted(
      {required this.sortedUsers,
      required this.selectedSortOption,
      required this.selectedSortType,
      required this.indexTab});
}
