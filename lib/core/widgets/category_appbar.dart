import 'package:flutter/material.dart';

class CategoryAppbar extends StatelessWidget {
  const CategoryAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 221, 221),
      appBar: AppBar(
  
       title: Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(
              alpha: 0.2,
              blue: 0.2,
              green: 0.2,
              red: 0.2,
            ),
            blurRadius: 10,
            
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.chevron_left, color: Colors.black),
        onPressed: () {
          
        },
      ),
    ),
    const SizedBox(width: 16),
    const Expanded(
      child: Text(
        "Category",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ],
)
,
  actions: [
    IconButton(
      icon: const Icon(Icons.notifications_none, color: Colors.black),
      onPressed: () {
       
      },
    ),
  ],
)
    );
  }
}