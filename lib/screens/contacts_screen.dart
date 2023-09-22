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

class ContactsScreenState extends State<ContactsScreen> {
  List<List<ContactModel>> contacts = [];

  @override
  void initState() {
    // call API here
    BlocProvider.of<ContactsBloc>(context).add(FetchContacts());
    super.initState();
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
                backgroundColor: Theme.of(context).colorScheme.onSecondary,
                title: const Text('WatchList'),
                leading: const Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
                bottom: const TabBar(
                  tabs: [
                    Tab(
                      child: Text(
                        'Contacts 1',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Contacts 2',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Contacts 3',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                  indicator: BoxDecoration(
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
              body: BlocBuilder<ContactsBloc, ContactsState>(
                builder: (context, state) {
                  if (state is ContactsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ContactsLoaded) {
                    contacts = state.users;
                    print(contacts);
                    return TabBarView(
                      children: [
                        BlocProvider.value(
                          value: BlocProvider.of<ContactsBloc>(context),
                          child: Tab1(contacts: contacts[0]),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<ContactsBloc>(context),
                          child: Tab1(contacts: contacts[1]),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<ContactsBloc>(context),
                          child: Tab1(contacts: contacts[2]),
                        ),
                      ],
                    );
                  }
                  if (state is ContactsError) {
                    // retry here
                    return const Center(
                      child: Text('Unable to fetch data, Please try again!!'),
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
