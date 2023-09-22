part of 'contacts_bloc.dart';

abstract class ContactsState {}

final class ContactsInitial extends ContactsState {}

final class ContactsLoading extends ContactsState {}

final class ContactsLoaded extends ContactsState {
  final List<List<ContactModel>> users;

  ContactsLoaded(this.users);
}

class ContactsError extends ContactsState {
  final String errorMessage;

  ContactsError(this.errorMessage);
}
