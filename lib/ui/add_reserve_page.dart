import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tennis_territory_app/config/theme.dart';
import 'package:tennis_territory_app/domain/court/court.dart';
import 'package:tennis_territory_app/ui/bloc/reserve_bloc.dart';
import 'package:tennis_territory_app/ui/home_page.dart';
import 'package:tennis_territory_app/ui/widgets/dialogs.dart';

class AddReservePage extends StatefulWidget {
  AddReservePage({super.key});

  @override
  State<AddReservePage> createState() => _AddReservePageState();
}

class _AddReservePageState extends State<AddReservePage> {
  final _formKey = GlobalKey<FormState>();

  final List<Court> courts = [
    Court(
      id: 'A',
      image: 'assets/images/field_0.jpg',
    ),
    Court(id: 'B', image: 'assets/images/field_1.jpg'),
    Court(id: 'C', image: 'assets/images/field_2.jpg'),
  ];

  final userNameController = TextEditingController();
  final dateController = TextEditingController();
  DateTime? day;
  String courtIdController = 'A';

  @override
  void dispose() {
    // TODO: implement dispose
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final reserveBloc = BlocProvider.of<ReserveBloc>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: AppTheme.iconColor)),
        title: const Text(
          "Agendar",
          style: TextStyle(
              color: AppTheme.primaryColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: BlocListener<ReserveBloc, ReserveState>(
              listener: (context, state) {
                if (state is ReserveError) {
                  infoDialog(
                      context: context,
                      title: 'Ups!',
                      information: state.errorMessage);
                  return;
                }

                if (state is ReserveSuccess) {
                  Navigator.pop(context);
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Swiper(
                    itemCount: courts.length,
                    itemWidth: screenSize.width * 0.9,
                    itemHeight: screenSize.height * 0.3,
                    layout: SwiperLayout.TINDER,
                    onIndexChanged: (index) => setState(() {
                      courtIdController = courts[index].id;
                    }),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: Stack(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              courts[index].image,
                              width: screenSize.width * 0.9,
                              height: screenSize.height * 0.3,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Transform.translate(
                                offset: const Offset(20, -10),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: AppTheme.primaryColor,
                                      borderRadius: BorderRadius.circular(60)),
                                  child: Center(
                                    child: Text(
                                      courts[index].id,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 40.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0),
                                    ),
                                  ),
                                )),
                          )
                        ]),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    width: screenSize.width * 0.8,
                    child: TextFormField(
                      controller: userNameController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s]+')),
                      ],
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                          hintText: 'Nombre',
                          prefixIcon: SizedBox(),
                          suffixIcon: SizedBox()),
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El nombre es requerido';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDatePicker(
                          context: context,
                          locale: const Locale('es', 'ES'),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now());
                    },
                    child: SizedBox(
                      width: screenSize.width * 0.8,
                      child: TextFormField(
                        controller: dateController,
                        readOnly: true,
                        onTap: () async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(9999));

                          if (date != null) {
                            dateController.text =
                                Jiffy.parse(date.toIso8601String()).yMMMMd;
                            day = date;
                            setState(() {});
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: 'Fecha',
                            prefixIcon: Icon(
                              Icons.calendar_month,
                            ),
                            suffixIcon: SizedBox()),
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'La fecha es requerida';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(
                    width: screenSize.width * 0.8,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: screenSize.width * 0.25,
                        child: PrecipProbWidget(
                          fontSize: 15.0,
                          precipProb: reserveBloc
                              .precipProbDays[day?.toString().split(' ')[0]]
                              ?.toString(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.width * 0.1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              reserveBloc.add(AddReserve(
                  courtId: courtIdController,
                  date: day!,
                  userName: userNameController.text));
            }
          },
          child: SizedBox(
            width: screenSize.width * 0.25,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sports_tennis),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "Guardar",
                  style: TextStyle(color: AppTheme.primaryColor),
                )
              ],
            ),
          )),
    );
  }
}
