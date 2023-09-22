class ContactModel {
  final String id;
  final String name;
  final String contacts;
  String? url;

  ContactModel(
      {required this.id, required this.name, required this.contacts, this.url});

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
        id: json['id'],
        name: json['name'] ?? 'First Name',
        contacts: json['Contacts'] ?? '7904696681',
        url: json['url']);
  }
}
