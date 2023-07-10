import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/bloc/visited/visited_bloc.dart';
import 'package:places/bloc/visited/visited_event.dart';
import 'package:places/bloc/visited/visited_state.dart';
import 'package:places/ui/widget/dismissible_card_widget.dart';
import 'package:places/ui/widget/overscroll_glow_absorber.dart';
import 'package:places/ui/widget/visiting_content_empty_widget.dart';

class VisitedContent extends StatelessWidget {
  const VisitedContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisitedBloc, VisitedState>(
        builder: (context, state) {
      if (state is VisitedListUpdatedSuccess) {
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
                                isWantToVisitContent: false,
                                sight: places[i],
                                onTabClose: () => context
                                    .read<VisitedBloc>()
                                    .add(VisitedUpdateList(places[i])),
                                onDismissed: (_) => context
                                    .read<VisitedBloc>()
                                    .add(VisitedUpdateList(places[i])),
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
                              isWantToVisitContent: false,
                              sight: places[i],
                              onTabClose: () => context
                                  .read<VisitedBloc>()
                                  .add(VisitedUpdateList(places[i])),
                              onDismissed: (_) => context
                                  .read<VisitedBloc>()
                                  .add(VisitedUpdateList(places[i])),
                            ),
                          ),
                        ),
                ),
              )
            : VisitingContentEmptyStateWidget(
                isWantToVisitContent: false,
              );
      }
      throw ArgumentError('Wrong state in WantToVisitContent');
    });
  }
}
