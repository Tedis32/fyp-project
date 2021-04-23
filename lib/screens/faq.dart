import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('What is this about?'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                top: 40,
              ),
              child: Text(
                'About the app:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
            ),
            Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Text(
                    'This FYP project has been all about automating chat support.\n\nWhat I have done is built a chat-bot that can assist with user queries at the click of a button. The bot should be able to understand speech, context and also be able to maintain a decent level of conversation.')),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Text('The app consists of 2 tabs.',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Text(
                    'The first tab is the most critical component of the app, here you are able to start a conversation with Francine and select whether or not you would like text-to-speech response or otherwise.\n\nThis is the component of the app that a user would need to refer to if they experience an error within the shop.')),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Text(
                  'The second tab is a very straight forward mock car-shop\n\nThere are a few items to choose from that one can purchase within the checkout. However with some of the items you might experience errors. Upon receiving an error, it is important to go to the first tab and refer to Francine for help.'),
            ),
            Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 40),
                child: Text(
                    'Finally, within the drawer on the top left of the screen, there is an Email support function that any user can use to send me an email at fyptedis@gmail.com for questions regarding the application!\n\nHope you find it fun to use!'))
          ],
        ),
      ),
    );
  }
}
