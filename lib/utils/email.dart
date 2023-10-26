import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
 class Email{
   static sendMail(
       {
         required String Username,
         required String Password,
         required String DomainSmtp ,
         required int Port,
         required String Subject,
         required String Text,
         required String Recepiant,
       }
       ) async {
     String username = Username;
     String password = Password;
     String domainSmtp = DomainSmtp;
     String subject = Subject;
     String text = Text;
     int port = Port;
     String recepiant = Recepiant;


     final smtpServer = gmail(username, password);
     // final smtpServer = gmailSaslXoauth2(username, token);
     //user for your own domain
// final smtpServer = SmtpServer(domainSmtp,username: username,password: password,port: port);

     final message = Message()
       ..from = Address(username)
       ..recipients.add(recepiant)
       //..recipients.add('amrk4912@gmail.com')
     //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
     //..bccRecipients.add(Address('bccAddress@example.com'))
       ..subject = subject
       ..text = text;

     // ..html = "<h1>Shawon</h1>\n<p>Hey! Here's some HTML content</p>";

     try {
      print('Username' + username.toString());
      print('password' + password.toString());
      print('domainSmtp' + domainSmtp.toString());
      print('port' + port.toString());
      print('subject' + subject.toString());
      print('text' + text.toString());
      print('recepiant' + recepiant.toString());

       final sendReport = await send(message, smtpServer);

       print('Message sent: ' + sendReport.toString());
     } on MailerException catch (e) {
       print('Message not sent.${e}');


     }

   }
}
