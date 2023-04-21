enum NotificationType {
  error,
  success,
}

class NotificationDetails {
  NotificationDetails(this.type, this.message);
  NotificationDetails.error([this.message]) : type = NotificationType.error;
  NotificationDetails.success([this.message]) : type = NotificationType.success;

  final NotificationType type;
  final String? message;
}
