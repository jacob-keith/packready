import '/backend/schema/structs/index.dart';

class PackReadyAiOrchestratorCloudFunctionCallResponse {
  PackReadyAiOrchestratorCloudFunctionCallResponse({
    this.errorCode,
    this.succeeded,
    this.jsonBody,
  });
  String? errorCode;
  bool? succeeded;
  dynamic jsonBody;
}

class PackReadyAiTranscribeCloudFunctionCallResponse {
  PackReadyAiTranscribeCloudFunctionCallResponse({
    this.errorCode,
    this.succeeded,
    this.jsonBody,
  });
  String? errorCode;
  bool? succeeded;
  dynamic jsonBody;
}

class LoadPackReadyAppleCalendarsCloudFunctionCallResponse {
  LoadPackReadyAppleCalendarsCloudFunctionCallResponse({
    this.errorCode,
    this.succeeded,
    this.jsonBody,
  });
  String? errorCode;
  bool? succeeded;
  dynamic jsonBody;
}

class PackReadyAiTripDraftCloudFunctionCallResponse {
  PackReadyAiTripDraftCloudFunctionCallResponse({
    this.errorCode,
    this.succeeded,
    this.jsonBody,
  });
  String? errorCode;
  bool? succeeded;
  dynamic jsonBody;
}

class PackReadyEnsureConnectionTagCloudFunctionCallResponse {
  PackReadyEnsureConnectionTagCloudFunctionCallResponse({
    this.errorCode,
    this.succeeded,
    this.jsonBody,
    this.resultAsString,
    this.data,
  });
  String? errorCode;
  bool? succeeded;
  dynamic jsonBody;
  String? resultAsString;
  dynamic data;
}
