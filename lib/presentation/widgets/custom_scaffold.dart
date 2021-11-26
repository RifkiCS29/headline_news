part of 'widgets.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;

  CustomScaffold({required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 90),
              child: body,
            ), 
            _buildCustomAppBar(context)
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      color: Colors.white,
      height: 80,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Headline News',
                style: blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold)
              ),
              Text(
                "Read Top Headline News Today",
                style: greyTextStyle.copyWith(fontSize: 14, fontWeight: regular),
              ),
            ],
          ),
          Container(
            width: 50,
            height: 50,
            child: ClipRRect(
              child: Image.asset(
                  'assets/newspaper.png',
                  fit: BoxFit.cover),
            ),
          )
        ],
      ),
    );
  }
}
