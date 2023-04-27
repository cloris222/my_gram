enum countryType { Taiwan, China, Japan,Korea,other }

countryType getcountryType(String country) {
  switch (country) {
    case "Taiwan":
      return countryType.Taiwan;
    case "China":
      return countryType.China;
    case "Japan":
      return countryType.Japan;
    case "Korea":
      return countryType.Korea;
    default:
      return countryType.other;
  }
}

extension CountryTypeExtension on countryType {
  String getcountryTypeValue() {
    switch (this) {
      case countryType.Taiwan:
        return "Taiwan";
      case countryType.China:
        return "China";
      case countryType.Japan:
        return "Japan";
      case countryType.Korea:
        return "Korea";
      default:
        return "other";
    }
  }
}

