import 'package:flutter/foundation.dart';
import '../models/chat_message_model.dart';
import '../models/message_thread_model.dart';

class MessagesController extends ChangeNotifier {
  final List<MessageThreadModel> _threads = [
    const MessageThreadModel(
      id: 't1',
      name: 'أحمد محمد',
      lastMessage: 'ما هي الأسعار المتاحة؟',
      timeLabel: 'الآن',
      unreadCount: 2,
      isOnline: true,
      avatarInitial: 'أم',
    ),
    const MessageThreadModel(
      id: 't2',
      name: 'مؤسسة الإنشاءات الحديثة',
      lastMessage: 'شكراً لك، سنراجع العرض ونرد عليك قريباً',
      timeLabel: 'منذ 5 د',
      unreadCount: 1,
      isOnline: false,
      avatarInitial: 'إ',
    ),
    const MessageThreadModel(
      id: 't3',
      name: 'سارة العتيبي',
      lastMessage: 'ممتاز، لنبدأ بالخطوة الأولى',
      timeLabel: 'منذ 15 د',
      unreadCount: 0,
      isOnline: true,
      avatarInitial: 'س',
    ),
  ];

  final Map<String, List<ChatMessageModel>> _messages = {
    't1': [
      const ChatMessageModel(
        id: 'm3',
        threadId: 't1',
        text: 'نعم، يمكننا توفير عدة خيارات حسب المقاس.',
        timeLabel: '10:18 ص',
        isMe: true,
        isRead: true,
      ),
      const ChatMessageModel(
        id: 'm2',
        threadId: 't1',
        text: 'هل لديك كتالوج الأسعار؟',
        timeLabel: '10:16 ص',
        isMe: false,
        isRead: true,
      ),
      const ChatMessageModel(
        id: 'm1',
        threadId: 't1',
        text: 'ما هي الأسعار المتاحة؟',
        timeLabel: '10:15 ص',
        isMe: false,
        isRead: true,
      ),
    ],
    't2': [
      const ChatMessageModel(
        id: 'm4',
        threadId: 't2',
        text: 'شكراً لك، سنراجع العرض ونرد عليك قريباً',
        timeLabel: '09:40 ص',
        isMe: false,
        isRead: false,
      ),
    ],
    't3': [
      const ChatMessageModel(
        id: 'm5',
        threadId: 't3',
        text: 'ممتاز، لنبدأ بالخطوة الأولى',
        timeLabel: '08:22 ص',
        isMe: false,
        isRead: true,
      ),
    ],
  };

  List<MessageThreadModel> get threads => List.unmodifiable(_threads);

  MessageThreadModel? getThreadById(String threadId) {
    try {
      return _threads.firstWhere((thread) => thread.id == threadId);
    } catch (_) {
      return null;
    }
  }

  List<ChatMessageModel> messagesForThread(String threadId) {
    return List.unmodifiable(_messages[threadId] ?? []);
  }

  void openThread(String threadId) {
    markAsRead(threadId);
  }

  void sendMessage(String threadId, String text) {
    if (text.trim().isEmpty) return;
    final message = ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      threadId: threadId,
      text: text.trim(),
      timeLabel: 'الآن',
      isMe: true,
      isRead: true,
    );
    final list = _messages[threadId] ?? [];
    _messages[threadId] = [message, ...list];

    final index = _threads.indexWhere((thread) => thread.id == threadId);
    if (index != -1) {
      _threads[index] = _threads[index].copyWith(
        lastMessage: message.text,
        timeLabel: message.timeLabel,
      );
    }
    notifyListeners();
  }

  void markAsRead(String threadId) {
    final index = _threads.indexWhere((thread) => thread.id == threadId);
    if (index == -1) return;
    if (_threads[index].unreadCount == 0) return;
    _threads[index] = _threads[index].copyWith(unreadCount: 0);
    notifyListeners();
  }
}
