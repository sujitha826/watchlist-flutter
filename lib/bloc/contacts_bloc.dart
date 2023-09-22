import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/contact_model.dart';
import '../repositories/contacts_repo.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  
  ContactsBloc() : super(ContactsLoading()) {
    on<FetchContacts>((event, emit) async {
      emit(ContactsLoading());
      try {
        final watchlist = await ContactsRepository().getUsers();
        print(watchlist);
        final watchlistGroups = _splitContactsIntoSublist(watchlist, 30);
        emit(ContactsLoaded(watchlistGroups));
      } catch (e) {
        emit(ContactsError('Unable to fetch data!!, Please try again'));
      }
    });
  }

  List<List<ContactModel>> _splitContactsIntoSublist(
      List<ContactModel> contacts, int chunkSize) {
    List<List<ContactModel>> sublistFinal = [];
    for (int i = 0; i < contacts.length; i += chunkSize) {
      final endIndex = i + 30;
      final sublist = contacts.sublist(
          i, endIndex > contacts.length ? contacts.length : endIndex);
      sublistFinal.add(sublist);
    }
    return sublistFinal;
  }
}
