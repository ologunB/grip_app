import 'hex_text.dart';

class RemoveGlow extends StatelessWidget {
  const RemoveGlow({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: child,
    );
  }
}
