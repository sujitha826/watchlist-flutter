import 'package:flutter/material.dart';
import 'package:watchlist_flutter_bloc/models/contact_model.dart';

class Tab1 extends StatefulWidget {
  const Tab1({super.key, required this.contacts});

  final List<ContactModel> contacts;

  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  @override
  Widget build(BuildContext context) {
    print(widget.contacts);
    return Container(
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
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: imageBox(
                        100,
                        100,
                        Image.asset('assets/personn.jpg'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget imageBox(double height, double width, Image image) {
  return SizedBox(height: height, width: width, child: image);
}
