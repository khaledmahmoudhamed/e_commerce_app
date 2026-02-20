import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/toggle/toggle_cubit.dart';
import '../../../controller/toggle/toggle_state.dart';

class PrivacyPolicySection extends StatelessWidget {
  const PrivacyPolicySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToggleCubit, ToggleState>(
      builder: (BuildContext context, state) {
        return Row(
          children: [
            Checkbox(
              value: state.toggleTermsVisibility,
              onChanged: (val) {
                context.read<ToggleCubit>().toggleCheckBoxVisibility();
              },
              fillColor: WidgetStateProperty.resolveWith((val) {
                if (val.contains(WidgetState.selected)) {
                  return Color(0xffC2F8FE);
                } else {
                  return Colors.white;
                }
              }),
              checkColor: Colors.grey,
            ),

            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "I'm agree to The"),
                    TextSpan(
                      text: " Terms of Service",
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextSpan(text: " and"),
                    TextSpan(
                      text: " Privacy Policy",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
