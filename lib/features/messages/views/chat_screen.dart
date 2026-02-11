import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/messages_controller.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  final String threadId;
  final String? displayName;

  const ChatScreen({
    super.key,
    required this.threadId,
    this.displayName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final MessagesController controller;
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = MessagesController();
    controller.openThread(widget.threadId);
  }

  @override
  void dispose() {
    textController.dispose();
    controller.dispose();
    super.dispose();
  }

  void _send() {
    controller.sendMessage(widget.threadId, textController.text);
    textController.clear();
  }

  String get _displayName {
    final thread = controller.getThreadById(widget.threadId);
    if (widget.displayName != null && widget.displayName!.isNotEmpty) {
      return widget.displayName!;
    }
    return thread?.name ?? '';
  }

  String get _avatarInitial {
    final name = _displayName;
    if (name.isEmpty) return '';
    return name.substring(0, 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          bottom: true,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 12.h),
                child: Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(12.r),
                      child: Padding(
                        padding: EdgeInsets.all(6.w),
                        child: Icon(
                          Icons.chevron_left,
                          color: AppColor.grey700,
                          size: 24.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            _displayName,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: AppTextStyles.body.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColor.grey700,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'متصل الآن',
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: AppTextStyles.caption12.copyWith(
                              color: AppColor.orange900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      width: 56.w,
                      height: 56.h,
                      decoration: const BoxDecoration(
                        color: AppColor.orange900,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          _avatarInitial,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: AppTextStyles.sectionTitle.copyWith(
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1.h, color: AppColor.grey200),
              Expanded(
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) {
                    final messages = controller.messagesForThread(widget.threadId);
                    if (messages.isEmpty) {
                      return Center(
                        child: Text(
                          'ابدأ الدردشة مع المقاول',
                          style: AppTextStyles.body.copyWith(
                            color: AppColor.grey600,
                          ),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ),
                      );
                    }
                    return ListView.builder(
                      reverse: true,
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: ChatBubble(message: message),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
                child: Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: const BoxDecoration(
                        color: AppColor.orange900,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.mic, color: AppColor.white, size: 20.sp),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Container(
                        height: 44.h,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          color: AppColor.grey100,
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.attach_file, color: AppColor.grey500, size: 20.sp),
                            SizedBox(width: 6.w),
                            Icon(Icons.emoji_emotions_outlined,
                                color: AppColor.grey500, size: 20.sp),
                            SizedBox(width: 6.w),
                            Expanded(
                              child: TextField(
                                controller: textController,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: AppTextStyles.body,
                                decoration: InputDecoration(
                                  hintText: 'اكتب رسالة...',
                                  hintStyle: AppTextStyles.body.copyWith(
                                    color: AppColor.grey400,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: _send,
                              icon: Icon(Icons.send, color: AppColor.orange900, size: 20.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
