class ConnectChannelModel {
  ConnectChannelModel({
    this.token,
    this.channelId,
    this.id,
  });

  String? token;
  String? channelId;
  String? id;

  factory ConnectChannelModel.fromJson(Map<String, dynamic> json) =>
      ConnectChannelModel(
        token: json["token"],
        channelId: json["channelId"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "channelId": channelId,
        "id": id,
      };
}
