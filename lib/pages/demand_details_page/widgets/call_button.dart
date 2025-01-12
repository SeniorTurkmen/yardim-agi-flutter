import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SMSButton extends StatelessWidget {
  const SMSButton({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: context.appColors.mainRed,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.zero,
      ),
      onPressed: () async {
        final smsLaunchUri = Uri(scheme: 'sms', path: phoneNumber);
        await launchUrl(smsLaunchUri);
      },
      child: const SizedBox(
        height: 40,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(
              'SMS ile ulaş',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
