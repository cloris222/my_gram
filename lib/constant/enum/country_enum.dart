enum countryType {
  Taiwan(areaCode: "886"),
  China(areaCode: "886"),
  Japan(areaCode: "886"),
  Korea(areaCode: "886"),
  other(areaCode: "");

  final String areaCode;

  const countryType({required this.areaCode});
}
