import '/components/navigation/tab_item/tab_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'tab_group_model.dart';
export 'tab_group_model.dart';

class TabGroupWidget extends StatefulWidget {
  const TabGroupWidget({
    super.key,
    String? label2,
    bool? label2Present,
    String? label3,
    bool? label3Present,
    String? label4,
    bool? label4Present,
    String? label5,
    bool? label5Present,
    String? label1,
    String? selectedCategory,
    required this.onCategoryChanged,
  })  : this.label2 = label2 ?? 'Business',
        this.label2Present = label2Present ?? true,
        this.label3 = label3 ?? 'Leisure',
        this.label3Present = label3Present ?? true,
        this.label4 = label4 ?? 'Gym',
        this.label4Present = label4Present ?? true,
        this.label5 = label5 ?? '',
        this.label5Present = label5Present ?? false,
        this.label1 = label1 ?? 'All Trips',
        this.selectedCategory = selectedCategory ?? 'All Trips';

  final String label2;
  final bool label2Present;
  final String label3;
  final bool label3Present;
  final String label4;
  final bool label4Present;
  final String label5;
  final bool label5Present;
  final String label1;
  final String selectedCategory;
  final Future Function(String category)? onCategoryChanged;

  @override
  State<TabGroupWidget> createState() => _TabGroupWidgetState();
}

class _TabGroupWidgetState extends State<TabGroupWidget> {
  late TabGroupModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TabGroupModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: wrapWithModel(
                model: _model.allTripsModel,
                updateCallback: () => safeSetState(() {}),
                child: TabItemWidget(
                  label: 'All Trips',
                  selected: widget!.selectedCategory == 'All Trips',
                  onTap: () async {
                    logFirebaseEvent('TAB_GROUP_COMP_AllTrips_CALLBACK');
                    await widget.onCategoryChanged?.call(
                      'All Trips',
                    );
                  },
                ),
              ),
            ),
            if (valueOrDefault<bool>(
              widget!.label2Present,
              true,
            ))
              Expanded(
                flex: 1,
                child: wrapWithModel(
                  model: _model.businessModel,
                  updateCallback: () => safeSetState(() {}),
                  child: TabItemWidget(
                    label: 'Business',
                    selected: widget!.selectedCategory == 'Business',
                    onTap: () async {
                      logFirebaseEvent('TAB_GROUP_COMP_Business_CALLBACK');
                      await widget.onCategoryChanged?.call(
                        'Business',
                      );
                    },
                  ),
                ),
              ),
            if (valueOrDefault<bool>(
              widget!.label3Present,
              true,
            ))
              Expanded(
                flex: 1,
                child: wrapWithModel(
                  model: _model.leisureModel,
                  updateCallback: () => safeSetState(() {}),
                  child: TabItemWidget(
                    label: 'Leisure',
                    selected: widget!.selectedCategory == 'Leisure',
                    onTap: () async {
                      logFirebaseEvent('TAB_GROUP_COMP_Leisure_CALLBACK');
                      await widget.onCategoryChanged?.call(
                        'Leisure',
                      );
                    },
                  ),
                ),
              ),
            if (valueOrDefault<bool>(
              widget!.label4Present,
              true,
            ))
              Expanded(
                flex: 1,
                child: wrapWithModel(
                  model: _model.gymModel,
                  updateCallback: () => safeSetState(() {}),
                  child: TabItemWidget(
                    label: 'Gym',
                    selected: widget!.selectedCategory == 'Gym',
                    onTap: () async {
                      logFirebaseEvent('TAB_GROUP_COMP_Gym_CALLBACK');
                      await widget.onCategoryChanged?.call(
                        'Gym',
                      );
                    },
                  ),
                ),
              ),
            if (valueOrDefault<bool>(
              widget!.label5Present,
              false,
            ))
              Expanded(
                flex: 1,
                child: wrapWithModel(
                  model: _model.tabItemModel,
                  updateCallback: () => safeSetState(() {}),
                  child: TabItemWidget(
                    label: widget!.label5,
                    selected: false,
                    onTap: () async {},
                  ),
                ),
              ),
          ].divide(SizedBox(width: 0.0)),
        ),
      ),
    );
  }
}
