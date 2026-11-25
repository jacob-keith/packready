import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/structs/index.dart';
import '/components/schedule_preset_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Type;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'checklist_run_model.dart';
export 'checklist_run_model.dart';

/// Use one of your saved checklists: tap items to check them off.
///
/// Check-offs start fresh each time you open it.
class ChecklistRunWidget extends StatefulWidget {
  const ChecklistRunWidget({
    super.key,
    required this.templateRef,
    this.runName,
    this.runActivity,
    this.runStarter,
    this.runItems,
  });

  final DocumentReference? templateRef;
  final String? runName;
  final String? runActivity;
  final String? runStarter;
  final List<PackItemStruct>? runItems;

  static String routeName = 'ChecklistRun';
  static String routePath = '/checklistRun';

  @override
  State<ChecklistRunWidget> createState() => _ChecklistRunWidgetState();
}

class _ChecklistRunWidgetState extends State<ChecklistRunWidget> {
  late ChecklistRunModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChecklistRunModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ChecklistRun'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CHECKLIST_RUN_ChecklistRun_ON_INIT_STATE');
      _model.pageItems = widget!.runItems!.toList().cast<PackItemStruct>();
      safeSetState(() {});
      _model.leaveDate = (DateTime? now) {
        return (now ?? DateTime.now()).add(const Duration(minutes: 15));
      }(getCurrentTimestamp);
      safeSetState(() {});
    });

    _model.activityNameFieldTextController ??= TextEditingController();
    _model.activityNameFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          iconTheme:
              IconThemeData(color: FlutterFlowTheme.of(context).primaryText),
          automaticallyImplyLeading: true,
          title: Text(
            valueOrDefault<String>(
              widget!.runName,
              'My checklist',
            ),
            maxLines: 1,
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.manrope(
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('CHECKLIST_RUN_EditTemplateHeader_ON_TAP');
                  // Open Template Editor

                  context.pushNamed(
                    TemplateEditorWidget.routeName,
                    queryParameters: {
                      'templateRef': serializeParam(
                        widget!.templateRef,
                        ParamType.DocumentReference,
                      ),
                      'startName': serializeParam(
                        widget!.runName,
                        ParamType.String,
                      ),
                      'startActivity': serializeParam(
                        widget!.runActivity,
                        ParamType.String,
                      ),
                      'startStarter': serializeParam(
                        widget!.runStarter,
                        ParamType.String,
                      ),
                      'startItems': serializeParam(
                        widget!.runItems,
                        ParamType.DataStruct,
                        isList: true,
                      ),
                      'startAiExtras': serializeParam(
                        widget!.runItems,
                        ParamType.DataStruct,
                        isList: true,
                      ),
                      'startFromAiDraft': serializeParam(
                        false,
                        ParamType.bool,
                      ),
                    }.withoutNulls,
                  );
                },
                text: 'Edit',
                icon: Icon(
                  Icons.edit_outlined,
                  size: 20.0,
                ),
                options: FFButtonOptions(
                  height: 44.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconColor: FlutterFlowTheme.of(context).primaryText,
                  color: Colors.transparent,
                  textStyle: TextStyle(
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: (FFCrossAxisAlignment.stretch).flutterValue,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '${_model.pageItems.where((e) => e.packed).toList().length.toString()} of ${_model.pageItems.length.toString()} packed',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                    child: LinearPercentIndicator(
                      percent: ((int? packed, int? total) {
                        return (total ?? 0) == 0 ? 0.0 : (packed ?? 0) / total!;
                      }(_model.pageItems.where((e) => e.packed).toList().length,
                          _model.pageItems.length))!,
                      lineHeight: 5.0,
                      animation: false,
                      animateFromLastPercent: true,
                      progressColor: FlutterFlowTheme.of(context).secondary,
                      backgroundColor: FlutterFlowTheme.of(context).alternate,
                      barRadius: Radius.circular(2.5),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      final listItem = _model.pageItems.toList();

                      return ListView.separated(
                        padding: EdgeInsets.fromLTRB(
                          0,
                          12.0,
                          0,
                          12.0,
                        ),
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listItem.length,
                        separatorBuilder: (_, __) => SizedBox(height: 8.0),
                        itemBuilder: (context, listItemIndex) {
                          final listItemItem = listItem[listItemIndex];
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'CHECKLIST_RUN_Container_5pj2jw3a_ON_TAP');
                              _model.updatePageItemsAtIndex(
                                listItemIndex,
                                (e) => e..packed = !e.packed,
                              );
                              safeSetState(() {});
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: listItemItem.packed
                                    ? FlutterFlowTheme.of(context).accent1
                                    : FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? 1.0
                                      : 1.5,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 13.0, 12.0, 13.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (listItemItem.packed)
                                      Icon(
                                        Icons.check_circle,
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        size: 24.0,
                                      ),
                                    if (!listItemItem.packed)
                                      Icon(
                                        Icons.radio_button_off,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              (FFCrossAxisAlignment.start)
                                                  .flutterValue,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: [
                                            Text(
                                              listItemItem.name,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                            Text(
                                              listItemItem.detail,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: Theme.of(context).brightness == Brightness.dark
                              ? 1.0
                              : 1.5,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            12.0, 12.0, 12.0, 12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment:
                              (FFCrossAxisAlignment.stretch).flutterValue,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              'Create an activity from this template',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                            Container(
                              width: 200.0,
                              child: TextFormField(
                                controller:
                                    _model.activityNameFieldTextController,
                                focusNode: _model.activityNameFieldFocusNode,
                                autofocus: false,
                                enabled: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.spaceGrotesk(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                  hintText:
                                      'Activity name (e.g. Saturday flight)',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.spaceGrotesk(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                cursorColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                enableInteractiveSelection: true,
                                validator: _model
                                    .activityNameFieldTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment:
                                  (FFMainAxisAlignment.start).flutterValue,
                              crossAxisAlignment:
                                  (FFCrossAxisAlignment.stretch).flutterValue,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 300.0,
                                  child: wrapWithModel(
                                    model: _model.schedulePresetModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: SchedulePresetWidget(
                                      selectedDate: _model.leaveDate,
                                      allowEarlierDates: false,
                                      onScheduleChanged: (newDate) async {
                                        logFirebaseEvent(
                                            'CHECKLIST_RUN_SchedulePreset_CALLBACK');
                                        // Update selected date and time
                                        _model.leaveDate = newDate;
                                        safeSetState(() {});
                                      },
                                    ),
                                  ),
                                ),
                                Text(
                                  'Repeat',
                                  style: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.manrope(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                ),
                              ].divide(SizedBox(height: 8.0)),
                            ),
                            FlutterFlowChoiceChips(
                              options: [
                                ChipData('One-time'),
                                ChipData('Recurring')
                              ],
                              onChanged: (val) => safeSetState(() =>
                                  _model.repeatChipsValue = val?.firstOrNull),
                              selectedChipStyle: ChipStyle(
                                backgroundColor:
                                    FlutterFlowTheme.of(context).accent1,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                iconColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                iconSize: 16.0,
                                elevation: 0.0,
                                borderColor:
                                    FlutterFlowTheme.of(context).secondary,
                                borderWidth: 1.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              unselectedChipStyle: ChipStyle(
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                iconColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                iconSize: 16.0,
                                elevation: 0.0,
                                borderColor:
                                    FlutterFlowTheme.of(context).alternate,
                                borderWidth: 1.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              chipSpacing: 8.0,
                              rowSpacing: 8.0,
                              multiselect: false,
                              initialized: _model.repeatChipsValue != null,
                              alignment: WrapAlignment.start,
                              controller: _model.repeatChipsValueController ??=
                                  FormFieldController<List<String>>(
                                ['One-time'],
                              ),
                              wrapped: true,
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                logFirebaseEvent(
                                    'CHECKLIST_RUN_CreateActivityFromChecklis');
                                if ((_model.activityNameFieldTextController
                                                .text !=
                                            null &&
                                        _model.activityNameFieldTextController
                                                .text !=
                                            '') &&
                                    (_model.leaveDate != null)) {
                                  // Create activity from this checklist
                                  _model.goldenSavedList =
                                      await actions.savePackingList(
                                    context,
                                    _model.activityNameFieldTextController.text,
                                    widget!.runActivity,
                                    _model.leaveDate,
                                    _model.repeatChipsValue == 'Recurring',
                                    widget!.runItems?.toList(),
                                  );
                                  if (_model.goldenSavedList != null) {
                                    // Open Packing List

                                    context.goNamed(
                                      PackingListWidget.routeName,
                                      queryParameters: {
                                        'listRef': serializeParam(
                                          _model.goldenSavedList,
                                          ParamType.DocumentReference,
                                        ),
                                      }.withoutNulls,
                                    );

                                    if (((DateTime? due) {
                                      return due != null &&
                                          due.isAfter(DateTime.now());
                                    }(((DateTime? leave, String? preference) {
                                      return (() {
                                        final minutes = switch (preference) {
                                          '30 mins before' => 30,
                                          '1 hour before leaving' => 60,
                                          '2 hours before' => 120,
                                          '1 day before' => 1440,
                                          _ => null,
                                        };
                                        return minutes == null
                                            ? null
                                            : leave?.subtract(
                                                Duration(minutes: minutes));
                                      })();
                                    }(
                                        _model.leaveDate,
                                        valueOrDefault(
                                            currentUserDocument
                                                ?.defaultReminder,
                                            '')))))!) {
                                      triggerPushNotification(
                                        notificationTitle: _model
                                            .activityNameFieldTextController
                                            .text,
                                        notificationText:
                                            'Finish packing for your trip.',
                                        scheduledTime: ((DateTime? leave,
                                                String? preference) {
                                          return (() {
                                            final minutes =
                                                switch (preference) {
                                              '30 mins before' => 30,
                                              '1 hour before leaving' => 60,
                                              '2 hours before' => 120,
                                              '1 day before' => 1440,
                                              _ => null,
                                            };
                                            return minutes == null
                                                ? null
                                                : leave?.subtract(
                                                    Duration(minutes: minutes));
                                          })();
                                        }(
                                            _model.leaveDate,
                                            valueOrDefault(
                                                currentUserDocument
                                                    ?.defaultReminder,
                                                '')))!,
                                        notificationSound: 'default',
                                        userRefs: [currentUserReference!],
                                        initialPageName: 'PackingList',
                                        parameterData: {
                                          'listRef': _model.goldenSavedList,
                                        },
                                      );
                                    }
                                  } else {
                                    // Show message: Couldn't create your list. Please check your connection and try again.
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Couldn\'t create your list. Please check your connection and try again.',
                                          style: TextStyle(),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                      ),
                                    );
                                  }
                                } else {
                                  // Show message: Add an activity name and a date first.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Add an activity name and a date first.',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .tertiary,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context).accent2,
                                    ),
                                  );
                                }

                                safeSetState(() {});
                              },
                              text: 'Create activity',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 48.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .onPrimary,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ].divide(SizedBox(height: 10.0)),
                        ),
                      ),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent('CHECKLIST_RUN_PAGE_btn_Done_ON_TAP');
                      if (widget!.runItems
                              ?.where((e) => e.packed)
                              .toList()
                              ?.length ==
                          widget!.runItems?.length) {
                        logFirebaseEvent('Completed List');
                      }
                      // Open Home

                      context.goNamed(MainscreenWidget.routeName);
                    },
                    text: _model.pageItems
                                .where((e) => e.packed)
                                .toList()
                                .length ==
                            _model.pageItems.length
                        ? 'Return home'
                        : 'Done',
                    options: FFButtonOptions(
                      height: 48.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.manrope(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
