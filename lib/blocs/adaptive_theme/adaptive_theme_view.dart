
// DIALOG
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
        class CustomChip extends StatelessWidget {
                const CustomChip(
                  {super.key,
      required this.isSelected,
      required this.label,
      required this.icon,
      required this.onTap});
  final bool isSelected;
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Chip(
          avatar: Icon(
            icon,
            size: 20.w,
            color: Theme.of(context).primaryColor,
          ),
          backgroundColor:
              isSelected ? Colors.blue[100] : Theme.of(context).splashColor,
          side: BorderSide(width: 1.w),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          padding: EdgeInsets.all(10.w),
          label: Text(
            label,
            style: Theme.of(context).textTheme.displaySmall,
          )),
    );
  }
}             

   

