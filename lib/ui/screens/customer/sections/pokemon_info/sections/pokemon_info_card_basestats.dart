part of '../customer_info.dart';

class Stat extends StatelessWidget {
  final Animation animation;
  final String label;
  final double? progress;
  final num value;

  const Stat({
    required this.animation,
    required this.label,
    required this.value,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(color: Theme.of(context).textTheme.caption!.color!.withOpacity(0.6)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text('$value'),
        ),
        Expanded(
          flex: 5,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, widget) {
              final currentProgress = progress ?? value / 100;

              return ProgressBar(
                progress: animation.value * currentProgress,
                color: currentProgress < 0.5 ? AppColors.red : AppColors.teal,
                enableAnimation: animation.value == 1,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CustomerBaseStats extends StatefulWidget {
  final Customer customer;

  const _CustomerBaseStats(this.customer);

  @override
  State<_CustomerBaseStats> createState() => _CustomerBaseStatsState();
}

class _CustomerBaseStatsState extends State<_CustomerBaseStats> with SingleTickerProviderStateMixin {
  late Animation<double> _progressAnimation;
  late AnimationController _progressController;

  Customer get customer => widget.customer;

  AnimationController get slideController => CustomerInfoStateProvider.of(context).slideController;

  @override
  void initState() {
    _progressController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _progressController,
    ));

    _progressController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _progressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slideController,
      builder: (context, child) {
        final scrollable = slideController.value.floor() == 1;

        return SingleChildScrollView(
          padding: EdgeInsets.all(24),
          physics: scrollable ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
          child: child,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          buildStats(customer),
          SizedBox(height: 15),
          Text(
            'el cliente tiene un pla de tipo ${customer.plan?.name}.',
            style: TextStyle(color: AppColors.black.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }

  Widget buildStats(Customer customer) {
    double weight = double.parse(customer.weight);
    double tall = double.parse(customer.tall);
    double imc = (weight / pow(tall, 2));
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stat(animation: _progressAnimation, label: 'edad', value: 24),
        SizedBox(height: 14),
        Stat(animation: _progressAnimation, label: 'peso', value: weight),
        SizedBox(height: 14),
        Stat(animation: _progressAnimation, label: 'altura', value: tall),
        SizedBox(height: 14),
        Stat(animation: _progressAnimation, label: 'IMC', value: imc),
        SizedBox(height: 14),
        Stat(
          animation: _progressAnimation,
          label: 'Total',
          value: 50,
          progress: 50 / 100,
        ),
      ],
    );
  }
}
