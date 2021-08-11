part of 'settings_cubit.dart';

class SettingsState {
  String? device;
  SettingsState({
    this.device,
  });

  SettingsState copyWith({
    String? device,
  }) {
    return SettingsState(
      device: device ?? this.device,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'device': device,
    };
  }

  factory SettingsState.fromMap(Map<String, dynamic> map) {
    return SettingsState(
      device: map['device'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsState.fromJson(String source) =>
      SettingsState.fromMap(json.decode(source));

  @override
  String toString() => 'SettingsState(device: $device)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingsState && other.device == device;
  }

  @override
  int get hashCode => device.hashCode;
}
