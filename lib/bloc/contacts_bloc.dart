import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/contact_model.dart';
import '../repositories/contacts_repo.dart';
import 'package:watchlist_flutter_bloc/models/enums.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(ContactsLoading()) {
    on<FetchContacts>((event, emit) async {
      emit(ContactsLoading());
      try {
        final watchlist = await ContactsRepository().getUsers();
        // print(watchlist);
        final watchlistGroups = _splitContactsIntoSublist(watchlist, 30);
        emit(ContactsLoaded(watchlistGroups));
        emit(ContactsSorted(
            sortedUsers: watchlistGroups,
            selectedSortOption: SortOptions.alphabetic,
            selectedSortType: SortTypes.asc,
            indexTab: 0));
      } catch (e) {
        emit(ContactsError('Unable to fetch data!!, Please try again'));
      }
    });

    on<SortContacts>((event, emit) async {
      print('event fired');
      emit(ContactsLoading());
      try {
        final listSorted = _sortContacts(allUsersList, event.sortType,
            event.sortOption, event.currentTabIndex);
        emit(ContactsSorted(
            sortedUsers: listSorted,
            selectedSortOption: event.sortOption,
            selectedSortType: event.sortType,
            indexTab: event.currentTabIndex));
      } catch (e) {
        emit(ContactsError('Unable to Sort contacts!!, Please try again'));
      }
    });
  }
  List<List<ContactModel>> allUsersList = [];

  List<List<ContactModel>> _splitContactsIntoSublist(
      List<ContactModel> contacts, int chunkSize) {
    List<List<ContactModel>> sublistFinal = [];
    for (int i = 0; i < contacts.length; i += chunkSize) {
      final endIndex = i + 30;
      final sublist = contacts.sublist(
          i, endIndex > contacts.length ? contacts.length : endIndex);
      sublistFinal.add(sublist);
    }
    allUsersList = sublistFinal;
    return sublistFinal;
  }

//   List<List<ContactModel>> _sortContacts(List<List<ContactModel>> input,
//       SortTypes type, SortOptions option, int index) {
//     print('inside sort method');
//     print(index);
//     List<List<ContactModel>> sortedList = List.from(input);

//     if (option == SortOptions.alphabetic) {
//       if (type == SortTypes.asc) {
//         sortedList.map((e) {
//           if (index == sortedList.indexOf(e)) {
//             return e..sort((a, b) => a.name.compareTo(b.name));
//           } else {
//             return e;
//           }
//         });
//       } else {
//         sortedList.map((e) {
//           if (index == sortedList.indexOf(e)) {
//             return e..sort((a, b) => b.name.compareTo(a.name));
//           } else {
//             return e;
//           }
//         });
//         print(sortedList[0][0].name);
//       }
//     } else if (option == SortOptions.numeric) {
//       if (type == SortTypes.asc) {
//         sortedList.map((e) {
//           if (index == sortedList.indexOf(e)) {
//             return e
//               ..sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
//           } else {
//             return e;
//           }
//         });
//       } else {
//         sortedList.map((e) {
//           if (index == sortedList.indexOf(e)) {
//             return e
//               ..sort((a, b) => int.parse(b.id).compareTo(int.parse(a.id)));
//           } else {
//             return e;
//           }
//         });
//       }
//     }
//     return sortedList;
//   }

  List<List<ContactModel>> _sortContacts(List<List<ContactModel>> input,
      SortTypes type, SortOptions option, int index) {
    // print('inside sort method');
    List<List<ContactModel>> sortedList = List.from(input);

    if (option == SortOptions.alphabetic) {
      if (type == SortTypes.asc) {
        // sortedList[index].sort((a, b) => a.name.compareTo(b.name));
        sortedList[index].sort((a, b) {
          final numericA = int.tryParse(a.name.split(' ').last) ?? 0;
          final numericB = int.tryParse(b.name.split(' ').last) ?? 0;
          return numericA.compareTo(numericB);
        });
      } else {
        // sortedList[index].sort((a, b) => b.name.compareTo(a.name));
        sortedList[index].sort((a, b) {
          final numericA = int.tryParse(a.name.split(' ').last) ?? 0;
          final numericB = int.tryParse(b.name.split(' ').last) ?? 0;
          return numericB.compareTo(numericA);
        });
        print(sortedList[0][0].name);
      }
    } else if (option == SortOptions.numeric) {
      if (type == SortTypes.asc) {
        sortedList[index]
            .sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
      } else {
        sortedList[index]
            .sort((a, b) => int.parse(b.id).compareTo(int.parse(a.id)));
      }
    }
    return sortedList;
  }
}
