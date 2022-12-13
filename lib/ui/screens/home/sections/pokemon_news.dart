part of '../home.dart';

class _PokemonNews extends StatelessWidget {
  const _PokemonNews();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        _buildHeader(context),
        _buildNews(context),
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

  Widget _buildNews(context) {
    Future<dynamic> getAttendance(context) async {
      var userInfoBloc = BlocProvider.of<UserInfoBloc>(context, listen: true);
      final UserInfo userInfo = userInfoBloc.state.userInfo;
      var attendanceRepository = new AttendanceDefaultRepository();
      return await attendanceRepository.get(userInfo.gymId);
    }

    return FutureBuilder(
      future: getAttendance(context),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState){
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            List<Attendance> _attendance = snapshot.data;
            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _attendance.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                return NewsCard(
                  title: "${_attendance[index].customer?.names} ${_attendance[index].customer?.surnames}",
                  time: _attendance[index].entryDate.toString(),
                  thumbnail: AppImages.male,
                );
              },
            );
          default:
            return Text('Vuelva a la vista anterior e inténtelo de nuevo');
        }
      },
    );
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
