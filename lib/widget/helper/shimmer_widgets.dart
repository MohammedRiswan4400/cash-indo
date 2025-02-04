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

class ShimmerErrorWidget extends StatelessWidget {
  const ShimmerErrorWidget({
    super.key,
    required this.firstWidth,
    required this.firstHeight,
    required this.secondWidth,
    required this.secondHeight,
  });
  final double firstWidth;
  final double firstHeight;
  final double secondWidth;
  final double secondHeight;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        SizedBox(
          height: firstHeight,
          width: firstWidth,
          child: ShimmerContainer(),
        ),
        SizedBox(
          height: secondHeight,
          width: secondWidth,
          child: ShimmerContainer(),
        ),
      ],
    );
  }
}

class ShimmerCircleErrorWidget extends StatelessWidget {
  const ShimmerCircleErrorWidget({
    super.key,
    required this.radius,
  });
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: radius,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: ShimmerContainer(),
      ),
    );
  }
}
