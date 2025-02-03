import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyfax/features/historical/logic/historical_cubit.dart';
import 'package:fyfax/shared/widgets/historical_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
                  style: GoogleFonts.inter(
                      color: Theme.of(context).colorScheme.error)),
              backgroundColor: Theme.of(context).colorScheme.onError,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          notConnected: () {
            var snackBar = SnackBar(
              content: Text('Vous n\'êtes pas connecté à Internet',
                  style: GoogleFonts.inter(
                      color: Theme.of(context).colorScheme.primary)),
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
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
                      style: GoogleFonts.inter(fontSize: 16),
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
                              child: Text('Hier', style: GoogleFonts.inter(),),
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
                            time: DateFormat('dd-MM-yy:HH:mm:ss').format(historical[index].createdAt.toLocal()),
                          ),
                        )),
                  );
              },
              empty: () => Center(
                child: Text(
                  'Aucun historique',
                  style: GoogleFonts.inter(),
                ),
              ),
              notConnected: () => Center(
                child: Text(
                  'Vous n\'êtes pas connectés',
                  style: GoogleFonts.inter(),
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
                              child: Text('Hier', style: GoogleFonts.inter(),),
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
