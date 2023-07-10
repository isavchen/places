import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/bloc/want_to_visit/want_to_visit_bloc.dart';
import 'package:places/bloc/want_to_visit/want_to_visit_event.dart';
import 'package:places/bloc/want_to_visit/want_to_visit_state.dart';
import 'package:places/ui/widget/dismissible_card_widget.dart';
import 'package:places/ui/widget/overscroll_glow_absorber.dart';
import 'package:places/ui/widget/visiting_content_empty_widget.dart';

class WantToVisitContent extends StatelessWidget {
  const WantToVisitContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WantToVisitBloc, WantToVisitState>(
        builder: (context, state) {
      if (state is WantToVisitListUpdatedSuccess) {
        final places = state.places.reversed.toList();
        return places.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: OverscrollGlowAbsorber(
                  child: MediaQuery.orientationOf(context) ==
                          Orientation.portrait
                      ? ListView.builder(
                          physics: Platform.isIOS
                              ? BouncingScrollPhysics()
                              : ClampingScrollPhysics(),
                          itemCount: places.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 0, 16.0, 16.0),
                              child: DismissibleCardWidget(
                                isWantToVisitContent: true,
                                sight: places[i],
                                onTabClose: () => context
                                    .read<WantToVisitBloc>()
                                    .add(WantToVisitUpdateList(places[i])),
                                onDismissed: (_) => context
                                    .read<WantToVisitBloc>()
                                    .add(WantToVisitUpdateList(places[i])),
                              ),
                            );
                          },
                        )
                      : GridView.builder(
                          itemCount: places.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 36.0,
                            childAspectRatio: 30 / 19,
                          ),
                          itemBuilder: (context, i) => Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                            child: DismissibleCardWidget(
                              isWantToVisitContent: true,
                              sight: places[i],
                              onTabClose: () => context
                                  .read<WantToVisitBloc>()
                                  .add(WantToVisitUpdateList(places[i])),
                              onDismissed: (_) => context
                                  .read<WantToVisitBloc>()
                                  .add(WantToVisitUpdateList(places[i])),
                            ),
                          ),
                        ),
                ),
              )
            : VisitingContentEmptyStateWidget(
                isWantToVisitContent: true,
              );
      }
      throw ArgumentError('Wrong state in WantToVisitContent');
    });
  }
}
