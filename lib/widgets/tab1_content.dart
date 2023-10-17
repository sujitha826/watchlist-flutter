import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:watchlist_flutter_bloc/models/contact_model.dart';
import 'package:watchlist_flutter_bloc/bloc/contacts_bloc.dart';
import 'package:watchlist_flutter_bloc/models/enums.dart';
import 'package:watchlist_flutter_bloc/appConstants/constants.dart';

class Tab1 extends StatefulWidget {
  const Tab1({
    super.key,
    required this.contacts,
    required this.currentTab,
    // required this.allList,
  });

  final List<ContactModel> contacts;
  final int currentTab;

  // final List<List<ContactModel>> allList;

  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  SortOptions _selectedSortOption = SortOptions.alphabetic;
  SortTypes _selectedSortType = SortTypes.asc;

  @override
  Widget build(BuildContext context) {
    print(widget.currentTab);
    // print(widget.contacts[0].name);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.grey.shade300),
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: widget.contacts.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white,
                elevation: 4,
                child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          child: Text(
                            widget.contacts[index].name.toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            const Icon(Icons.phone),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(widget.contacts[index].contacts),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: imageBox(
                        100,
                        100,
                        Image.asset('assets/personn.jpg'),
                      ),
                      // child: newImageBox(80, 80)
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        //add sort icon button here
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 320,
              right: 8,
            ),
            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                ),
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return BlocConsumer<ContactsBloc, ContactsState>(
                          listener: (context, state) {
                            if (state is ContactsSorted) {
                              _selectedSortOption = state.selectedSortOption;
                              _selectedSortType = state.selectedSortType;
                            }
                          },
                          builder: (context, state) {
                            return SizedBox(
                              height: 250,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 20, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            AppConstants.sortBy,
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16.0),
                                            child: Text(
                                              AppConstants.done,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ListTile(
                                    title: Row(
                                      children: [
                                        Text(
                                          AppConstants.alphabetic,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 55,
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              context
                                                  .read<ContactsBloc>()
                                                  .add(SortContacts(
                                                    // inputList: widget.allList,
                                                    sortOption:
                                                        SortOptions.alphabetic,
                                                    sortType: SortTypes.asc,
                                                    currentTabIndex:
                                                        widget.currentTab,
                                                  ));
                                            },
                                            child: Text(
                                              AppConstants.aToZ,
                                              style: TextStyle(
                                                  color: _selectedSortOption ==
                                                              SortOptions
                                                                  .alphabetic &&
                                                          _selectedSortType ==
                                                              SortTypes.asc
                                                      ? Colors.blue
                                                      : Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        TextButton(
                                          onPressed: () {
                                            context
                                                .read<ContactsBloc>()
                                                .add(SortContacts(
                                                  // inputList: widget.allList,
                                                  sortOption:
                                                      SortOptions.alphabetic,
                                                  sortType: SortTypes.dsc,
                                                  currentTabIndex:
                                                      widget.currentTab,
                                                ));
                                          },
                                          child: Text(
                                            AppConstants.zToA,
                                            style: TextStyle(
                                                color: _selectedSortOption ==
                                                            SortOptions
                                                                .alphabetic &&
                                                        _selectedSortType ==
                                                            SortTypes.dsc
                                                    ? Colors.blue
                                                    : Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                  ListTile(
                                    title: Row(
                                      children: [
                                        Text(
                                          AppConstants.numeric,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 65,
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              context
                                                  .read<ContactsBloc>()
                                                  .add(SortContacts(
                                                    // inputList: widget.allList,
                                                    sortOption:
                                                        SortOptions.numeric,
                                                    sortType: SortTypes.asc,
                                                    currentTabIndex:
                                                        widget.currentTab,
                                                  ));
                                            },
                                            child: Text(
                                              AppConstants.zeroToNine,
                                              style: TextStyle(
                                                  color: _selectedSortOption ==
                                                              SortOptions
                                                                  .numeric &&
                                                          _selectedSortType ==
                                                              SortTypes.asc
                                                      ? Colors.blue
                                                      : Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        TextButton(
                                          onPressed: () {
                                            context
                                                .read<ContactsBloc>()
                                                .add(SortContacts(
                                                  // inputList: widget.allList,
                                                  sortOption:
                                                      SortOptions.numeric,
                                                  sortType: SortTypes.dsc,
                                                  currentTabIndex:
                                                      widget.currentTab,
                                                ));
                                          },
                                          child: Text(
                                            AppConstants.nineToZero,
                                            style: TextStyle(
                                                color: _selectedSortOption ==
                                                            SortOptions
                                                                .numeric &&
                                                        _selectedSortType ==
                                                            SortTypes.dsc
                                                    ? Colors.blue
                                                    : Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      // Handle User ID sorting action
                                      Navigator.pop(context);
                                    },
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.sort),
                  color: Colors.blue,
                  iconSize: 40,
                )),
          ),
        ),
      ],
    );
  }
}

Widget imageBox(double height, double width, Image image) {
  return SizedBox(height: height, width: width, child: image);
}

Widget newImageBox(
  double height,
  double width,
) {
  return Container(
    height: height,
    width: width,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage('assets/personn.jpg'),
      ),
    ),
  );
}
