import 'package:flutter/material.dart';

class ItemSampahCard extends StatelessWidget {
  final String title;
  final String pricePerKg;
  final VoidCallback? onDelete;
  final bool showDeleteButton;

  const ItemSampahCard({
    super.key,
    required this.title,
    required this.pricePerKg,
    this.onDelete,
    this.showDeleteButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        color: Colors.grey[300], // placeholder image
      ),
      title: Text(title),
      subtitle: Text(pricePerKg),
      trailing: showDeleteButton
          ? IconButton(
              icon: Icon(Icons.close),
              onPressed: onDelete,
            )
          : null,
    );
  }
}
