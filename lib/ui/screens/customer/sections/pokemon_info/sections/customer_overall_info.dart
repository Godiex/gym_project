part of '../customer_info.dart';

class _CustomerOverallInfo extends StatefulWidget {
  final Customer customer;
  const _CustomerOverallInfo(this.customer);

  @override
  _CustomerOverallInfoState createState() => _CustomerOverallInfoState();
}

class _CustomerOverallInfoState extends State<_CustomerOverallInfo> with TickerProviderStateMixin {
  static const double _pokemonSliderViewportFraction = 0.56;
  static const int _endReachedThreshold = 4;

  final GlobalKey _currentTextKey = GlobalKey();
  final GlobalKey _targetTextKey = GlobalKey();

  double textDiffLeft = 0.0;
  double textDiffTop = 0.0;
  late PageController _pageController;
  late AnimationController _horizontalSlideController;

  AnimationController get slideController => CustomerInfoStateProvider.of(context).slideController;
  AnimationController get rotateController => CustomerInfoStateProvider.of(context).rotateController;

  Animation<double> get textFadeAnimation => Tween(begin: 1.0, end: 0.0).animate(slideController);
  Animation<double> get sliderFadeAnimation => Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: slideController,
        curve: Interval(0.0, 0.5, curve: Curves.ease),
      ));

  @override
  void initState() {
    _horizontalSlideController = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 300),
    )..forward();

    super.initState();
  }

  @override
  void dispose() {
    _horizontalSlideController.dispose();
    _pageController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildAppBar(),
        SizedBox(height: 9),
        _buildPokemonName(),
      ],
    );
  }

  AppBar _buildAppBar() {
    return MainAppBar(
      // A placeholder for easily calculate the translate of the pokemon name
      title: Text(
        widget.customer.names,
        key: _targetTextKey,
        style: TextStyle(
          color: Colors.transparent,
          fontWeight: FontWeight.w900,
          fontSize: 22,
        ),
      ),
      rightIcon: Icons.favorite_border,
    );
  }

  Widget _buildPokemonName() {
    var bgColor = Theme.of(context).backgroundColor;
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedBuilder(
            animation: slideController,
            builder: (_, __) {
              final value = slideController.value;

              return Transform.translate(
                offset: Offset(textDiffLeft * value, textDiffTop * value),
                child: Image(image: AppImages.gym_logo,
                  height: size.height * 0.4,
                  color: Colors.black.withOpacity(0.5),
                )
              );
            },
          ),
        ],
      ),
    );
  }

}
