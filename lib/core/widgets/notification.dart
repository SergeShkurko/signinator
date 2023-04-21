import 'package:flutter/material.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/utils/utils.dart';

void showNotification(BuildContext context, NotificationDetails details) {
  final messenger = ScaffoldMessenger.of(context);

  messenger.clearSnackBars();

  final color = () {
    switch (details.type) {
      case NotificationType.success:
        return context.palette.success;
      case NotificationType.error:
        return context.palette.error;
    }
  }();

  final leadingIcon = () {
    switch (details.type) {
      case NotificationType.success:
        return Icons.done;
      case NotificationType.error:
        return Icons.close;
    }
  }();

  final title = () {
    switch (details.type) {
      case NotificationType.success:
        return Strings.of(context)!.succeed;
      case NotificationType.error:
        return Strings.of(context)!.failed;
    }
  }();

  late ScaffoldFeatureController<SnackBar, SnackBarClosedReason> controller;
  controller = messenger.showSnackBar(
    _buildSnackbar(
      leadingIcon: leadingIcon,
      color: color,
      title: title,
      description: details.message,
      onClose: () => controller.close(),
    ),
  );
}

SnackBar _buildSnackbar({
  required IconData leadingIcon,
  required Color color,
  required String title,
  required String? description,
  required VoidCallback onClose,
}) =>
    SnackBar(
      padding: const EdgeInsets.all(Dimens.space12),
      content: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Palette.white,
            ),
            padding: const EdgeInsets.all(Dimens.space4),
            width: Dimens.space24,
            height: Dimens.space24,
            child: Icon(
              leadingIcon,
              size: 14,
              color: color,
            ),
          ),
          const SpacerH(value: Dimens.space12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              if (description != null) ...[
                const SpacerV(value: Dimens.space2),
                Text(description),
              ],
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onClose,
            color: Palette.white,
          ),
        ],
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(Dimens.space24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.cornerRadiusNotification),
      ),
    );
