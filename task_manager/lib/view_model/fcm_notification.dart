import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;


abstract class IFCMMotificationService{

Future<void>sendNotificationToUser({
         required String fcmToken,
         required String title,
         required String body,
});


Future<void>sendNotificationToGroup({
         required String group,
         required String title,
         required String body,
});


Future<void>unsubscribeFromTopic({
         required String topic,
        
});

Future<void>subscribeToTopic({
         required String topic,
        
});

}


class FCMNotificationSerice extends IFCMMotificationService {


final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
final String _endpoint = "https://fcm.googleapis.com/fcm/send";
final String _contentType = "application/json";
final String _authorization = "key=AAAAwp_trY8:APA91bH9POVdkMnDTlpUtNT3WH0HPPVhBaOqLEsc9Pe5MVY3e_Kj2vCVQOaqRPPMHtWFGJLkV6oeCTBqbJjWfq5QIATPjdT4pzjWMdD5CzaOU8Fr8rQ0Ug-zQz-WpewPuLsgznfaeMr5";

Future<http.Response> _sendNotification ({

  required String to,
  required String title,
  required String body,
}) async {

   try {

      final dynamic data = json.encode(

        {
            
            'to': to,
             'prority': 'high',
             'notification': {
                'title': title,
                'body': body,
             },
             'content_available': true
        }
      );


      http.Response response = await http.post(

        Uri.parse(_endpoint),
        body: data,
        headers: {
          'Content-Type': _contentType,
          'Authorization': _authorization
        }
      );
      
      return response;


}catch (err) {

   throw Exception(err);
}

 
        
}



@override
Future<void>sendNotificationToUser({
         required String fcmToken,
         required String title,
         required String body,
}) {

        return _sendNotification(to: fcmToken, title: title, body: body);

}



@override

Future<void>sendNotificationToGroup({
         required String group,
         required String title,
         required String body,

}){
  
  return _sendNotification(to: '/topics/' + group, title: title, body: body);

}


@override

Future<void>unsubscribeFromTopic({
         required String topic,
        
}) {
 
             return _firebaseMessaging.unsubscribeFromTopic(topic);

}

@override

Future<void>subscribeToTopic({
         required String topic,
        
}) {
 

   return _firebaseMessaging.subscribeToTopic(topic);


}

}