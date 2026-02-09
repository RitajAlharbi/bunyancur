import 'package:flutter/material.dart';

import '../model/notification_model.dart';

class NotificationsController extends ChangeNotifier {
  NotificationsController() {
    _loadMockData();
  }

  final List<NotificationModel> _items = [];

  List<NotificationModel> get items => List.unmodifiable(_items);

  void markAsRead(String id) {
    final index = _items.indexWhere((e) => e.id == id);
    if (index >= 0) {
      _items[index] = NotificationModel(
        id: _items[index].id,
        text: _items[index].text,
        timeAgo: _items[index].timeAgo,
        isUnread: false,
        iconType: _items[index].iconType,
      );
      notifyListeners();
    }
  }

  void _loadMockData() {
    _items.addAll(const [
      NotificationModel(
        id: '1',
        text: 'تم قبول عرضك لمشروع بناء فيلا سكنية.',
        timeAgo: 'منذ 3 ساعات',
        isUnread: true,
        iconType: NotificationIconType.approval,
      ),
      NotificationModel(
        id: '2',
        text: 'العميل وافق على تقرير المرحلة الثانية.',
        timeAgo: 'منذ 5 ساعات',
        isUnread: true,
        iconType: NotificationIconType.approval,
      ),
      NotificationModel(
        id: '3',
        text: 'تم استلام الدفعة الخاصة بمرحلة الحفر.',
        timeAgo: 'منذ يوم واحد',
        isUnread: false,
        iconType: NotificationIconType.payment,
      ),
      NotificationModel(
        id: '4',
        text: 'العميل أرسل ملاحظة جديدة على مرحلة التشطيب.',
        timeAgo: 'منذ يومين',
        isUnread: false,
        iconType: NotificationIconType.message,
      ),
      NotificationModel(
        id: '5',
        text: 'يوجد مشروع جديد متاح بالقرب من منطقتك.',
        timeAgo: 'منذ 3 أيام',
        isUnread: false,
        iconType: NotificationIconType.projectNearby,
      ),
      NotificationModel(
        id: '6',
        text: 'تم رفض التقرير، يرجى التعديل وإعادة الإرسال.',
        timeAgo: 'منذ 4 أيام',
        isUnread: false,
        iconType: NotificationIconType.rejection,
      ),
    ]);
    notifyListeners();
  }
}
