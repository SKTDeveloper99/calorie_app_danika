import 'dart:io';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class HealthDataUtil {
  final Health _health = Health();

  HealthDataUtil() {
    // Configure the health plugin before use.
    _health.configure(useHealthConnectIfAvailable: true);
  }
  // Define the data types for Android and iOS
  List<HealthDataType> get dataTypesAndroid => [
        HealthDataType.STEPS,
        HealthDataType.ACTIVE_ENERGY_BURNED,
        HealthDataType.BASAL_ENERGY_BURNED,
        // HealthDataType.STAND_HOURS,
        HealthDataType.EXERCISE_TIME,
        // Add more types as needed
      ];

  List<HealthDataType> get dataTypesIOS => [
        HealthDataType.STEPS,
        HealthDataType.ACTIVE_ENERGY_BURNED,
        HealthDataType.BASAL_ENERGY_BURNED,
        // HealthDataType.STAND_HOURS,
        HealthDataType.EXERCISE_TIME,
        // Add more types as needed
      ];

  List<HealthDataType> get types => (Platform.isAndroid)
      ? dataTypesAndroid
      : (Platform.isIOS)
          ? dataTypesIOS
          : [];

  List<HealthDataAccess> get permissions =>
      types.map((e) => HealthDataAccess.READ).toList();

  Future<bool> authorize() async {
    await Permission.activityRecognition.request();
    await Permission.location.request();

    bool? hasPermissions =
        await _health.hasPermissions(types, permissions: permissions);

    hasPermissions = false;

    bool authorized = false;
    if (!hasPermissions) {
      try {
        authorized =
            await _health.requestAuthorization(types, permissions: permissions);
      } catch (error) {
        print("Exception in authorize: $error");
      }
    }
    return authorized;
  }

  Future<List<HealthDataPoint>> fetchData() async {
    final now = DateTime.now();
    final yesterday = now.subtract(Duration(hours: 24));
    List<HealthDataPoint> healthDataList = [];

    try {
      List<HealthDataPoint> healthData = await _health.getHealthDataFromTypes(
        types: types,
        startTime: yesterday,
        endTime: now,
      );
      healthDataList = _health.removeDuplicates(healthData);
    } catch (error) {
      print("Exception in getHealthDataFromTypes: $error");
    }

    return healthDataList;
  }

  Future<int> fetchStepData() async {
    int? steps;
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    bool stepsPermission =
        await _health.hasPermissions([HealthDataType.STEPS]) ?? false;
    if (!stepsPermission) {
      stepsPermission =
          await _health.requestAuthorization([HealthDataType.STEPS]);
    }

    if (stepsPermission) {
      try {
        steps = await _health.getTotalStepsInInterval(midnight, now);
      } catch (error) {
        print("Exception in getTotalStepsInInterval: $error");
      }
    } else {
      print("Authorization not granted - error in authorization");
    }

    return steps ?? 0;
  }

  Future<void> revokeAccess() async {
    try {
      await _health.revokePermissions();
    } catch (error) {
      print("Exception in revokeAccess: $error");
    }
  }

  Future<void> installHealthConnect() async {
    await _health.installHealthConnect();
  }

  Future<HealthConnectSdkStatus?> getHealthConnectSdkStatus() async {
    assert(Platform.isAndroid, "This is only available on Android");

    final status = await _health.getHealthConnectSdkStatus();
    return status;
  }
}
