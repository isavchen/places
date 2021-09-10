import 'package:flutter/material.dart';

class NewPhotoCard extends StatelessWidget {
  final bool isAddButton;
  final String? imageUrl;
  final Function()? onPressed;
  final Function()? onDelete;
  const NewPhotoCard({
    Key? key,
    this.isAddButton = false,
    this.imageUrl,
    this.onPressed,
    this.onDelete,
    // this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: isAddButton
          ? GestureDetector(
              onTap: () {
                if (onPressed != null) {
                  onPressed!();
                }
              },
              child: Container(
                width: 72.0,
                height: 72.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).buttonColor.withOpacity(0.48),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.add_rounded,
                    size: 40,
                    color: Theme.of(context).buttonColor,
                  ),
                ),
              ),
            )
          : Dismissible(
              direction: DismissDirection.up,
              onDismissed: (_) {
                if (onDelete != null) {
                  onDelete!();
                }
              },
              key: key ?? ValueKey('default'),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      width: 72,
                      height: 72,
                      colorBlendMode: BlendMode.srcATop,
                      color: Theme.of(context).accentColor.withOpacity(0.24),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: GestureDetector(
                      // onTap: state == 1 ? onPressed : null,
                      onTap: () {
                        if (onDelete != null) {
                          onDelete!();  
                        }
                      },
                      child: Icon(
                        Icons.cancel_rounded,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
