import 'package:flutter/material.dart';

class NewPhotoCard extends StatelessWidget {
  final int state;
  final String imageUrl;
  final Function() onPressed;
  final Function(DismissDirection)? onDismissed;
  const NewPhotoCard(
      {Key? key,
      required this.state,
      required this.imageUrl,
      required this.onPressed,
      this.onDismissed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: state == 0 ? onPressed : null,
        child: Container(
          width: 72.0,
          height: 72.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: state == 0
                ? Border.all(
                    width: 2,
                    color: Theme.of(context).buttonColor.withOpacity(0.48))
                : null,
          ),
          child: state == 0
              ? Center(
                  child: Icon(
                    Icons.add_rounded,
                    size: 40,
                    color: Theme.of(context).buttonColor,
                  ),
                )
              : Dismissible(
                direction: DismissDirection.up,
                onDismissed: onDismissed,
                  key: ValueKey(key),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: 72,
                          height: 72,
                          colorBlendMode: BlendMode.srcATop,
                          color:
                              Theme.of(context).accentColor.withOpacity(0.24),
                        ),
                      ),
                      Positioned(
                        top: 6,
                        right: 6,
                        child: GestureDetector(
                          onTap: state == 1 ? onPressed : null,
                          child: Icon(
                            Icons.cancel_rounded,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
