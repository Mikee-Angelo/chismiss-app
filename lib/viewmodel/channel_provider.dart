import 'package:app/model/channels/connect_channel_model.dart';
import 'package:app/model/error_model.dart';
import 'package:app/services/channel_services.dart';
import 'package:app/widgets.dart';

class ChannelProvider with ChangeNotifier {
  String? _error;
  ConnectChannelModel? _channel;

  String? get error => _error;
  ConnectChannelModel? get channel => _channel;

  set error(String? error) {
    _error = error;

    notifyListeners();
  }

  set channel(ConnectChannelModel? channel) {
    _channel = channel;

    notifyListeners();
  }

  connect(String uid) async {
    final service = await ChannelServices.connect(uid: uid);

    if (service is ErrorModel) {
      error = service.message;
    }

    if (service is ConnectChannelModel) {
      channel = service;
    }
  }
}
