part of 'widgets.dart';

class PlatformWidget extends StatelessWidget {
  final WidgetBuilder androidBuilder;
  final WidgetBuilder iosBuilder;
 
  PlatformWidget({required this.androidBuilder, required this.iosBuilder});

  @override
  Widget build(BuildContext context) {
    switch(defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidBuilder(context);
      case TargetPlatform.iOS:
        return iosBuilder(context);
      default:
        return androidBuilder(context);
    }
  }
}