import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:watchlist_flutter_bloc/bloc/contacts_bloc.dart';
import 'package:watchlist_flutter_bloc/models/contact_model.dart';
import 'package:watchlist_flutter_bloc/widgets/tab1_content.dart';
import 'package:watchlist_flutter_bloc/appConstants/constants.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => ContactsScreenState();
}

class ContactsScreenState extends State<ContactsScreen>
    with SingleTickerProviderStateMixin {
  static const _channel = MethodChannel('watchlist/module');
  static const _methodName = 'helloFromAndroid';
  List<List<ContactModel>> contacts = [];
  List<List<ContactModel>> sorted = [];
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _channel.setMethodCallHandler(_platformCallHandler);
    // call API here
    BlocProvider.of<ContactsBloc>(context).add(FetchContacts());
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
      print("Selected tab index: $_currentIndex");
    });
  }

  Future<String> _platformCallHandler(MethodCall call) async {
    switch (call.method) {
      case _methodName:
        return "Hello from Flutter";
      default:
        return "";
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(96, 104, 58, 183),
              title: Text(
                AppConstants.title,
                style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              leading: const Padding(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Icon(
                  Icons.people,
                  size: 30,
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
                      width: 4.0, // Thickness of the underline
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

                  // print(sorted[0][0].name);
                  // return TabBarView(
                  //   controller: _tabController,
                  //   children: [
                  //     BlocProvider.value(
                  //       value: BlocProvider.of<ContactsBloc>(context),
                  //       child: Tab1(
                  //           contacts: sorted[0],
                  //           // allList : contacts,
                  //           currentTab: 0),
                  //     ),
                  //     BlocProvider.value(
                  //       value: BlocProvider.of<ContactsBloc>(context),
                  //       child: Tab1(
                  //           contacts: sorted[1],
                  //           // allList : contacts,
                  //           currentTab: 1),
                  //     ),
                  //     BlocProvider.value(
                  //       value: BlocProvider.of<ContactsBloc>(context),
                  //       child: Tab1(
                  //           contacts: sorted[2],
                  //           // allList : contacts,
                  //           currentTab: 2),
                  //     ),
                  //   ],
                  // );
                  return BlocProvider.value(
                    value: BlocProvider.of<ContactsBloc>(context),
                    child: Tab1(
                        contacts: sorted[_currentIndex],
                        currentTab: _currentIndex),
                  );
                }
                if (state is ContactsError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.errorMessage,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(83, 223, 64, 251),
                            ),
                          ),
                          onPressed: () {
                            // Add retry logic here
                            context.read<ContactsBloc>().add(FetchContacts());
                          },
                          child: Text(
                            AppConstants.retry,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 37, 21, 63),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container(
                  decoration: BoxDecoration(color: Colors.grey.shade300),
                  child: Text(AppConstants.noContent),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
