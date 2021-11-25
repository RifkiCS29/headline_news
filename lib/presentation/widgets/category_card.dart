part of 'widgets.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final String image;

  CategoryCard(this.name, this.image);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2, right: 2),
          child: Container(
            width: 90,
            height: 90,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.black12)
                ]),
            child: Column(
              children: [
                Container(
                  height: 65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4)),
                      image: DecorationImage(
                          image: AssetImage(image),
                          fit: BoxFit.contain)),
                ),
                Container(
                  width: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: blackTextStyle.copyWith(fontSize: 9),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}