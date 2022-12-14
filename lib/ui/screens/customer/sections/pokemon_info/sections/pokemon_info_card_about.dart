part of '../customer_info.dart';

class _Label extends Text {
  _Label(String text, bool isDark)
      : super(
          text,
          style: TextStyle(
            color: isDark ? AppColors.whiteGrey.withOpacity(0.6) : AppColors.black.withOpacity(0.6),
            height: 0.8,
          ),
        );
}

class _ContentSection extends StatelessWidget {
  final String label;
  final List<Widget>? children;

  const _ContentSection({
    Key? key,
    required this.label,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(height: 0.8, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 22),
        if (children != null) ...children!
      ],
    );
  }
}

class _TextIcon extends StatelessWidget {
  final ImageProvider icon;
  final String text;

  const _TextIcon(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(image: icon, width: 12, height: 12),
        SizedBox(width: 4),
        Text(text, style: TextStyle(height: 0.8)),
      ],
    );
  }
}

class _CustomerAbout extends StatelessWidget {
  final Customer customer;

  const _CustomerAbout(this.customer);

  @override
  Widget build(BuildContext context) {
    final slideController = CustomerInfoStateProvider.of(context).slideController;

    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;

    return AnimatedBuilder(
      animation: slideController,
      builder: (context, child) {
        final scrollable = slideController.value.floor() == 1;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 19, horizontal: 27),
          physics: scrollable ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
          child: child,
        );
      },
      child: Column(
        children: <Widget>[
          _buildNames(customer.names, customer.surnames, context, isDark),
          SizedBox(height: 28),
          _buildInfo(customer.identification, "23", context, isDark),
          SizedBox(height: 28),
          _buildContact(customer.cellPhone, customer.email, context, isDark),
          SizedBox(height: 28),
          _buildHeightWeight(customer.tall, customer.weight, context, isDark),
        ],
      ),
    );
  }

  Widget _buildDescription(String description) {
    return Text(
      description,
      style: TextStyle(height: 1.3),
    );
  }

  Widget _buildHeightWeight(String tall, String weight, BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: Offset(0, 8),
            blurRadius: 23,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _Label('Altura', isDark),
                SizedBox(height: 11),
                Text(
                  '${tall}',
                  style: TextStyle(
                    height: 0.8,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _Label('Peso', isDark),
                SizedBox(height: 11),
                Text('${weight}',
                    style: TextStyle(
                      height: 0.8,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNames(String names, String surnames, BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: Offset(0, 8),
            blurRadius: 23,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _Label('Nombres ', isDark),
                SizedBox(height: 11),
                Text(
                  '${names}',
                  style: TextStyle(
                    height: 0.8,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _Label('Apellidos', isDark),
                SizedBox(height: 11),
                Text('${surnames}',
                    style: TextStyle(
                      height: 0.8,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(String identification, String email, BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: Offset(0, 8),
            blurRadius: 23,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _Label('documento', isDark),
                SizedBox(height: 11),
                Text(
                  '${identification}',
                  style: TextStyle(
                    height: 0.8,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _Label('edad', isDark),
                SizedBox(height: 11),
                Text('${email}',
                    style: TextStyle(
                      height: 0.8,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContact(String cellphone, String email, BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: Offset(0, 8),
            blurRadius: 23,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _Label('telefono', isDark),
                SizedBox(height: 11),
                Text(
                  '${cellphone}',
                  style: TextStyle(
                    height: 0.8,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _Label('correo', isDark),
                SizedBox(height: 11),
                Text('${email}',
                    style: TextStyle(
                      height: 0.8,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

}
