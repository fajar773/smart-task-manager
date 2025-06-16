import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;

  const CustomButton({required this.text, required this.onTap, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 28.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
      onPressed: onTap,
      child: Text(text, style: TextStyle(fontSize: 16.sp, color: Colors.white)),
    );
  }
}
