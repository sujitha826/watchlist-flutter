import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:watchlist_flutter_bloc/bloc/contacts_bloc.dart';
import 'package:watchlist_flutter_bloc/models/contact_model.dart';
import 'package:watchlist_flutter_bloc/widgets/tab1_content.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => ContactsScreenState();
}

class ContactsScreenState extends State<ContactsScreen>
    with SingleTickerProviderStateMixin {
  List<List<ContactModel>> contacts = [];
  List<List<ContactModel>> sorted = [];
  late TabController _tabController;

  @override
  void initState() {
    // call API here
    BlocProvider.of<ContactsBloc>(context).add(FetchContacts());
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          body: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                title: Text(
                  'Contacts List',
                  style: TextStyle(
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
                ),
                leading: const Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                  ),
                  child: Icon(
                    Icons.people,
                  ),
                ),
                bottom: TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      child: Text(
                        'Group 1',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Group 2',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Group 3',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                  indicator: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color:
                            Colors.blue, // Color of the underline when selected
                        width: 3.0, // Thickness of the underline
                      ),
                    ),
                  ),
                  labelColor: Colors.black,
                ),
              ),
              body: BlocConsumer<ContactsBloc, ContactsState>(
                listener: (context, state) {
                  if (state is ContactsLoaded) {
                    contacts = state.users;
                  }
                },
                builder: (context, state) {
                  if (state is ContactsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ContactsSorted) {
                    sorted = state.sortedUsers;
                    print(sorted[0][0].name);
                    return TabBarView(
                      controller: _tabController,
                      children: [
                        BlocProvider.value(
                          value: BlocProvider.of<ContactsBloc>(context),
                          child: Tab1(
                              contacts: sorted[0],
                              allList : contacts,
                              currentTab: 0),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<ContactsBloc>(context),
                          child: Tab1(
                              contacts: sorted[1],
                              allList : contacts,
                              currentTab: 1),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<ContactsBloc>(context),
                          child: Tab1(
                              contacts: sorted[2],
                              allList : contacts,
                              currentTab: 2),
                        ),
                      ],
                    );
                  }
                  if (state is ContactsError) {
                    // retry here
                    return Center(
                      child: Text(state.errorMessage),
                    );
                  }
                  return Container(
                    decoration: BoxDecoration(color: Colors.grey.shade300),
                    child: const Text(
                        'Something went wrong!!, Please try after a while.'),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
