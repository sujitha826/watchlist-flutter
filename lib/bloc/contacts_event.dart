part of 'contacts_bloc.dart';

abstract class ContactsEvent {}

final class FetchContacts extends ContactsEvent {}

final class SortContacts extends ContactsEvent {
  SortContacts(
      {// required this.inputList,
      required this.sortType,
      required this.sortOption,
      required this.currentTabIndex});

  // List<List<ContactModel>> inputList;
  SortTypes sortType;
  SortOptions sortOption;
  int currentTabIndex;
}
