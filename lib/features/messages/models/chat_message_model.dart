class ChatMessageModel {
  final String id;
  final String threadId;
  final String text;
  final String timeLabel;
  final bool isMe;
  final bool isRead;

  const ChatMessageModel({
    required this.id,
    required this.threadId,
    required this.text,
    required this.timeLabel,
    required this.isMe,
    required this.isRead,
  });
}
