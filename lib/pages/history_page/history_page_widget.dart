import '/components/stat_mini2_widget.dart';
import '/components/tab_group_widget.dart';
import '/components/trip_log_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'history_page_model.dart';
export 'history_page_model.dart';

class HistoryPageWidget extends StatefulWidget {
  const HistoryPageWidget({super.key});

  static String routeName = 'HistoryPage';
  static String routePath = '/historyPage';

  @override
  State<HistoryPageWidget> createState() => _HistoryPageWidgetState();
}

class _HistoryPageWidgetState extends State<HistoryPageWidget> {
  late HistoryPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HistoryPageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'HistoryPage'});
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
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: wrapWithModel(
                                  model: _model.statMiniModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: StatMini2Widget(
                                    icon: Icon(
                                      Icons.inventory_2_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 16.0,
                                    ),
                                    label: 'Total Trips',
                                    value: '24',
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: wrapWithModel(
                                  model: _model.statMiniModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: StatMini2Widget(
                                    icon: Icon(
                                      Icons.task_alt_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 16.0,
                                    ),
                                    label: 'Items Packed',
                                    value: '842',
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: wrapWithModel(
                                  model: _model.statMiniModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: StatMini2Widget(
                                    icon: Icon(
                                      Icons.star_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 16.0,
                                    ),
                                    label: 'Avg. Score',
                                    value: '98%',
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 16.0)),
                          ),
                        ),
                      ),
                      Container(
                        height: 1.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).alternate,
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                  child: Container(
                    child: wrapWithModel(
                      model: _model.tabGroupModel,
                      updateCallback: () => safeSetState(() {}),
                      child: TabGroupWidget(
                        label2: 'Business',
                        label2Present: true,
                        label3: 'Leisure',
                        label3Present: true,
                        label4: 'Gym',
                        label4Present: true,
                        label5: '',
                        label5Present: false,
                        label1: 'All Trips',
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: SingleChildScrollView(
                    primary: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                wrapWithModel(
                                  model: _model.tripLogItemModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TripLogItemWidget(
                                    date: 'Oct 12 - 14, 2026',
                                    forgottenCount: '0',
                                    status: 'Completed',
                                    title: 'Weekend in Vermont',
                                    itemsCount: '12',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.tripLogItemModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TripLogItemWidget(
                                    date: 'Oct 10, 2026',
                                    forgottenCount: '0',
                                    status: 'Completed',
                                    title: 'Morning Gym Session',
                                    itemsCount: '8',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.tripLogItemModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TripLogItemWidget(
                                    date: 'Sep 22 - 26, 2026',
                                    forgottenCount: '0',
                                    status: 'Completed',
                                    title: 'Conference in Chicago',
                                    itemsCount: '24',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.tripLogItemModel4,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TripLogItemWidget(
                                    date: 'Sep 15 - 18, 2026',
                                    forgottenCount: '0',
                                    status: 'Completed',
                                    title: 'Family Camping Trip',
                                    itemsCount: '45',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.tripLogItemModel5,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TripLogItemWidget(
                                    date: 'Sep 08, 2026',
                                    forgottenCount: '0',
                                    status: 'Completed',
                                    title: 'Weekly Grocery Run',
                                    itemsCount: '15',
                                  ),
                                ),
                              ].divide(SizedBox(height: 16.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Container(),
              ),
            ].addToStart(SizedBox(height: 2.0)),
          ),
        ),
      ),
    );
  }
}
