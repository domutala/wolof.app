import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final AlignmentGeometry alignment;

  const Loading({
    Key? key,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorLight.withOpacity(.5),
      padding: const EdgeInsets.all(50),
      child: Align(
        alignment: alignment,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColorDark.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 15,
                offset: const Offset(0, 3),
              ),
            ],
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Theme.of(context).primaryColorDark.withOpacity(.1),
            ),
          ),
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor.withOpacity(1),
              strokeWidth: 4,
            ),
          ),
        ),
      ),
    );
  }
}
