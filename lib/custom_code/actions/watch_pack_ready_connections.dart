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

import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:shared_preferences/shared_preferences.dart';
import '/auth/firebase_auth/auth_util.dart';

typedef PackReadyConnectionDoc = QueryDocumentSnapshot<Map<String, dynamic>>;

typedef PackReadyDemoShare = ({
  String id,
  String kind,
  Map<String, dynamic> snapshot
});

enum PackReadyDemoFriend {
  maya(
    'Maya#4829',
    'Travel',
    'Weekend essentials',
    'City weekend',
    ['Phone charger', 'Walking shoes'],
    ['Day bag', 'Water bottle'],
  ),
  jordan(
    'Jordan#7316',
    'Camping',
    'Camp setup',
    'Lakeside overnight',
    ['Tent', 'Headlamp'],
    ['Sleeping bag', 'Rain jacket'],
  ),
  avery('Avery#3051', 'Custom', '', '', [], []);

  static const sentTag = 'Casey#6140';

  static bool reserves(String key) =>
      key == sentTag.toLowerCase() ||
      values.any((friend) => friend.tag.toLowerCase() == key);

  const PackReadyDemoFriend(
    this.tag,
    this.activity,
    this.template,
    this.trip,
    this.templateItems,
    this.tripItems,
  );

  final String tag, activity, template, trip;
  String get label => '$tag · Demo friend';
  final List<String> templateItems, tripItems;

  Iterable<PackReadyDemoShare> get shares sync* {
    if (template.isEmpty) return;
    yield _share('template', template, templateItems);
    yield _share('activity', trip, tripItems);
  }

  PackReadyDemoShare _share(String kind, String title, List<String> items) => (
        id: 'demo_${name}_$kind',
        kind: kind,
        snapshot: {
          'name': title,
          'activity': activity,
          'items': [
            for (final item in items)
              {'name': item, 'detail': '', 'category': 'Gear', 'packed': false},
          ],
        },
      );
}

class PackReadyConnectionsStore {
  PackReadyConnectionsStore(this.uid);

  final String uid;
  final db = FirebaseFirestore.instance;
  late final demoPrefs = SharedPreferences.getInstance();
  String _demoKey(String key) => 'packready.connections.$uid.$key';

  String? demoReply(SharedPreferences? prefs) =>
      prefs?.getString(_demoKey('incoming_request'));

  bool demoSentPending(SharedPreferences? prefs) =>
      !(prefs?.getBool(_demoKey('sent_request_cancelled')) ?? false);

  Iterable<PackReadyDemoFriend> demoConnections(SharedPreferences? prefs) =>
      PackReadyDemoFriend.values.where(
        (friend) =>
            friend != PackReadyDemoFriend.avery ||
            demoReply(prefs) == 'accepted',
      );

  Future<void> respondDemo(bool accept) async {
    final prefs = await demoPrefs;
    if (!await prefs.setString(
      _demoKey('incoming_request'),
      accept ? 'accepted' : 'declined',
    )) {
      throw const FormatException('Could not save the demo request.');
    }
  }

  Future<void> cancelDemo() async {
    final prefs = await demoPrefs;
    if (!await prefs.setBool(_demoKey('sent_request_cancelled'), true)) {
      throw const FormatException('Could not cancel the demo request.');
    }
  }

  bool demoAdded(SharedPreferences? prefs, PackReadyDemoShare share) =>
      prefs?.getBool(_demoKey(share.id)) ?? false;

  List<String> demoSent(SharedPreferences? prefs, PackReadyDemoFriend friend) =>
      prefs?.getStringList(_demoKey('sent_${friend.name}')) ?? const [];

  Future<void> addDemo(PackReadyDemoShare share) async {
    final prefs = await demoPrefs;
    if (demoAdded(prefs, share)) return;
    final copy = _copyRef(share.kind, share.id);
    await db.runTransaction((tx) async {
      if (!(await tx.get(copy)).exists) {
        tx.set(copy, _copyData(share.kind, share.snapshot));
      }
    });
    if (!await prefs.setBool(_demoKey(share.id), true)) {
      throw const FormatException('Couldn’t save the demo add status.');
    }
  }

  Future<void> sendDemo(
      PackReadyDemoFriend friend, String kind, String title) async {
    final prefs = await demoPrefs;
    if (!await prefs.setStringList(_demoKey('sent_${friend.name}'), [
      '$title · $kind',
      ...demoSent(prefs, friend),
    ])) {
      throw const FormatException('Couldn’t save the demo share.');
    }
  }

  static final _pattern = RegExp(
    r'^[^#/\x00-\x1f\x7f]{1,80}#[0-9]{4}$',
    unicode: true,
  );

  CollectionReference<Map<String, dynamic>> get handles =>
      db.collection('connection_handles');
  CollectionReference<Map<String, dynamic>> get edges =>
      db.collection('connections');
  CollectionReference<Map<String, dynamic>> get shares =>
      db.collection('shared_items');
  DocumentReference<Map<String, dynamic>> get profile =>
      db.collection('users').doc(uid);

  Stream<List<PackReadyConnectionDoc>> get connections =>
      edges.where('members', arrayContains: uid).snapshots().map((s) => s.docs);
  Stream<List<PackReadyConnectionDoc>> incomingShares(String sender) => shares
      .where('recipientId', isEqualTo: uid)
      .where('senderId', isEqualTo: sender)
      .snapshots()
      .map((s) => s.docs);

  Stream<Map<String, int>> get newShareCounts => shares
          .where('recipientId', isEqualTo: uid)
          .where('added', isEqualTo: false)
          .snapshots()
          .map((snapshot) {
        final counts = <String, int>{};
        for (final share in snapshot.docs) {
          final sender = share['senderId'] as String;
          counts.update(sender, (count) => count + 1, ifAbsent: () => 1);
        }
        return counts;
      });

  bool outgoing(PackReadyConnectionDoc edge) => edge['requesterId'] == uid;
  String peerId(PackReadyConnectionDoc edge) =>
      edge[outgoing(edge) ? 'recipientId' : 'requesterId'] as String;
  String peerHandle(PackReadyConnectionDoc edge) =>
      edge[outgoing(edge) ? 'recipientHandle' : 'requesterHandle'] as String;

  Future<String> ensureTag(String fallbackName) async {
    try {
      final data = (await profile.get()).data();
      final existing = (data?['connectionTag'] as String?)?.trim();
      if (existing != null &&
          _pattern.hasMatch(existing) &&
          !PackReadyDemoFriend.reserves(existing.toLowerCase())) {
        return existing;
      }
    } on FirebaseException {
      // Fall through to the callable tag provisioner.
    }

    try {
      final callable = FirebaseFunctions.instanceFor(region: 'us-central1')
          .httpsCallable('packReadyEnsureConnectionTag');
      final response = await callable.call<dynamic>(<String, dynamic>{
        'fallbackName': fallbackName.trim(),
      });
      final payload = response.data;
      final tag = payload is Map ? (payload['tag'] as String?)?.trim() : null;
      if (tag != null && _pattern.hasMatch(tag)) {
        return tag;
      }
    } on FirebaseFunctionsException catch (error) {
      if (error.code != 'not-found' && error.code != 'unimplemented') {
        rethrow;
      }
    }

    return _ensureTagClientTransaction(fallbackName);
  }

  Future<String> _ensureTagClientTransaction(String fallbackName) async {
    final start = Random.secure().nextInt(10000);
    for (var offset = 0; offset < 10000; offset++) {
      final code = ((start + offset) % 10000).toString().padLeft(4, '0');
      final reserved = await db.runTransaction<String?>((tx) async {
        final data = (await tx.get(profile)).data();
        final existing = data?['connectionTag'] as String?;
        if (existing != null) return existing;
        final displayName = (data?['display_name'] as String?)?.trim();
        final cleaned = (displayName == null || displayName.isEmpty
                ? fallbackName
                : displayName)
            .replaceAll(RegExp(r'[#/\x00-\x1f\x7f]'), ' ')
            .trim();
        final name = cleaned.isEmpty
            ? 'PackReady'
            : String.fromCharCodes(cleaned.runes.take(80)).trimRight();
        final tag = '$name#$code';
        final key = tag.toLowerCase();
        if (PackReadyDemoFriend.reserves(key)) return null;
        final ref = handles.doc(key);
        if ((await tx.get(ref)).exists) return null;
        tx.set(ref, {'uid': uid, 'handle': tag});
        tx.set(profile, {'connectionTag': tag}, SetOptions(merge: true));
        return tag;
      });
      if (reserved != null) return reserved;
    }
    throw const FormatException('All tags for this display name are taken.');
  }

  Future<void> request(String text, String ownTag) async {
    final tag = text.trim();
    if (!_pattern.hasMatch(tag) || tag.split('#').first.trim().isEmpty) {
      throw const FormatException('Enter a tag like Mason#4829.');
    }
    final key = tag.toLowerCase();
    if (PackReadyDemoFriend.reserves(key)) {
      throw const FormatException(
        'Demo friends are managed in Connections and Requests.',
      );
    }
    final target = (await handles.doc(key).get()).data();
    if (target == null)
      throw const FormatException('No one was found with that tag.');
    final recipient = target['uid'] as String;
    if (recipient == uid)
      throw const FormatException('That is your own handle.');
    final forward = edges.doc('$uid~$recipient');
    final reverse = edges.doc('$recipient~$uid');
    await db.runTransaction((tx) async {
      final sent = await tx.get(forward);
      final received = await tx.get(reverse);
      final existing = sent.data() ?? received.data();
      if (existing != null) {
        throw FormatException(
          existing['status'] == 'accepted'
              ? 'You are already connected.'
              : 'A request is already pending.',
        );
      }
      tx.set(forward, {
        'requesterId': uid,
        'recipientId': recipient,
        'requesterHandle': ownTag,
        'recipientHandle': target['handle'],
        'members': [uid, recipient],
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });
    });
  }

  Future<void> respond(
          DocumentReference<Map<String, dynamic>> edge, bool accept) =>
      accept ? edge.update({'status': 'accepted'}) : cancelRequest(edge);

  Future<void> cancelRequest(DocumentReference<Map<String, dynamic>> edge) =>
      edge.delete();

  Future<void> send(PackReadyConnectionDoc edge, String kind,
          Map<String, dynamic> snapshot) =>
      shares.doc().set({
        'senderId': uid,
        'recipientId': peerId(edge),
        'connectionId': edge.id,
        'kind': kind,
        'snapshot': snapshot,
        'added': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

  Future<void> add(DocumentReference<Map<String, dynamic>> share) =>
      db.runTransaction((tx) async {
        final data = (await tx.get(share)).data();
        if (data == null || data['recipientId'] != uid) {
          throw const FormatException('This share is no longer available.');
        }
        if (data['added'] == true) return;
        final snapshot = Map<String, dynamic>.from(data['snapshot'] as Map);
        final items = snapshot['items'] as List;
        if (items.any(
          (item) =>
              item is! Map ||
              item['name'] is! String ||
              item['detail'] is! String ||
              item['category'] is! String ||
              item['packed'] != false,
        )) {
          throw const FormatException(
            'This share contains unsupported checklist items.',
          );
        }
        final kind = data['kind'] as String;
        tx.set(_copyRef(kind, share.id), _copyData(kind, snapshot));
        tx.update(share, {
          'added': true,
          'addedAt': FieldValue.serverTimestamp(),
        });
      });

  DocumentReference<Map<String, dynamic>> _copyRef(String kind, String id) =>
      profile
          .collection(
            kind == 'template' ? 'checklistTemplates' : 'packingLists',
          )
          .doc('shared_$id');

  Map<String, dynamic> _copyData(String kind, Map<String, dynamic> snapshot) {
    final activity = snapshot['activity'];
    return {
      'activity': activity,
      'items': snapshot['items'],
      'createdTime': FieldValue.serverTimestamp(),
      if (kind == 'template') ...{
        'name': snapshot['name'],
        'starterName': activity == 'Custom' ? '' : activity,
        'finished': false,
        'updatedTime': FieldValue.serverTimestamp(),
      } else ...{
        'tripName': snapshot['name'],
        'completed': false,
        'recurring': false,
      },
    };
  }
}

Future<String> ensurePackReadyConnectionTag(String uid, String displayName) =>
    PackReadyConnectionsStore(uid).ensureTag(displayName);

String packReadyConnectionError(Object error) {
  if (error is FormatException) return error.message;
  if (error is FirebaseException && error.code == 'permission-denied') {
    return 'Connections data is unavailable.';
  }
  return 'Couldn’t complete that. Please try again.';
}

final _connectionWatches = <_ConnectionsWatch>{};

Future<void> watchPackReadyConnections(
  BuildContext context,
  String peerId,
  String demoId,
) async {
  final watch = _ConnectionsWatch(context, peerId, demoId);
  _connectionWatches.add(watch);
  watch.start();
}

class _ConnectionsWatch {
  _ConnectionsWatch(this.context, this.peerId, this.demoId);

  final BuildContext context;
  final String peerId, demoId;
  bool get isSheet => peerId.isNotEmpty || demoId.isNotEmpty;
  PackReadyConnectionsStore? store;
  SharedPreferences? prefs;
  List<PackReadyConnectionDoc> edges = [], shares = [];
  Map<String, int> counts = {};
  String status = 'loading', tagStatus = 'loading', tag = '', error = '';
  bool stopped = false;
  final queries = <StreamSubscription<dynamic>>[];
  StreamSubscription<auth.User?>? authChanges;
  Timer? lifetime;

  void start() {
    final firebaseAuth = auth.FirebaseAuth.instance;
    bind(firebaseAuth.currentUser);
    authChanges = firebaseAuth.authStateChanges().listen((user) {
      if (user?.uid != store?.uid) bind(user);
    });
    final host = ModalRoute.of(context);
    if (host != null) unawaited(host.popped.then((_) => stop()));
    // Embedded shell children can unmount while their host stays alive.
    lifetime = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!context.mounted) stop();
    });
  }

  void stop() {
    if (stopped) return;
    stopped = true;
    _connectionWatches.remove(this);
    lifetime?.cancel();
    unawaited(authChanges?.cancel());
    clearQueries();
  }

  void clearQueries() {
    for (final query in queries) {
      unawaited(query.cancel());
    }
    queries.clear();
  }

  bool active(PackReadyConnectionsStore source) =>
      !stopped && context.mounted && identical(store, source);

  void bind(auth.User? user) {
    clearQueries();
    store = user == null ? null : PackReadyConnectionsStore(user.uid);
    prefs = null;
    edges = [];
    shares = [];
    counts = {};
    status = user == null ? 'signedOut' : 'loading';
    tagStatus = 'loading';
    tag = error = '';
    publish();
    final source = store;
    if (source == null) return;
    void failed(Object failure) {
      if (!active(source)) return;
      status = 'error';
      error = packReadyConnectionError(failure);
      publish();
    }

    unawaited(source.demoPrefs.then((value) {
      if (!active(source)) return;
      prefs = value;
      if (isSheet && demoId.isNotEmpty) status = 'ready';
      publish();
    }, onError: failed));

    if (isSheet) {
      if (demoId.isEmpty) {
        queries.add(source.incomingShares(peerId).listen((docs) {
          if (!active(source)) return;
          shares = docs.toList()
            ..sort((a, b) {
              final earlier = a.data()['createdAt'] as Timestamp?;
              final later = b.data()['createdAt'] as Timestamp?;
              return (later?.millisecondsSinceEpoch ?? 0)
                  .compareTo(earlier?.millisecondsSinceEpoch ?? 0);
            });
          status = 'ready';
          error = '';
          publish();
        }, onError: failed));
      }
      return;
    }

    queries.add(source.connections.listen((docs) {
      if (!active(source)) return;
      edges = docs;
      status = 'ready';
      error = '';
      publish();
    }, onError: failed));
    queries.add(source.newShareCounts.listen((value) {
      if (!active(source)) return;
      counts = value;
      publish();
    }, onError: (Object _) {}));
    unawaited(provisionTag());
  }

  Future<void> provisionTag() async {
    final source = store;
    if (source == null || isSheet) return;
    tagStatus = 'loading';
    publish();
    try {
      final value = await source.ensureTag(currentUserDisplayName);
      if (!active(source)) return;
      tag = value;
      tagStatus = 'ready';
    } catch (_) {
      if (!active(source)) return;
      tagStatus = 'error';
    }
    publish();
  }

  void publish() {
    if (stopped || !context.mounted) return;
    final source = store;
    final view = PackReadyConnectionsDataStruct(
      uid: source?.uid,
      status: status,
      tagStatus: tagStatus,
      tag: tag,
      error: error,
      sheetKey: demoId.isNotEmpty ? demoId : peerId,
      templates: [],
      activities: [],
      connections: [],
      incoming: [],
      sent: [],
    );
    if (source != null) {
      if (isSheet) {
        void addRow(String id, String kind, Map snapshot, bool added) {
          final count = (snapshot['items'] as List).length;
          final row = PackReadyConnectionRowStruct(
            id: id,
            label: snapshot['name'] as String,
            detail:
                '${snapshot['activity']} · $count ${count == 1 ? 'item' : 'items'}',
            added: added,
          );
          (kind == 'template' ? view.templates : view.activities).add(row);
        }

        if (demoId.isNotEmpty) {
          final friend = PackReadyDemoFriend.values.byName(demoId);
          for (final share in friend.shares) {
            addRow(share.id, share.kind, share.snapshot,
                source.demoAdded(prefs, share));
          }
          view.history = source.demoSent(prefs, friend);
        } else {
          for (final share in shares) {
            addRow(share.id, share['kind'] as String, share['snapshot'] as Map,
                share['added'] == true);
          }
        }
      } else {
        for (final friend in source.demoConnections(prefs)) {
          view.connections.add(PackReadyConnectionRowStruct(
            id: 'demo:${friend.name}',
            label: friend.label,
            demoId: friend.name,
            count: friend.shares
                .where((share) => !source.demoAdded(prefs, share))
                .length,
          ));
        }
        final real = <PackReadyConnectionRowStruct>[];
        for (final edge in edges) {
          final peer = source.peerId(edge);
          final row = PackReadyConnectionRowStruct(
            id: edge.id,
            label: source.peerHandle(edge),
            peerId: peer,
            count: counts[peer] ?? 0,
          );
          if (edge['status'] == 'accepted') {
            real.add(row);
          } else if (edge['status'] == 'pending') {
            (source.outgoing(edge) ? view.sent : view.incoming).add(row);
          }
        }
        real.sort((a, b) => a.label.compareTo(b.label));
        view.connections.addAll(real);
        if (source.demoReply(prefs) == null) {
          view.incoming.insert(
              0,
              PackReadyConnectionRowStruct(
                id: 'demo:avery',
                label: PackReadyDemoFriend.avery.label,
              ));
        }
        if (source.demoSentPending(prefs)) {
          view.sent.insert(
              0,
              PackReadyConnectionRowStruct(
                id: 'demo:casey',
                label: '${PackReadyDemoFriend.sentTag} · Demo friend',
              ));
        }
      }
    }

    final app = FFAppState();
    app.update(() {
      if (isSheet) {
        app.packReadySharedWithYou = view;
      } else {
        app.packReadyConnectionsData = view;
      }
    });
  }
}

Future<void> retryPackReadyConnectionTag() async {
  final active = _connectionWatches
      .where((watch) => !watch.isSheet && watch.store?.uid == currentUserUid);
  await Future.wait(active.map((watch) => watch.provisionTag()));
}

void refreshPackReadyDemoConnections(String uid) {
  for (final watch in _connectionWatches) {
    if (watch.store?.uid == uid) watch.publish();
  }
}
