part of '../home.dart';

class _PokemonNews extends StatelessWidget {
  const _PokemonNews();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        _buildHeader(context),
        _buildNews(),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(28, 0, 28, 22),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Asistencias de clientes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            'Ver todos',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.indigo,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNews() {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 9,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        return NewsCard(
          title: 'Juan Manuel Martinez',
          time: '20 de Julio del 2022',

          thumbnail: AppImages.male,
        );
      },
    );
  }
}
