import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/http/data/register_data.dart';

final registerParamProvider =
    StateNotifierProvider<RegisterParamNotifier, RegisterData>((ref) {
  return RegisterParamNotifier();
});

class RegisterParamNotifier extends StateNotifier<RegisterData> {
  RegisterParamNotifier() : super(RegisterData());

  void init() {
    state = RegisterData();
  }

  void setAccountInfo(
      {required String email,
      required String verifyCode,
      required String password}) {
    state = state.copyWith(
        email: email, verifyCode: verifyCode, password: password);
  }

  void setSelfGender(String gender) {
    state = state.copyWith(gender: gender);
  }

  void setPreferGender(String preferGender) {
    state = state.copyWith(preferGender: preferGender);
  }

  void setCountry({required String country, required String areaCode}) {
    state = state.copyWith(country: country, areaCode: areaCode);
  }
}
