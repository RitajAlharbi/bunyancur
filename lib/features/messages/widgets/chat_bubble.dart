import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/chat_message_model.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessageModel message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;
    final bubbleColor = message.isMe ? AppColor.orange900 : AppColor.grey100;
    final textColor = message.isMe ? AppColor.white : AppColor.grey700;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: isMe ? 40.w : 0,
              right: isMe ? 0 : 40.w,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              message.text,
              textAlign: isMe ? TextAlign.right : TextAlign.left,
              textDirection: TextDirection.rtl,
              style: AppTextStyles.body.copyWith(color: textColor),
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            textDirection: isMe ? TextDirection.ltr : TextDirection.rtl,
            children: [
              if (isMe)
                Icon(
                  Icons.done_all,
                  size: 14.sp,
                  color: AppColor.grey200,
                ),
              if (isMe) SizedBox(width: 4.w),
              Text(
                message.timeLabel,
                textAlign: isMe ? TextAlign.right : TextAlign.left,
                textDirection: TextDirection.rtl,
                style: AppTextStyles.caption10.copyWith(color: AppColor.grey500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
