import 'package:app/tools/pallete.dart';
import 'package:app/view/widgets/button.dart';
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:app/viewmodel/video_provider.dart';
import 'package:provider/provider.dart';

import '../widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<VideoProvider>(context, listen: false).init(channel: 'test');
  }

  @override
  void dispose() {
    super.dispose();

    final p = Provider.of<VideoProvider>(context, listen: false);
    p.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final p = Provider.of<VideoProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
              height: size.height * .70,
              width: double.infinity,
              color: Colors.white,
              child: p.remoteUid != null
                  ? RtcRemoteView.SurfaceView(
                      uid: p.remoteUid!,
                      channelId: 'test',
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )),
          Expanded(
            child: Container(
              color: Colors.blue,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.yellow,
                      child: p.local
                          ? Stack(
                              children: [
                                const RtcLocalView.SurfaceView(),
                                Positioned(
                                  right: 10,
                                  top: 10,
                                  child: InkWell(
                                    onTap: () {
                                      p.switchCamera();
                                    },
                                    child: const Icon(
                                      Icons.switch_camera_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Button(
                            text: 'Start',
                            backgroundColor: Pallete.primary,
                            onPressed: p.remoteUid == null
                                ? null
                                : () {
                                    p.startVideo();
                                  },
                          ),
                          Button(
                            text: 'Stop',
                            backgroundColor: Pallete.secondary,
                            onPressed: () {
                              p.stopVideo();
                            },
                          ),
                          Button(
                            text: 'Place: All',
                            backgroundColor: Pallete.tertiary,
                          ),
                          Button(
                            text: 'Female',
                            backgroundColor: Pallete.tertiary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
