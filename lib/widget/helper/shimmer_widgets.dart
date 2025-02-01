import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(104, 139, 139, 139),
      highlightColor: const Color.fromARGB(58, 142, 142, 142),
      child: Container(
        // // height: 50,
        // width: double.infinity,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(10),
          color: Colors.amber,
        ),
      ),
    );
  }
}
