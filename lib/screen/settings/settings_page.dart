import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/notification/daily_notification_provider.dart';
import 'package:restaurant_app/provider/shared_preferences/shared_preferences_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ),

      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: context.watch<SharedPreferencesProvider>().isDarkMode,
            onChanged: (val) {
              context.read<SharedPreferencesProvider>().saveSettingsValue(val);
            },
            secondary: Icon(Icons.dark_mode),
          ),
          SwitchListTile(
            title: Text('Daily Reminder'),
            value: context.watch<SharedPreferencesProvider>().isReminderOn,
            onChanged: (val) {
              if(val){
                context.read<DailyNotificationProvider>()
                    .scheduleDailyElevenAMNotification();
              } else{
                context.read<DailyNotificationProvider>()
                    .cancelNotification();
              }
              context.read<DailyNotificationProvider>()
                  .checkPendingNotificationRequests(context);
              context.read<SharedPreferencesProvider>()
                  .saveSettingsValueReminder(val);
            },
            secondary: Icon(Icons.timer),
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       context.read<DailyNotificationProvider>()
          //           .checkPendingNotificationRequests(context);
          //     },
          //     child: Text(context.watch<DailyNotificationProvider>().pendingNotificationRequests.length.toString()),
          // ),
          //Center(child: Text(context.watch<DailyNotificationProvider>().permission.toString()))
        ],
      ),
    );
  }
}
