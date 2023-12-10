/// message : "Hi there, how can I help?"

class ChatBot {
  ChatBot({
      this.message,});

  ChatBot.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

}