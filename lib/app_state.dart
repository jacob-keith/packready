import 'package:flutter/material.dart'
    show ChangeNotifier, Color, Colors, VoidCallback;
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
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
    _safeInit(() {
      _savedStaples = prefs.getStringList('ff_savedStaples') ?? _savedStaples;
    });
    _safeInit(() {
      _savedTravelStyle =
          prefs.getString('ff_savedTravelStyle') ?? _savedTravelStyle;
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

  List<String> _savedStaples = [];
  List<String> get savedStaples => _savedStaples;
  set savedStaples(List<String> value) {
    _savedStaples = value;
    prefs.setStringList('ff_savedStaples', value);
  }

  void addToSavedStaples(String value) {
    savedStaples.add(value);
    prefs.setStringList('ff_savedStaples', _savedStaples);
  }

  void removeFromSavedStaples(String value) {
    savedStaples.remove(value);
    prefs.setStringList('ff_savedStaples', _savedStaples);
  }

  void removeAtIndexFromSavedStaples(int index) {
    savedStaples.removeAt(index);
    prefs.setStringList('ff_savedStaples', _savedStaples);
  }

  void updateSavedStaplesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    savedStaples[index] = updateFn(_savedStaples[index]);
    prefs.setStringList('ff_savedStaples', _savedStaples);
  }

  void insertAtIndexInSavedStaples(int index, String value) {
    savedStaples.insert(index, value);
    prefs.setStringList('ff_savedStaples', _savedStaples);
  }

  String _savedTravelStyle = 'Carry-on';
  String get savedTravelStyle => _savedTravelStyle;
  set savedTravelStyle(String value) {
    _savedTravelStyle = value;
    prefs.setString('ff_savedTravelStyle', value);
  }

  List<int> _weatherhigh = [];
  List<int> get weatherhigh => _weatherhigh;
  set weatherhigh(List<int> value) {
    _weatherhigh = value;
  }

  void addToWeatherhigh(int value) {
    weatherhigh.add(value);
  }

  void removeFromWeatherhigh(int value) {
    weatherhigh.remove(value);
  }

  void removeAtIndexFromWeatherhigh(int index) {
    weatherhigh.removeAt(index);
  }

  void updateWeatherhighAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    weatherhigh[index] = updateFn(_weatherhigh[index]);
  }

  void insertAtIndexInWeatherhigh(int index, int value) {
    weatherhigh.insert(index, value);
  }

  List<int> _weatherlow = [];
  List<int> get weatherlow => _weatherlow;
  set weatherlow(List<int> value) {
    _weatherlow = value;
  }

  void addToWeatherlow(int value) {
    weatherlow.add(value);
  }

  void removeFromWeatherlow(int value) {
    weatherlow.remove(value);
  }

  void removeAtIndexFromWeatherlow(int index) {
    weatherlow.removeAt(index);
  }

  void updateWeatherlowAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    weatherlow[index] = updateFn(_weatherlow[index]);
  }

  void insertAtIndexInWeatherlow(int index, int value) {
    weatherlow.insert(index, value);
  }

  List<int> _conditioncode = [];
  List<int> get conditioncode => _conditioncode;
  set conditioncode(List<int> value) {
    _conditioncode = value;
  }

  void addToConditioncode(int value) {
    conditioncode.add(value);
  }

  void removeFromConditioncode(int value) {
    conditioncode.remove(value);
  }

  void removeAtIndexFromConditioncode(int index) {
    conditioncode.removeAt(index);
  }

  void updateConditioncodeAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    conditioncode[index] = updateFn(_conditioncode[index]);
  }

  void insertAtIndexInConditioncode(int index, int value) {
    conditioncode.insert(index, value);
  }

  bool _isLoadingWeather = true;
  bool get isLoadingWeather => _isLoadingWeather;
  set isLoadingWeather(bool value) {
    _isLoadingWeather = value;
  }

  List<double> _weatherhi = [];
  List<double> get weatherhi => _weatherhi;
  set weatherhi(List<double> value) {
    _weatherhi = value;
  }

  void addToWeatherhi(double value) {
    weatherhi.add(value);
  }

  void removeFromWeatherhi(double value) {
    weatherhi.remove(value);
  }

  void removeAtIndexFromWeatherhi(int index) {
    weatherhi.removeAt(index);
  }

  void updateWeatherhiAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    weatherhi[index] = updateFn(_weatherhi[index]);
  }

  void insertAtIndexInWeatherhi(int index, double value) {
    weatherhi.insert(index, value);
  }

  List<double> _weatherlo = [];
  List<double> get weatherlo => _weatherlo;
  set weatherlo(List<double> value) {
    _weatherlo = value;
  }

  void addToWeatherlo(double value) {
    weatherlo.add(value);
  }

  void removeFromWeatherlo(double value) {
    weatherlo.remove(value);
  }

  void removeAtIndexFromWeatherlo(int index) {
    weatherlo.removeAt(index);
  }

  void updateWeatherloAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    weatherlo[index] = updateFn(_weatherlo[index]);
  }

  void insertAtIndexInWeatherlo(int index, double value) {
    weatherlo.insert(index, value);
  }

  List<String> _weatherdate = [];
  List<String> get weatherdate => _weatherdate;
  set weatherdate(List<String> value) {
    _weatherdate = value;
  }

  void addToWeatherdate(String value) {
    weatherdate.add(value);
  }

  void removeFromWeatherdate(String value) {
    weatherdate.remove(value);
  }

  void removeAtIndexFromWeatherdate(int index) {
    weatherdate.removeAt(index);
  }

  void updateWeatherdateAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    weatherdate[index] = updateFn(_weatherdate[index]);
  }

  void insertAtIndexInWeatherdate(int index, String value) {
    weatherdate.insert(index, value);
  }

  /// DSL app state historyTrips
  List<HistoryTripStruct> _historyTrips = [];
  List<HistoryTripStruct> get historyTrips => _historyTrips;
  set historyTrips(List<HistoryTripStruct> value) {
    _historyTrips = value;
  }

  void addToHistoryTrips(HistoryTripStruct value) {
    historyTrips.add(value);
  }

  void removeFromHistoryTrips(HistoryTripStruct value) {
    historyTrips.remove(value);
  }

  void removeAtIndexFromHistoryTrips(int index) {
    historyTrips.removeAt(index);
  }

  void updateHistoryTripsAtIndex(
    int index,
    HistoryTripStruct Function(HistoryTripStruct) updateFn,
  ) {
    historyTrips[index] = updateFn(_historyTrips[index]);
  }

  void insertAtIndexInHistoryTrips(int index, HistoryTripStruct value) {
    historyTrips.insert(index, value);
  }

  /// DSL app state historyStatus
  String _historyStatus = 'loading';
  String get historyStatus => _historyStatus;
  set historyStatus(String value) {
    _historyStatus = value;
  }

  /// Current destination in the persistent PackReady tab shell.
  String _packReadyShellActiveTab = 'Home';
  String get packReadyShellActiveTab => _packReadyShellActiveTab;
  set packReadyShellActiveTab(String value) {
    _packReadyShellActiveTab = value;
  }

  /// DSL app state homeTimelineTrips
  List<HomeTimelineTripStruct> _homeTimelineTrips = [];
  List<HomeTimelineTripStruct> get homeTimelineTrips => _homeTimelineTrips;
  set homeTimelineTrips(List<HomeTimelineTripStruct> value) {
    _homeTimelineTrips = value;
  }

  void addToHomeTimelineTrips(HomeTimelineTripStruct value) {
    homeTimelineTrips.add(value);
  }

  void removeFromHomeTimelineTrips(HomeTimelineTripStruct value) {
    homeTimelineTrips.remove(value);
  }

  void removeAtIndexFromHomeTimelineTrips(int index) {
    homeTimelineTrips.removeAt(index);
  }

  void updateHomeTimelineTripsAtIndex(
    int index,
    HomeTimelineTripStruct Function(HomeTimelineTripStruct) updateFn,
  ) {
    homeTimelineTrips[index] = updateFn(_homeTimelineTrips[index]);
  }

  void insertAtIndexInHomeTimelineTrips(
      int index, HomeTimelineTripStruct value) {
    homeTimelineTrips.insert(index, value);
  }

  /// DSL app state homeTimelineStatus
  String _homeTimelineStatus = 'loading';
  String get homeTimelineStatus => _homeTimelineStatus;
  set homeTimelineStatus(String value) {
    _homeTimelineStatus = value;
  }

  /// DSL app state homeInitialTripIndex
  int _homeInitialTripIndex = 0;
  int get homeInitialTripIndex => _homeInitialTripIndex;
  set homeInitialTripIndex(int value) {
    _homeInitialTripIndex = value;
  }

  /// DSL app state homeCarouselAnchor
  String _homeCarouselAnchor = '';
  String get homeCarouselAnchor => _homeCarouselAnchor;
  set homeCarouselAnchor(String value) {
    _homeCarouselAnchor = value;
  }

  /// DSL app state homeNextTripIndex
  int _homeNextTripIndex = -1;
  int get homeNextTripIndex => _homeNextTripIndex;
  set homeNextTripIndex(int value) {
    _homeNextTripIndex = value;
  }

  /// DSL app state packReadyAiProgress
  String _packReadyAiProgress = '';
  String get packReadyAiProgress => _packReadyAiProgress;
  set packReadyAiProgress(String value) {
    _packReadyAiProgress = value;
  }

  /// DSL app state packReadyAiVoicePhase
  String _packReadyAiVoicePhase = 'idle';
  String get packReadyAiVoicePhase => _packReadyAiVoicePhase;
  set packReadyAiVoicePhase(String value) {
    _packReadyAiVoicePhase = value;
  }

  /// DSL app state packReadyAlerts
  List<PackReadyReminderRowStruct> _packReadyAlerts = [];
  List<PackReadyReminderRowStruct> get packReadyAlerts => _packReadyAlerts;
  set packReadyAlerts(List<PackReadyReminderRowStruct> value) {
    _packReadyAlerts = value;
  }

  void addToPackReadyAlerts(PackReadyReminderRowStruct value) {
    packReadyAlerts.add(value);
  }

  void removeFromPackReadyAlerts(PackReadyReminderRowStruct value) {
    packReadyAlerts.remove(value);
  }

  void removeAtIndexFromPackReadyAlerts(int index) {
    packReadyAlerts.removeAt(index);
  }

  void updatePackReadyAlertsAtIndex(
    int index,
    PackReadyReminderRowStruct Function(PackReadyReminderRowStruct) updateFn,
  ) {
    packReadyAlerts[index] = updateFn(_packReadyAlerts[index]);
  }

  void insertAtIndexInPackReadyAlerts(
      int index, PackReadyReminderRowStruct value) {
    packReadyAlerts.insert(index, value);
  }

  /// DSL app state packReadySuggestions
  List<PackReadyReminderRowStruct> _packReadySuggestions = [];
  List<PackReadyReminderRowStruct> get packReadySuggestions =>
      _packReadySuggestions;
  set packReadySuggestions(List<PackReadyReminderRowStruct> value) {
    _packReadySuggestions = value;
  }

  void addToPackReadySuggestions(PackReadyReminderRowStruct value) {
    packReadySuggestions.add(value);
  }

  void removeFromPackReadySuggestions(PackReadyReminderRowStruct value) {
    packReadySuggestions.remove(value);
  }

  void removeAtIndexFromPackReadySuggestions(int index) {
    packReadySuggestions.removeAt(index);
  }

  void updatePackReadySuggestionsAtIndex(
    int index,
    PackReadyReminderRowStruct Function(PackReadyReminderRowStruct) updateFn,
  ) {
    packReadySuggestions[index] = updateFn(_packReadySuggestions[index]);
  }

  void insertAtIndexInPackReadySuggestions(
      int index, PackReadyReminderRowStruct value) {
    packReadySuggestions.insert(index, value);
  }

  /// DSL app state packReadyAlertStatus
  String _packReadyAlertStatus = 'loading';
  String get packReadyAlertStatus => _packReadyAlertStatus;
  set packReadyAlertStatus(String value) {
    _packReadyAlertStatus = value;
  }

  /// DSL app state packReadySuggestionStatus
  String _packReadySuggestionStatus = 'loading';
  String get packReadySuggestionStatus => _packReadySuggestionStatus;
  set packReadySuggestionStatus(String value) {
    _packReadySuggestionStatus = value;
  }

  /// DSL app state nativeActivities
  List<NativeActivityRowStruct> _nativeActivities = [];
  List<NativeActivityRowStruct> get nativeActivities => _nativeActivities;
  set nativeActivities(List<NativeActivityRowStruct> value) {
    _nativeActivities = value;
  }

  void addToNativeActivities(NativeActivityRowStruct value) {
    nativeActivities.add(value);
  }

  void removeFromNativeActivities(NativeActivityRowStruct value) {
    nativeActivities.remove(value);
  }

  void removeAtIndexFromNativeActivities(int index) {
    nativeActivities.removeAt(index);
  }

  void updateNativeActivitiesAtIndex(
    int index,
    NativeActivityRowStruct Function(NativeActivityRowStruct) updateFn,
  ) {
    nativeActivities[index] = updateFn(_nativeActivities[index]);
  }

  void insertAtIndexInNativeActivities(
      int index, NativeActivityRowStruct value) {
    nativeActivities.insert(index, value);
  }

  /// DSL app state nativeActivitiesStatus
  String _nativeActivitiesStatus = 'loading';
  String get nativeActivitiesStatus => _nativeActivitiesStatus;
  set nativeActivitiesStatus(String value) {
    _nativeActivitiesStatus = value;
  }

  /// DSL app state nativeTemplates
  List<NativeActivityRowStruct> _nativeTemplates = [];
  List<NativeActivityRowStruct> get nativeTemplates => _nativeTemplates;
  set nativeTemplates(List<NativeActivityRowStruct> value) {
    _nativeTemplates = value;
  }

  void addToNativeTemplates(NativeActivityRowStruct value) {
    nativeTemplates.add(value);
  }

  void removeFromNativeTemplates(NativeActivityRowStruct value) {
    nativeTemplates.remove(value);
  }

  void removeAtIndexFromNativeTemplates(int index) {
    nativeTemplates.removeAt(index);
  }

  void updateNativeTemplatesAtIndex(
    int index,
    NativeActivityRowStruct Function(NativeActivityRowStruct) updateFn,
  ) {
    nativeTemplates[index] = updateFn(_nativeTemplates[index]);
  }

  void insertAtIndexInNativeTemplates(
      int index, NativeActivityRowStruct value) {
    nativeTemplates.insert(index, value);
  }

  /// DSL app state nativeTemplatesStatus
  String _nativeTemplatesStatus = 'loading';
  String get nativeTemplatesStatus => _nativeTemplatesStatus;
  set nativeTemplatesStatus(String value) {
    _nativeTemplatesStatus = value;
  }

  /// DSL app state nativeAiSchedule
  NativeAiScheduleStruct _nativeAiSchedule = NativeAiScheduleStruct();
  NativeAiScheduleStruct get nativeAiSchedule => _nativeAiSchedule;
  set nativeAiSchedule(NativeAiScheduleStruct value) {
    _nativeAiSchedule = value;
  }

  void updateNativeAiScheduleStruct(Function(NativeAiScheduleStruct) updateFn) {
    updateFn(_nativeAiSchedule);
  }

  /// DSL app state nativeChecklistVoicePhase
  String _nativeChecklistVoicePhase = '';
  String get nativeChecklistVoicePhase => _nativeChecklistVoicePhase;
  set nativeChecklistVoicePhase(String value) {
    _nativeChecklistVoicePhase = value;
  }

  /// DSL app state homeTimelineDays
  List<HomeTimelineDayStruct> _homeTimelineDays = [];
  List<HomeTimelineDayStruct> get homeTimelineDays => _homeTimelineDays;
  set homeTimelineDays(List<HomeTimelineDayStruct> value) {
    _homeTimelineDays = value;
  }

  void addToHomeTimelineDays(HomeTimelineDayStruct value) {
    homeTimelineDays.add(value);
  }

  void removeFromHomeTimelineDays(HomeTimelineDayStruct value) {
    homeTimelineDays.remove(value);
  }

  void removeAtIndexFromHomeTimelineDays(int index) {
    homeTimelineDays.removeAt(index);
  }

  void updateHomeTimelineDaysAtIndex(
    int index,
    HomeTimelineDayStruct Function(HomeTimelineDayStruct) updateFn,
  ) {
    homeTimelineDays[index] = updateFn(_homeTimelineDays[index]);
  }

  void insertAtIndexInHomeTimelineDays(int index, HomeTimelineDayStruct value) {
    homeTimelineDays.insert(index, value);
  }

  /// DSL app state packReadyConnectionsData
  PackReadyConnectionsDataStruct _packReadyConnectionsData =
      PackReadyConnectionsDataStruct();
  PackReadyConnectionsDataStruct get packReadyConnectionsData =>
      _packReadyConnectionsData;
  set packReadyConnectionsData(PackReadyConnectionsDataStruct value) {
    _packReadyConnectionsData = value;
  }

  void updatePackReadyConnectionsDataStruct(
      Function(PackReadyConnectionsDataStruct) updateFn) {
    updateFn(_packReadyConnectionsData);
  }

  /// DSL app state packReadySharedWithYou
  PackReadyConnectionsDataStruct _packReadySharedWithYou =
      PackReadyConnectionsDataStruct();
  PackReadyConnectionsDataStruct get packReadySharedWithYou =>
      _packReadySharedWithYou;
  set packReadySharedWithYou(PackReadyConnectionsDataStruct value) {
    _packReadySharedWithYou = value;
  }

  void updatePackReadySharedWithYouStruct(
      Function(PackReadyConnectionsDataStruct) updateFn) {
    updateFn(_packReadySharedWithYou);
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
