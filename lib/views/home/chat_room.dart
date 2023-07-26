import '../widgets/hex_text.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBG,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBG,
        elevation: 0,
        centerTitle: true,
        title: HexText(
          'Zaire Saris',
          fontSize: 20.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: FooterLayout(
          footer: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: InputWidget(
                    controller: controller,
                    onChanged: (a) {
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: 14.h),
                Image.asset('attach'.png, height: 50.h),
              ],
            ),
          ),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: ListView.builder(
              shrinkWrap: true,
              reverse: true,
              physics: const ClampingScrollPhysics(),
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: 22,
              itemBuilder: (_, i) {
                return ChatBubble(i: i);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class InputWidget extends StatefulWidget {
  const InputWidget(
      {super.key,
      required this.controller,
      this.onChanged,
      this.openKeyboard = false});

  final TextEditingController controller;
  final Function(String)? onChanged;
  final bool openKeyboard;
  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      autofocus: widget.openKeyboard,
      suffix: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              if (widget.controller.text.trim().isEmpty) return;
              widget.controller.clear();
            },
            icon: Image.asset('send2'.png, height: 24.h),
          )
        ],
      ),
      prefix: widget.controller.text.isNotEmpty
          ? null
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.h),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
      controller: widget.controller,
      onChanged: widget.onChanged,
      padding: EdgeInsets.only(right: 8.h, top: 12.h, bottom: 12.h, left: 8.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary),
      ),
      maxLines: 3,
      minLines: 1,
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.i});

  final int i;
  @override
  Widget build(BuildContext context) {
    bool isMine = i.isOdd;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isMine) SizedBox(width: 30.h),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment:
                  isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isMine)
                  Padding(
                    padding: EdgeInsets.only(right: 4.h),
                    child: CircleAvatar(
                      radius: 12.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24.h),
                        child: Image.asset(
                          'placeholder'.png,
                          height: 24.h,
                        ),
                      ),
                    ),
                  ),
                if (isMine)
                  Padding(
                    padding: EdgeInsets.only(right: 6.h),
                    child: HexText(
                      '5:30PM',
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                      color: Colors.grey,
                    ),
                  ),
                if (isMine)
                  Padding(
                    padding: EdgeInsets.only(right: 6.h),
                    child: Icon(
                      Icons.done_all_rounded,
                      color: Colors.grey,
                      size: 20.h,
                    ),
                  ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                      color:
                          isMine ? const Color(0xffF0F2F5) : AppColors.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomRight:
                            isMine ? Radius.zero : const Radius.circular(12),
                        bottomLeft:
                            !isMine ? Radius.zero : const Radius.circular(12),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.02),
                          blurRadius: 1,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: HexText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: isMine ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                if (isMine)
                  Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: CircleAvatar(
                      radius: 12.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24.h),
                        child: Image.asset(
                          'placeholder'.png,
                          height: 24.h,
                        ),
                      ),
                    ),
                  ),
                if (!isMine)
                  Padding(
                    padding: EdgeInsets.only(left: 6.h),
                    child: HexText(
                      '5:30PM',
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                      color: isMine ? Colors.white54 : Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
          if (!isMine) SizedBox(width: 30.h),
        ],
      ),
    );
  }
}
