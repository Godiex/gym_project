part of '../home.dart';

class _HeaderCardContent extends StatelessWidget {
  static const double height = 582;

  void _onSelectCategory(MenuOption option) {
    AppNavigator.push(option.route);
  }

  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        // border: Border(
        //   bottom: BorderSide(
        //     color: Colors.white,
        //   ),
        // ),
      ),
      child: AppBackground(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      themeCubit.toggleTheme();
                    },
                    padding: EdgeInsets.only(
                      right: 28,
                    ),
                    icon: Icon(
                      isDark ? Icons.wb_sunny_outlined : Icons.dark_mode_outlined,
                      color: isDark ? Colors.yellow : Colors.black,
                      size: 25,
                    )),
              ),
            ),
            _buildTitle(),
            SearchBar(),
            _buildCategories(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Expanded(
      child: Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.all(28),
        alignment: Alignment.bottomLeft,
        child: Text(
          'Selecciona la opcion que desees ;)',
          style: TextStyle(
            fontSize: 30,
            height: 1.6,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(28, 42, 28, 62),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        childAspectRatio: 2.6,
        mainAxisSpacing: 15,
      ),
      itemCount: menuOptions.length,
      itemBuilder: (context, index) {
        return CategoryCard(
          menuOptions[index],
          onPress: () => _onSelectCategory(menuOptions[index]),
        );
      },
    );
  }
}
