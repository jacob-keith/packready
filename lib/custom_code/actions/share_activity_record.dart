// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/app_events/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/auth/firebase_auth/auth_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '/custom_code/actions/watch_pack_ready_connections.dart';

Future<void> shareActivityRecord(
  BuildContext context,
  bool? template,
  DocumentReference? listRef,
  String? title,
  String? activity,
  List<PackItemStruct>? items,
) async {
  final owner = currentUserReference;
  if (owner == null) return;
  var shareTitle = title ?? '';
  var shareActivity = activity ?? '';
  var shareItems = items ?? const <PackItemStruct>[];
  try {
    if (listRef != null) {
      if (listRef.parent.id != 'packingLists' || listRef.parent.parent != owner)
        return;
      final list = await PackingListsRecord.getDocumentOnce(listRef);
      if (!context.mounted || currentUserReference != owner) return;
      shareTitle = list.tripName;
      shareActivity = list.activity;
      shareItems = list.items;
    }
    await showPackReadyShare(
      context,
      userId: currentUserUid,
      kind: template == true ? 'template' : 'activity',
      name: shareTitle,
      activity: shareActivity,
      items: shareItems,
    );
  } catch (_) {
    if (context.mounted)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Couldn’t load this activity to share.')),
      );
  }
}

Future<void> showPackReadyShare(
  BuildContext context, {
  required String userId,
  required String kind,
  required String name,
  required String activity,
  required List<PackItemStruct> items,
}) =>
    showDialog<void>(
      context: context,
      builder: (_) => _ShareDialog(
        store: PackReadyConnectionsStore(userId),
        kind: kind,
        snapshot: {
          'name': name.trim().isEmpty
              ? (kind == 'template' ? 'Checklist' : 'Packing list')
              : name,
          'activity': ['Gym', 'Camping', 'Travel', 'Custom'].contains(activity)
              ? activity
              : 'Custom',
          'items': [
            for (final item in items)
              {
                'name': item.name,
                'detail': item.detail,
                'category': item.category,
                'packed': false,
              },
          ],
        },
      ),
    );

class _ShareDialog extends StatefulWidget {
  const _ShareDialog({
    required this.store,
    required this.kind,
    required this.snapshot,
  });

  final PackReadyConnectionsStore store;
  final String kind;
  final Map<String, dynamic> snapshot;

  @override
  State<_ShareDialog> createState() => _ShareDialogState();
}

class _ShareDialogState extends State<_ShareDialog> {
  late final _edges = widget.store.connections;
  bool _sending = false;
  String? _message;

  Future<void> _send(String recipient, Future<void> Function() send) async {
    if (_sending) return;
    setState(() {
      _sending = true;
      _message = null;
    });
    try {
      await send();
      if (!mounted) return;
      ScaffoldMessenger.maybeOf(
        context,
      )?.showSnackBar(SnackBar(content: Text('Sent to $recipient')));
      Navigator.pop(context);
    } catch (error) {
      if (mounted)
        setState(() {
          _message = packReadyConnectionError(error);
          _sending = false;
        });
    }
  }

  Widget _recipient(
    FlutterFlowTheme theme,
    String label,
    Future<void> Function() send,
  ) =>
      ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(Icons.person_outline, color: theme.primary),
        title: Text(
          label,
          style: theme.bodyMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(Icons.send_outlined, size: 18, color: theme.primary),
        enabled: !_sending,
        onTap: _sending ? null : () => _send(label, send),
      );

  Future<void> _shareByText() async {
    final data = widget.snapshot;
    final text = [
      "${data['name']} — PackReady ${widget.kind}",
      data['activity'] as String,
      '',
      for (final item in data['items'] as List<Map<String, dynamic>>)
        "• ${item['name']}${(item['detail'] as String).isEmpty ? '' : ' — ${item['detail']}'}",
    ].join('\n').trimRight();
    final apple = defaultTargetPlatform == TargetPlatform.iOS;
    final sms = Uri(scheme: 'sms', query: 'body=${Uri.encodeComponent(text)}');
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Share by Text'),
        scrollable: true,
        content: SelectableText(text),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: text));
              if (!dialogContext.mounted) return;
              ScaffoldMessenger.maybeOf(
                dialogContext,
              )?.showSnackBar(const SnackBar(content: Text('Text copied')));
              Navigator.pop(dialogContext);
            },
            child: const Text('Copy text'),
          ),
          FilledButton(
            onPressed: () async {
              try {
                if (apple) {
                  final box = dialogContext.findRenderObject() as RenderBox;
                  final result = await SharePlus.instance.share(
                    ShareParams(
                      text: text,
                      sharePositionOrigin:
                          box.localToGlobal(Offset.zero) & box.size,
                    ),
                  );
                  if (!kIsWeb || result.status != ShareResultStatus.unavailable)
                    return;
                } else if (await launchUrl(
                  sms,
                  mode: LaunchMode.externalApplication,
                  webOnlyWindowName: '_self',
                )) {
                  return;
                }
              } catch (_) {
                // The text is still available to copy when no handler opens.
              }
              if (!dialogContext.mounted) return;
              ScaffoldMessenger.maybeOf(dialogContext)?.showSnackBar(
                const SnackBar(
                  content: Text(
                    'Messages is unavailable. You can copy the text instead.',
                  ),
                ),
              );
            },
            child: Text(apple ? 'Open Share Sheet' : 'Open Messages'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return AlertDialog(
      backgroundColor: theme.secondaryBackground,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: theme.alternate),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      title: Text('Share ${widget.kind}', style: theme.titleLarge),
      content: SizedBox(
        width: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.snapshot['name'] as String,
              style: theme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.sms_outlined, color: theme.primary),
              title: Text('Share by Text', style: theme.bodyMedium),
              onTap: _sending ? null : _shareByText,
            ),
            Text('Send to a connection', style: theme.labelMedium),
            const SizedBox(height: 6),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * .33,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FutureBuilder<SharedPreferences>(
                      future: widget.store.demoPrefs,
                      builder: (context, prefs) => Column(
                        children: [
                          for (final friend in widget.store.demoConnections(
                            prefs.data,
                          ))
                            _recipient(
                              theme,
                              friend.label,
                              () => widget.store.sendDemo(
                                friend,
                                widget.kind,
                                widget.snapshot['name'] as String,
                              ),
                            ),
                        ],
                      ),
                    ),
                    StreamBuilder<List<PackReadyConnectionDoc>>(
                      stream: _edges,
                      builder: (context, snapshot) {
                        if (snapshot.hasError)
                          return _notice(
                              theme, packReadyConnectionError(snapshot.error!));
                        if (!snapshot.hasData)
                          return const LinearProgressIndicator();
                        final peers = snapshot.data!
                            .where((edge) => edge['status'] == 'accepted')
                            .toList()
                          ..sort(
                            (a, b) => widget.store
                                .peerHandle(a)
                                .compareTo(widget.store.peerHandle(b)),
                          );
                        if (peers.isEmpty) return const SizedBox.shrink();
                        return Column(
                          children: [
                            for (final edge in peers)
                              _recipient(
                                theme,
                                widget.store.peerHandle(edge),
                                () => widget.store.send(
                                  edge,
                                  widget.kind,
                                  widget.snapshot,
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (_sending) const LinearProgressIndicator(),
            if (_message != null) _notice(theme, _message!),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

Widget _notice(FlutterFlowTheme theme, String text) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Semantics(
        liveRegion: true,
        child: Text(
          text,
          style: theme.bodySmall.copyWith(color: theme.secondaryText),
        ),
      ),
    );
