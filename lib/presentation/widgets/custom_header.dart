part of 'widgets.dart';

class CustomHeader extends StatelessWidget {
  final Widget body;

  const CustomHeader({Key? key, required this.body}) : super(key: key);

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
      margin: const EdgeInsets.all(0),
      shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(16.0),
            ),
          ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: defaultTargetPlatform == TargetPlatform.iOS
                ? const Icon(CupertinoIcons.back)
                : const Icon(Icons.arrow_back),
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
    );
  }
}