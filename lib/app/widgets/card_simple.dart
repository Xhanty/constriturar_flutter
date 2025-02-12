import 'package:flutter/material.dart';
import 'package:constriturar/app/core/config/app_colors.dart';

class CardSimple extends StatefulWidget {
  const CardSimple({
    super.key,
    required this.id,
    required this.title,
    this.description,
    required this.icon,
    required this.onEdit,
    required this.onDelete,
  });

  final int id;
  final String title;
  final String? description;
  final IconData icon;
  final Function onEdit;
  final Function onDelete;

  @override
  State<CardSimple> createState() => _CardSimpleState();
}

class _CardSimpleState extends State<CardSimple> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightShadow,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.lightPrimary,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Icon(widget.icon, color: AppColors.primary),
              ),
              SizedBox(width: 10),
              SizedBox(
                height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.title, style: TextStyle(fontSize: 16)),
                    widget.description != null
                        ? Text(widget.description!,
                            style: TextStyle(fontSize: 13))
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: AppColors.primary),
                onPressed: () {
                  widget.onEdit(widget.id);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: AppColors.primary),
                onPressed: () {
                  widget.onDelete(widget.id);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
