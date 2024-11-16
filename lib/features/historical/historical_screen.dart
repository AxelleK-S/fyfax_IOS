import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyfax/features/historical/logic/historical_cubit.dart';
import 'package:fyfax/shared/widgets/historical_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HistoricalScreen extends StatelessWidget {
  const HistoricalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HistoricalCubit()..getHistorical(),
      child: const HistoricalArea(),
    );
  }
}

class HistoricalArea extends StatelessWidget {
  const HistoricalArea({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HistoricalCubit, HistoricalState>(
      listener: (context, state) {
        if (kDebugMode) {
          print(state);
        }
        state.maybeWhen(
          error: (message) {
            var snackBar = SnackBar(
              content: Text(message,
                  style: GoogleFonts.handlee(
                      color: Theme.of(context).colorScheme.onError)),
              backgroundColor: Theme.of(context).colorScheme.error,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          notConnected: () {
            var snackBar = SnackBar(
              content: Text('Vous n\'êtes pas connecté à Internet',
                  style: GoogleFonts.handlee(
                      color: Theme.of(context).colorScheme.onPrimary)),
              backgroundColor: Theme.of(context).colorScheme.primary,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          orElse: () {if (kDebugMode) {
            print('else');
          }},
        );
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Historique',
                      style: GoogleFonts.handlee(fontSize: 16),
                    ),
                  ],
                ),
              ),
            )),
        body: BlocBuilder<HistoricalCubit, HistoricalState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Skeletonizer(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                top: 24,
                                bottom: 24
                              ),
                              child: Text('Hier', style: GoogleFonts.handlee(),),
                            ),*/
                    SizedBox(
                      height: 20,
                    ),
                    HistoricalCard(
                      text: 'Quiz cas court 2016 terminé',
                      time: '20s',
                    ),
                    HistoricalCard(
                      text: 'Quiz ECN Généraliste 2014 terminé',
                      time: '44min',
                    ),
                    HistoricalCard(
                      text: 'Inscription réussi , Bienvenue sur Mederine',
                      time: '1h',
                    ),
                  ],
                ),
              ),
              success: (historical) {
                return SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          historical.length,
                          (index) => HistoricalCard(
                            text: historical[index].text,
                            time:
                                historical[index].createdAt.toLocal().toString(),
                          ),
                        )),
                  );
              },
              empty: () => Center(
                child: Text(
                  'Aucun historique',
                  style: GoogleFonts.handlee(),
                ),
              ),
              notConnected: () => Center(
                child: Text(
                  'Vous n\'êtes pas connectés',
                  style: GoogleFonts.handlee(),
                ),
              ),
              orElse: () {
                return const Skeletonizer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                top: 24,
                                bottom: 24
                              ),
                              child: Text('Hier', style: GoogleFonts.handlee(),),
                            ),*/
                      SizedBox(
                        height: 20,
                      ),
                      HistoricalCard(
                        text: 'Quiz cas court 2016 terminé',
                        time: '20s',
                      ),
                      HistoricalCard(
                        text: 'Quiz ECN Généraliste 2014 terminé',
                        time: '44min',
                      ),
                      HistoricalCard(
                        text: 'Inscription réussi , Bienvenue sur Mederine',
                        time: '1h',
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
