import 'dart:math';

import 'package:app/widgets.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer' as developer;

class VideoProvider with ChangeNotifier {
  late RtcEngine? _engine;
  bool _local = false;
  int? _remoteUid;

  bool get local => _local;
  int? get remoteUid => _remoteUid;

  set local(bool local) {
    _local = local;
    notifyListeners();
  }

  set remoteUid(int? remoteUid) {
    _remoteUid = remoteUid;
    notifyListeners();
  }

  init({required String channel}) async {
    await [Permission.microphone, Permission.camera].request();

    _engine = await RtcEngine.create(dotenv.env['AGORA_KEY']!);
    await _engine!.enableLocalVideo(true);
    await _engine!.enableVideo();

    _engine!.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          developer.log('CHANNEL: $channel');
          // print("local user $uid joined");
          _local = true;
        },
        userJoined: (int uid, int elapsed) {
          developer.log('UID: $uid');
          _remoteUid = uid;
        },
        userOffline: (int uid, UserOfflineReason reason) {
          _remoteUid = null;
        },
      ),
    );

    int ts = DateTime.now().millisecondsSinceEpoch;
    int max = 100;
    int id = Random().nextInt(max);
    await _engine?.joinChannel(dotenv.env['AGORA_TOKEN'], channel, null, id);

    notifyListeners();
  }

  startVideo() {
    _engine!.startPreview();
    _engine!.enableVideo();
  }

  stopVideo() {
    _engine!.stopPreview();
    _engine!.disableVideo();
    _engine!.enableLocalVideo(true);
  }

  switchCamera() {
    _engine!.switchCamera();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _engine!.destroy();
  }
}
