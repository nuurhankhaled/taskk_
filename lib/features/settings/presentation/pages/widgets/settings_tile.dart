import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({required this.title, this.subtitle, this.trailing, this.selected, this.isHeader = false});

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool? selected;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    if (isHeader) {
      return Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: -2)],
      ),
      child: ListTile(
        selected: selected ?? false,
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: trailing,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
