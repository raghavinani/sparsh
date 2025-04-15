class MenuItem {
  final String title;
  final List<String> subLinks;

  MenuItem({required this.title, required this.subLinks});
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
}
