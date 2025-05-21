// ignore_for_file: non_constant_identifier_names

class DomainSelection {
  DomainSelection({
    this.domainType,
    this.domain,
  });

  DomainSelection.fromJson(dynamic json) {
    domainType = json['title'];
    domain = json['title2'];
  }
  String? domainType;
  String? domain;
}

List<DomainSelection> all_domains = [
  DomainSelection(
    domainType: 'Management Team',
    domain: 'www.trl.management-team.com',
  ),
  DomainSelection(
    domainType: 'Operation Team',
    domain: "www.trl.operation-team.com",
  ),
  DomainSelection(
    domainType: 'General Stuffs',
    domain: 'www.trl.general-stuffs.com',
  ),
  DomainSelection(
    domainType: 'Public Domain',
    domain: "www.trl.public-domain.com",
  ),
];
