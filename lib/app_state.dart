import 'package:flutter/material.dart'
    show ChangeNotifier, Color, Colors, VoidCallback;
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _packedGym = prefs.getStringList('ff_packedGym') ?? _packedGym;
    });
    _safeInit(() {
      _selectedActivity =
          prefs.getString('ff_selectedActivity') ?? _selectedActivity;
    });
    _safeInit(() {
      _packedTravel = prefs.getStringList('ff_packedTravel') ?? _packedTravel;
    });
    _safeInit(() {
      _packedCamping =
          prefs.getStringList('ff_packedCamping') ?? _packedCamping;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  /// Names of Gym checklist items marked as packed.
  List<String> _packedGym = [];
  List<String> get packedGym => _packedGym;
  set packedGym(List<String> value) {
    _packedGym = value;
    prefs.setStringList('ff_packedGym', value);
  }

  void addToPackedGym(String value) {
    packedGym.add(value);
    prefs.setStringList('ff_packedGym', _packedGym);
  }

  void removeFromPackedGym(String value) {
    packedGym.remove(value);
    prefs.setStringList('ff_packedGym', _packedGym);
  }

  void removeAtIndexFromPackedGym(int index) {
    packedGym.removeAt(index);
    prefs.setStringList('ff_packedGym', _packedGym);
  }

  void updatePackedGymAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    packedGym[index] = updateFn(_packedGym[index]);
    prefs.setStringList('ff_packedGym', _packedGym);
  }

  void insertAtIndexInPackedGym(int index, String value) {
    packedGym.insert(index, value);
    prefs.setStringList('ff_packedGym', _packedGym);
  }

  String _selectedActivity = 'Gym';
  String get selectedActivity => _selectedActivity;
  set selectedActivity(String value) {
    _selectedActivity = value;
    prefs.setString('ff_selectedActivity', value);
  }

  /// Names of Travel checklist items marked as packed.
  List<String> _packedTravel = [];
  List<String> get packedTravel => _packedTravel;
  set packedTravel(List<String> value) {
    _packedTravel = value;
    prefs.setStringList('ff_packedTravel', value);
  }

  void addToPackedTravel(String value) {
    packedTravel.add(value);
    prefs.setStringList('ff_packedTravel', _packedTravel);
  }

  void removeFromPackedTravel(String value) {
    packedTravel.remove(value);
    prefs.setStringList('ff_packedTravel', _packedTravel);
  }

  void removeAtIndexFromPackedTravel(int index) {
    packedTravel.removeAt(index);
    prefs.setStringList('ff_packedTravel', _packedTravel);
  }

  void updatePackedTravelAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    packedTravel[index] = updateFn(_packedTravel[index]);
    prefs.setStringList('ff_packedTravel', _packedTravel);
  }

  void insertAtIndexInPackedTravel(int index, String value) {
    packedTravel.insert(index, value);
    prefs.setStringList('ff_packedTravel', _packedTravel);
  }

  /// Names of Camping checklist items marked as packed.
  List<String> _packedCamping = [];
  List<String> get packedCamping => _packedCamping;
  set packedCamping(List<String> value) {
    _packedCamping = value;
    prefs.setStringList('ff_packedCamping', value);
  }

  void addToPackedCamping(String value) {
    packedCamping.add(value);
    prefs.setStringList('ff_packedCamping', _packedCamping);
  }

  void removeFromPackedCamping(String value) {
    packedCamping.remove(value);
    prefs.setStringList('ff_packedCamping', _packedCamping);
  }

  void removeAtIndexFromPackedCamping(int index) {
    packedCamping.removeAt(index);
    prefs.setStringList('ff_packedCamping', _packedCamping);
  }

  void updatePackedCampingAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    packedCamping[index] = updateFn(_packedCamping[index]);
    prefs.setStringList('ff_packedCamping', _packedCamping);
  }

  void insertAtIndexInPackedCamping(int index, String value) {
    packedCamping.insert(index, value);
    prefs.setStringList('ff_packedCamping', _packedCamping);
  }

  /// Gym template checklist items.
  List<PackItemStruct> _gymItems = [
    PackItemStruct.fromSerializableMap(jsonDecode(
        '{\"name\":\"Performance Sneakers\",\"detail\":\"Cross-training shoes\"}')),
    PackItemStruct.fromSerializableMap(jsonDecode(
        '{\"name\":\"Quick-dry Gym Towel\",\"detail\":\"Microfiber material\"}')),
    PackItemStruct.fromSerializableMap(jsonDecode(
        '{\"name\":\"Insulated Water Bottle\",\"detail\":\"32oz minimum\"}')),
    PackItemStruct.fromSerializableMap(jsonDecode(
        '{\"name\":\"Workout Clothes\",\"detail\":\"Shirt and shorts\"}')),
    PackItemStruct.fromSerializableMap(jsonDecode(
        '{\"name\":\"Wireless Headphones\",\"detail\":\"Fully charged\"}')),
    PackItemStruct.fromSerializableMap(jsonDecode(
        '{\"name\":\"Locker Lock\",\"detail\":\"Combination lock\"}'))
  ];
  List<PackItemStruct> get gymItems => _gymItems;
  set gymItems(List<PackItemStruct> value) {
    _gymItems = value;
  }

  void addToGymItems(PackItemStruct value) {
    gymItems.add(value);
  }

  void removeFromGymItems(PackItemStruct value) {
    gymItems.remove(value);
  }

  void removeAtIndexFromGymItems(int index) {
    gymItems.removeAt(index);
  }

  void updateGymItemsAtIndex(
    int index,
    PackItemStruct Function(PackItemStruct) updateFn,
  ) {
    gymItems[index] = updateFn(_gymItems[index]);
  }

  void insertAtIndexInGymItems(int index, PackItemStruct value) {
    gymItems.insert(index, value);
  }

  /// Travel template checklist items.
  List<PackItemStruct> _travelItems = [
    PackItemStruct.fromSerializableMap(jsonDecode(
        '{\"name\":\"Passport & ID\",\"detail\":\"Travel documents\"}')),
    PackItemStruct.fromSerializableMap(jsonDecode(
        '{\"name\":\"Phone Charger\",\"detail\":\"Plus power bank\"}')),
    PackItemStruct.fromSerializableMap(
        jsonDecode('{\"name\":\"Toiletries Bag\",\"detail\":\"Travel-size\"}')),
    PackItemStruct.fromSerializableMap(
        jsonDecode('{\"name\":\"Change of Clothes\",\"detail\":\"3 days\"}')),
    PackItemStruct.fromSerializableMap(
        jsonDecode('{\"name\":\"Medications\",\"detail\":\"Daily doses\"}')),
    PackItemStruct.fromSerializableMap(
        jsonDecode('{\"name\":\"Travel Pillow\",\"detail\":\"Memory foam\"}'))
  ];
  List<PackItemStruct> get travelItems => _travelItems;
  set travelItems(List<PackItemStruct> value) {
    _travelItems = value;
  }

  void addToTravelItems(PackItemStruct value) {
    travelItems.add(value);
  }

  void removeFromTravelItems(PackItemStruct value) {
    travelItems.remove(value);
  }

  void removeAtIndexFromTravelItems(int index) {
    travelItems.removeAt(index);
  }

  void updateTravelItemsAtIndex(
    int index,
    PackItemStruct Function(PackItemStruct) updateFn,
  ) {
    travelItems[index] = updateFn(_travelItems[index]);
  }

  void insertAtIndexInTravelItems(int index, PackItemStruct value) {
    travelItems.insert(index, value);
  }

  /// Camping template checklist items.
  List<PackItemStruct> _campingItems = [
    PackItemStruct.fromSerializableMap(
        jsonDecode('{\"name\":\"Hiking Boots\",\"detail\":\"1 pair\"}')),
    PackItemStruct.fromSerializableMap(
        jsonDecode('{\"name\":\"Thermal Socks\",\"detail\":\"2 pairs\"}')),
    PackItemStruct.fromSerializableMap(
        jsonDecode('{\"name\":\"Water Bladder\",\"detail\":\"2.5 Liters\"}')),
    PackItemStruct.fromSerializableMap(
        jsonDecode('{\"name\":\"Sunscreen SPF 50\",\"detail\":\"1 bottle\"}')),
    PackItemStruct.fromSerializableMap(jsonDecode(
        '{\"name\":\"Lightweight Rain Shell\",\"detail\":\"1 unit\"}')),
    PackItemStruct.fromSerializableMap(jsonDecode(
        '{\"name\":\"Navigation Map\",\"detail\":\"Offline Download\"}')),
    PackItemStruct.fromSerializableMap(
        jsonDecode('{\"name\":\"Energy Bars\",\"detail\":\"6 bars\"}')),
    PackItemStruct.fromSerializableMap(
        jsonDecode('{\"name\":\"First Aid Kit\",\"detail\":\"Compact\"}'))
  ];
  List<PackItemStruct> get campingItems => _campingItems;
  set campingItems(List<PackItemStruct> value) {
    _campingItems = value;
  }

  void addToCampingItems(PackItemStruct value) {
    campingItems.add(value);
  }

  void removeFromCampingItems(PackItemStruct value) {
    campingItems.remove(value);
  }

  void removeAtIndexFromCampingItems(int index) {
    campingItems.removeAt(index);
  }

  void updateCampingItemsAtIndex(
    int index,
    PackItemStruct Function(PackItemStruct) updateFn,
  ) {
    campingItems[index] = updateFn(_campingItems[index]);
  }

  void insertAtIndexInCampingItems(int index, PackItemStruct value) {
    campingItems.insert(index, value);
  }

  List<PackItemStruct> _customItems = [];
  List<PackItemStruct> get customItems => _customItems;
  set customItems(List<PackItemStruct> value) {
    _customItems = value;
  }

  void addToCustomItems(PackItemStruct value) {
    customItems.add(value);
  }

  void removeFromCustomItems(PackItemStruct value) {
    customItems.remove(value);
  }

  void removeAtIndexFromCustomItems(int index) {
    customItems.removeAt(index);
  }

  void updateCustomItemsAtIndex(
    int index,
    PackItemStruct Function(PackItemStruct) updateFn,
  ) {
    customItems[index] = updateFn(_customItems[index]);
  }

  void insertAtIndexInCustomItems(int index, PackItemStruct value) {
    customItems.insert(index, value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
