part of '../customer_info.dart';

class _PokemonInfoCard extends StatefulWidget {
  final Customer customer;
  static const double minCardHeightFraction = 0.54;

  const _PokemonInfoCard(this.customer);

  @override
  State<_PokemonInfoCard> createState() => _PokemonInfoCardState();
}

class _PokemonInfoCardState extends State<_PokemonInfoCard> {
  AnimationController get slideController => CustomerInfoStateProvider.of(context).slideController;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final safeArea = MediaQuery.of(context).padding;
    final appBarHeight = AppBar().preferredSize.height;

    final cardMinHeight = screenHeight * _PokemonInfoCard.minCardHeightFraction;
    final cardMaxHeight = screenHeight - appBarHeight - safeArea.top;

    return AutoSlideUpPanel(
      minHeight: cardMinHeight,
      maxHeight: cardMaxHeight,
      onPanelSlide: (position) => slideController.value = position,
      child: MainTabView(
      paddingAnimation: slideController,
      tabs: [
        MainTabData(
          label: 'General',
          child: _CustomerAbout(widget.customer),
        ),
        MainTabData(
          label: 'Corporal',
          child: _CustomerBaseStats(widget.customer),
        ),
        MainTabData(
          label: 'Plan',
          child: Align(
            alignment: Alignment.topCenter,
            child: Text('Tiene un plan ${widget.customer.plan?.name} con una duracion de ${widget.customer.plan?.duration} dias'),
          ),
        ),
      ],
    )
    );
  }
}
