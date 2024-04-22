import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tennis_territory_app/config/routes.dart';
import 'package:tennis_territory_app/config/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_territory_app/ui/bloc/reserve_bloc.dart';
import 'package:tennis_territory_app/ui/widgets/dialogs.dart';
import 'package:tennis_territory_app/ui/widgets/loading_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ReserveBloc reserveBloc;

  final today = Jiffy.now();
  final double latitude = 10.48;
  final double longitude = -66.87;

  @override
  void initState() {
    super.initState();

    reserveBloc = BlocProvider.of<ReserveBloc>(context);
    reserveBloc.add(LoadReserve(
        date: today.dateTime, latitude: latitude, longitude: longitude));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sports_tennis,
                  color: AppTheme.primaryColor,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  "TennisTerritory",
                  style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0),
                ),
              ],
            ),
            Text(
              today.yMMMMd,
              style: theme.textTheme.titleMedium!
                  .copyWith(color: AppTheme.iconColor),
              textAlign: TextAlign.center,
            )
          ],
        ),
        leading: Container(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.addAppointment);
                },
                icon: const Icon(
                  Icons.add,
                  color: AppTheme.primaryColor,
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: BlocBuilder<ReserveBloc, ReserveState>(
                  builder: (context, state) {
                    if (state is ReserveError) {
                      return const Center(
                        child: Text(
                          "Ups! ha ocurrido un problema al cargar los registros",
                          style: TextStyle(color: AppTheme.iconColor),
                        ),
                      );
                    }
                    if (state is ReserveLoaded && state.reserves.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.sports_tennis,
                              color: AppTheme.iconColor,
                              size: 80.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "No existen registros previos",
                              style: TextStyle(color: AppTheme.iconColor),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is! ReserveLoaded) {
                      return const LoadingIndicator();
                    }

                    final reserves = state.reserves;

                    return ListView.builder(
                      itemCount: reserves.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Card(
                          elevation: 0.8,
                          color: Colors.white,
                          child: ListTile(
                            visualDensity:
                                const VisualDensity(horizontal: 4, vertical: 4),
                            contentPadding:
                                const EdgeInsets.only(top: 10.0, left: 10.0),
                            title: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                reserves[index].userName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            subtitle: Text(
                              Jiffy.parse(reserves[index].date.toString())
                                  .yMMMMd,
                            ),
                            leading: CircleAvatar(
                                radius: 15.0,
                                backgroundColor: AppTheme.primaryColor,
                                child: Text(
                                  reserves[index].courtId,
                                  style: const TextStyle(color: Colors.white),
                                )),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: screenSize.width * 0.22,
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: PrecipProbWidget(
                                    precipProb: reserves[index].precipProb,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                SizedBox(
                                  height: 35.0,
                                  child: IconButton(
                                    onPressed: () async {
                                      final accept = await decisionDialog(
                                          context: context,
                                          title:
                                              "¿Desea eliminar esta reservación?",
                                          subtitle:
                                              "Cancha ${reserves[index].courtId} - ${Jiffy.parse(reserves[index].date.toString()).yMMMMd}");
                                      if (accept == true) {
                                        reserveBloc.add(
                                            DeleteReserve(reserves[index].id!));
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.close_rounded,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PrecipProbWidget extends StatelessWidget {
  const PrecipProbWidget({super.key, this.precipProb, this.fontSize});

  final String? precipProb;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          precipProb != null ? '$precipProb %' : '',
          style:
              TextStyle(fontSize: fontSize ?? 11.0, color: AppTheme.iconColor),
        ),
        const SizedBox(
          width: 10.0,
        ),
        precipProb != null
            ? const Icon(
                Icons.cloudy_snowing,
                color: AppTheme.iconColor,
              )
            : const Icon(
                Icons.cloud_off_rounded,
                color: AppTheme.iconColor,
              )
      ],
    );
  }
}
