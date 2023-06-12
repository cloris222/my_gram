import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/http/data/register_preference_choose_data.dart';


final registerPreferenceChooseProvider = StateNotifierProvider<
    registerPreferenceChooseNotifier, RegisterPreferenceChooseData>((ref) {
  return registerPreferenceChooseNotifier();
});

class registerPreferenceChooseNotifier extends StateNotifier<RegisterPreferenceChooseData> {
  registerPreferenceChooseNotifier() : super(RegisterPreferenceChooseData(
      data: {'genderSection':'',
             'sexSection':'',
             'countrySection':''}));

  void updategenderSection(String value) {
    final data = Map<String,String>.from(state.data); // 複製現有的data對象
    data['genderSection'] = value; // 修改genderSection屬性
    state = RegisterPreferenceChooseData(data: data); // 更新state
  }

  void updateSexSection(String value) {
    final data = Map<String,String>.from(state.data);
    data['sexSection'] = value;
    state = RegisterPreferenceChooseData(data: data);
  }

  void updatecountrySection(String value) {
    final data = Map<String,String>.from(state.data);
    data['countrySection'] = value;
    state = RegisterPreferenceChooseData(data: data);
  }

  void reset(){
    final data = {'genderSection':'',
      'sexSection':'',
      'countrySection':''};
    state = RegisterPreferenceChooseData(data: data);
  }
}
