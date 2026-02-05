class MessageThreadModel {
  final String id;
  final String name;
  final String lastMessage;
  final String timeLabel;
  final int unreadCount;
  final bool isOnline;
  final String avatarInitial;

  const MessageThreadModel({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.timeLabel,
    required this.unreadCount,
    required this.isOnline,
    required this.avatarInitial,
  });

  MessageThreadModel copyWith({
    String? id,
    String? name,
    String? lastMessage,
    String? timeLabel,
    int? unreadCount,
    bool? isOnline,
    String? avatarInitial,
  }) {
    return MessageThreadModel(
      id: id ?? this.id,
      name: name ?? this.name,
      lastMessage: lastMessage ?? this.lastMessage,
      timeLabel: timeLabel ?? this.timeLabel,
      unreadCount: unreadCount ?? this.unreadCount,
      isOnline: isOnline ?? this.isOnline,
      avatarInitial: avatarInitial ?? this.avatarInitial,
    );
  }
}
