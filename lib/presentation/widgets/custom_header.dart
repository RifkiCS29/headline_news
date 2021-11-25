part of 'widgets.dart';

class CustomHeader extends StatelessWidget {
  final Widget body;

  CustomHeader({required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [body, _buildShortAppBar(context)],
        ),
      ),
    );
  }

  Widget _buildShortAppBar(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: defaultTargetPlatform == TargetPlatform.iOS
                ? Icon(CupertinoIcons.back)
                : Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              'News',
              style: blackTextStyle.copyWith(fontSize: 16),
            ),
          ),
        ],
      ),
      shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(16.0)
            )
          ),
    );
  }
}