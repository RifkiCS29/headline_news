part of 'widgets.dart';

class PlatformWidget extends StatelessWidget {
  final WidgetBuilder androidBuilder;
  final WidgetBuilder iosBuilder;
 
  const PlatformWidget({Key? key, required this.androidBuilder, required this.iosBuilder}) : super(key: key);

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