class MenuItem {
  final String title;
  final List<String> subLinks;
  bool isSelected;

  MenuItem({
    required this.title,
    required this.subLinks,
    this.isSelected = false,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      title: json['title'],
      subLinks: List<String>.from(json['subLinks']),
      isSelected: false,
    );
  }
}

class RoleMenu {
  final String roleName;
  final List<MenuItem> transactionLinks;
  final List<MenuItem> reportLinks;
  final List<MenuItem> masterLinks;
  final List<String> miscLinks;

  RoleMenu({
    required this.roleName,
    required this.transactionLinks,
    required this.reportLinks,
    required this.masterLinks,
    required this.miscLinks,
  });

  factory RoleMenu.fromJson(Map<String, dynamic> json) {
    return RoleMenu(
      roleName: json['roleName'],
      transactionLinks:
          (json['transactionLinks'] as List)
              .map((item) => MenuItem.fromJson(item))
              .toList(),
      reportLinks:
          (json['reportLinks'] as List)
              .map((item) => MenuItem.fromJson(item))
              .toList(),
      masterLinks:
          (json['masterLinks'] as List)
              .map((item) => MenuItem.fromJson(item))
              .toList(),
      miscLinks: List<String>.from(json['miscLinks']),
    );
  }
}
