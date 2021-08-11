import 'package:bloc/bloc.dart';

import 'dart:convert';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(SettingsState(device: 'Euro'));

  changeDevice(devise) {
    return emit(state.copyWith(device: devise));
  }

  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState(device: json['Devise']);
  }

  @override
  Map<String, dynamic> toJson(SettingsState state) => {'Devise': state.device};
}
