import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:voice_bridge/screens/parentScreen/controllers/autism_controller.dart';
import 'package:voice_bridge/widgets/custom_button.dart';
import 'package:get/get.dart';

import '../../../resources/routes/routes_name.dart';
import '../widgets/tips_card.dart';

class ParentScreenView extends StatelessWidget {
  ParentScreenView({super.key});
  final AutismController controller = Get.put(AutismController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parent Dashboard"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => CircularPercentIndicator(
                radius: 100,
                animation: true,
                animationDuration: 1000,
                lineWidth: 30,
                percent: controller.score.value,
                center: Text("${controller.level}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                progressColor: controller.levelColor,
                backgroundColor: Colors.grey[300]!,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            CustomButton(
                text: "Start Test",
                color: Colors.green,
                width: 150,
                onPressed: () => Get.toNamed(RoutesName.autismTestScreen)),
            const SizedBox(
              height: 16,
            ),
            const Text("Therapy Activities for",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            const Text("Language Development",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                children: [
                  //Therapy Activities for Language Development
                  TipCard("Expand Vocabulary",
                      "Introduce a new word every day."),
                  TipCard("Use Pictures",
                      "Teach new words through pictures."),
                  TipCard("Form Simple Sentences",
                      "Practice using two- to three-word sentences."),
                  TipCard("Encourage Imitation",
                      "Motivate the child to imitate your words and sounds."),
                  TipCard("Sing Songs",
                      "Use songs to teach words and sentences."),
                  TipCard("Ask Yes/No Questions",
                      "Start conversations with simple yes/no questions."),
                  TipCard("Describe Objects",
                      "Encourage describing objects or pictures."),
                  TipCard("Tell Stories",
                      "Tell simple stories and encourage the child to tell their own."),
                  TipCard("Use Gestures with Words",
                      "Combine gestures with spoken words."),
                  TipCard("Use Language in Daily Routines",
                      "Narrate daily activities using simple language."),
                  TipCard("Word Games",
                      "Play rhyming or matching word games."),
                  TipCard("Name Household Items",
                      "Name objects around the house and encourage the child to repeat."),
                  TipCard("Use Educational Videos",
                      "Show short educational videos."),
                  TipCard("Play Interactive Games",
                      "Use small games to encourage participation and language use."),
                  TipCard("Word Identification",
                      "Let the child identify or point out named words."),
                  TipCard("Answer Simple Questions",
                      "Practice answering easy questions."),
                  TipCard("Combine Words with Drawing",
                      "Encourage drawing while saying related words."),
                  TipCard("Describe Object Usage",
                      "Talk about how different objects are used."),
                  TipCard("Link Words to Actions",
                      "Connect words to actions, like 'Take the ball.'"),
                  TipCard("Match Words to Pictures",
                      "Match words to relevant pictures."),
                  TipCard("Match Similar Words",
                      "Find and match words that sound or look alike, like 'ball' and 'call.'"),
                  TipCard("Combine Words with Numbers",
                      "Use numbers and counting while speaking."),
                  TipCard("Combine Words with Colors",
                      "Teach words while identifying different colors."),
                  TipCard("Combine Words with Shapes",
                      "Teach words while exploring different shapes."),
                  TipCard("Combine Words with Smells",
                      "Introduce words when experiencing different smells."),
                  TipCard("Combine Words with Tastes",
                      "Introduce words related to different tastes."),
                  TipCard("Talk About Word Origins",
                      "Introduce simple ideas about where things come from."),
                  TipCard("Combine Words with Time Concepts",
                      "Teach concepts like 'morning,' 'night,' or 'today.'"),
                  TipCard("Combine Words with Seasons",
                      "Teach words related to different seasons."),
                  TipCard("Combine Words with Weather",
                      "Teach words while discussing the weather."),



                  //Therapy Activities for Improving Communication Skills

                  TipCard("Use Eye Contact",
                      "Encourage the child to maintain eye contact while communicating."),
                  TipCard("Use Gestures",
                      "Teach how to use gestures to aid communication."),
                  TipCard("Use Facial Expressions",
                      "Teach how to use facial expressions for communication."),
                  TipCard("Use Body Language",
                      "Teach how to communicate using body language."),
                  TipCard("Use Simple Signs",
                      "Teach simple signs to help with communication."),
                  TipCard("Encourage Question Asking",
                      "Motivate the child to ask questions."),
                  TipCard("Practice Answering Questions",
                      "Help the child practice giving answers."),
                  TipCard("Request Objects",
                      "Encourage the child to ask for objects."),
                  TipCard("Request Help",
                      "Encourage the child to ask for assistance."),
                  TipCard("Sharing Toys",
                      "Encourage the child to share toys with others."),
                  TipCard("Taking Turns",
                      "Practice taking turns with others."),
                  TipCard("Accepting Others’ Choices",
                      "Encourage the child to accept choices made by others."),
                  TipCard("Listening to Others",
                      "Teach the child to listen carefully to others."),
                  TipCard("Following Others' Lead",
                      "Encourage the child to follow someone else's direction."),
                  TipCard("Respecting Others",
                      "Practice respecting others' feelings and opinions."),
                  TipCard("Avoid Interrupting",
                      "Teach the child not to interrupt others while they are speaking."),
                  TipCard("Valuing Others' Opinions",
                      "Encourage giving importance to what others say."),
                  TipCard("Helping Others in Need",
                      "Support the child in helping others when needed."),
                  TipCard("Helping Others Listen",
                      "Help the child learn how to listen carefully to others."),
                  TipCard("Helping Others Follow Instructions",
                      "Assist the child in following others' instructions."),
                  TipCard("Helping Others Feel Respected",
                      "Support the child in showing respect to others."),
                  TipCard("Helping Others Speak Without Interruptions",
                      "Help the child let others speak without interrupting."),
                  TipCard("Helping Others Feel Valued",
                      "Encourage the child to make others feel important."),
                  TipCard("Encouraging Helping Behavior",
                      "Motivate the child to offer help to others."),
                  TipCard("Encouraging Listening Behavior",
                      "Motivate the child to actively listen to others."),
                  TipCard("Encouraging Following Directions",
                      "Motivate the child to follow directions given by others."),
                  TipCard("Encouraging Respect for Others",
                      "Motivate the child to show respect to others."),
                  TipCard("Encouraging Not to Interrupt Others",
                      "Motivate the child to avoid interrupting others."),
                  TipCard("Encouraging Valuing Others",
                      "Motivate the child to value others' opinions."),
                  TipCard("Helping Others in Need",
                      "Help the child support others when needed."),


                  TipCard("Social Play",
                      "Engage the child in social games like 'Ring Around the Rosie'."),
                  TipCard("Teamwork Activities",
                      "Practice teamwork through activities like building puzzles together."),
                  TipCard("Playing with Others",
                      "Encourage the child to play cooperatively with others."),
                  TipCard("Sharing Toys with Others",
                      "Encourage the child to share toys with peers."),
                  TipCard("Sharing Experiences",
                      "Encourage the child to share their experiences with others."),
                  TipCard("Cooperating with Others",
                      "Teach the child how to cooperate with others."),
                  TipCard("Respecting Peers",
                      "Teach the child to show respect toward peers."),
                  TipCard("Showing Empathy",
                      "Teach the child to express empathy towards others."),
                  TipCard("Showing Sympathy",
                      "Teach the child to show sympathy when others are hurt or upset."),
                  TipCard("Encouraging Cooperation",
                      "Motivate the child to engage in cooperative activities."),
                  TipCard("Encouraging Respect for Peers",
                      "Motivate the child to respect their friends and classmates."),
                  TipCard("Encouraging Showing Empathy",
                      "Encourage the child to show empathy toward others."),
                  TipCard("Encouraging Showing Sympathy",
                      "Encourage the child to express sympathy appropriately."),
                  TipCard("Encouraging Helping Behavior",
                      "Motivate the child to help others."),
                  TipCard("Planning Social Activities",
                      "Create opportunities for the child to participate in social events."),




                ],
              ),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        )),
      ),
    );
  }
}
