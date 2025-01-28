import 'package:cash_indo/view/dashboard/savings/cubit/expansion_cubit.dart';

import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.children,
    this.leading = const Icon(Icons.folder),
  });
  final String title;
  final Widget leading;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExpansionCubit(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<ExpansionCubit, bool>(
            builder: (context, isExpanded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<ExpansionCubit>().toggle();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          leading,
                          const SizedBox(width: 12),
                          AppTextWidget(
                            text: title,
                            size: 16,
                            weight: FontWeight.bold,
                          ),
                          Spacer(),
                          AnimatedRotation(
                            turns: isExpanded ? 0.5 : 0.0,
                            duration: const Duration(milliseconds: 300),
                            child: const Icon(
                              Icons.expand_more,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: isExpanded
                        ? Padding(
                            padding: const EdgeInsets.only(left: 16, top: 8),
                            child: Column(
                              children: children,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
