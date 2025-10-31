import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/service/local_notification_service.dart';

class DailyNotificationProvider extends ChangeNotifier {
  final LocalNotificationService notificationService;

  DailyNotificationProvider(this.notificationService);

  int _notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  List<PendingNotificationRequest> pendingNotificationRequests = [];

  bool status = false;

  int get notificationId => _notificationId;
  Future<void> requestPermissions() async {
    _permission = await notificationService.requestPermissions();
    notifyListeners();
  }

  void scheduleDailyElevenAMNotification() {
    _notificationId += 1;
    notificationService.scheduleDailyElevenAMNotification(id: _notificationId);
    status = true;
    notifyListeners();
  }

  Future<void> checkPendingNotificationRequests(BuildContext context) async {
    pendingNotificationRequests = await notificationService
        .pendingNotificationRequests();
    for (int i = 0; i < pendingNotificationRequests.length; i++) {
      print(pendingNotificationRequests[i].title);
      print(pendingNotificationRequests[i].body);
      }
    if(pendingNotificationRequests.length == 0){
      print("null");
    }
    notifyListeners();
  }

  Future<void> cancelNotification() async {
    await notificationService.cancelNotification();
    status = false;
    notifyListeners();
  }
}
