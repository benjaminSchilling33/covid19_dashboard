import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WHORecommendations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<YoutubePlayerController> controller = List<YoutubePlayerController>();
    controller.add(getControllerForVideo('bPITHEiFWLc'));
    controller.add(getControllerForVideo('6Ooz1GZsQ70'));
    controller.add(getControllerForVideo('qF42gZVm1Bo'));

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('WHO Recommendations'),
        ),
        backgroundColor: Color(0xff000000),
        body: Column(
          children: <Widget>[
            RaisedButton(
              padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
              child: Text('Open source of information'),
              onPressed: () async {
                if (await canLaunch(
                    'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public')) {
                  await launch(
                      'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public');
                } else {
                  throw 'Could not launch https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public';
                }
              },
            ),
            ExpandablePanel(
              header: Column(
                children: <Widget>[
                  Text('Basic protective measures'),
                ],
              ),
              theme: ExpandableThemeData(
                iconColor: Colors.white,
              ),
              expanded: Column(
                children: <Widget>[
                  YoutubePlayer(
                    controller: controller[0],
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.amber,
                    progressColors: ProgressBarColors(
                        playedColor: Colors.amber,
                        handleColor: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            ExpandablePanel(
              header: Column(
                children: <Widget>[
                  Text('Avoid close contact with infected'),
                ],
              ),
              theme: ExpandableThemeData(
                iconColor: Colors.white,
              ),
              expanded: Column(
                children: <Widget>[
                  YoutubePlayer(
                    controller: controller[1],
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.amber,
                    progressColors: ProgressBarColors(
                        playedColor: Colors.amber,
                        handleColor: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            ExpandablePanel(
              header: Column(
                children: <Widget>[
                  Text('Covid-19 symptoms'),
                ],
              ),
              theme: ExpandableThemeData(
                iconColor: Colors.white,
              ),
              expanded: Column(
                children: <Widget>[
                  YoutubePlayer(
                    controller: controller[2],
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.amber,
                    progressColors: ProgressBarColors(
                        playedColor: Colors.amber,
                        handleColor: Colors.amberAccent),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  YoutubePlayerController getControllerForVideo(String identifer) {
    return YoutubePlayerController(
      initialVideoId: identifer,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );
  }
}
