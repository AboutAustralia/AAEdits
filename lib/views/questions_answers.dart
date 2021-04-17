import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:about_australia/theme/app_colors.dart';
import 'package:about_australia/theme/app_typography.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:about_australia/fireStore_api.dart';

class questionsAnswers extends StatefulWidget {
  @override
  _questionsAnswersState createState() => _questionsAnswersState();
}

class _questionsAnswersState extends State<questionsAnswers> {
  //google auth start
  var _token;

  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool _logged_in;
  final storage = new FlutterSecureStorage();
  DatabaseReference ref = FirebaseDatabase.instance.reference();
  final db = FireStoreAPI();

  //Google login
  //login proved us with username, imageurl, token and user id
  Future<User> _GooglesignIn() async {

    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: gSA.accessToken,
      idToken: gSA.idToken,
    );

    User googleuser = (await _fAuth.signInWithCredential(credential)).user;

    var displayname = googleuser.displayName;
    var photourl = googleuser.photoURL;
    var userid = googleSignInAccount.id;
    var token = gSA.accessToken;
    var uid = _fAuth.currentUser.uid;
    await db.addUser(displayname, photourl, userid, token, uid);
    print(displayname);

    store_token(token);
    read_token();

    return null;
  }

  Future read_token() async {
    String value = await storage.read(key: 'valid_token');
    setState(() {
      if (_fAuth.currentUser != null) {
        _logged_in = true;
      } else {
        _logged_in = false;
      }
    });
  }


  Future store_token(String valid_token) async {
    await storage.write(key: 'valid_token', value: '$valid_token');
  }

  //google auth end
  void handleClick(String value) {
    setState(() {
      switch (value) {
        case "googlesignin":
          print('google');
          _GooglesignIn().then((value) => {});
          break;
        case "signout":
          setState(() {
            FirebaseAuth.instance.signOut();
            _logged_in = false;
            showDialog(
                context: context,
                builder: (_) => new AlertDialog(
                      title: new Text("تم تسجيل خروجك بنجاح",
                          style: AppTypography.bodyNormal
                              .copyWith(color: AppColors.darkBlue)),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            'تم',
                            style: AppTypography.bodyNormal
                                .copyWith(color: AppColors.darkBlue),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ));
          });
      }
    });
  }

  showLogin(BuildContext context) {
    read_token();
    return PopupMenuButton<String>(
        onSelected: handleClick,
        icon: Icon(Icons.person),
        itemBuilder: (BuildContext context) {
          if (!_logged_in) {
            return ["googlesignin"].map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text("Google sign in",
                      style: AppTypography.bodyNormal
                          .copyWith(color: AppColors.darkBlue)),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    FontAwesomeIcons.google,
                    color: AppColors.darkBlue,
                  ),
                ]),
              );
            }).toList();
          } else {
            return ["signout"].map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text("تسجيل خروج",
                      style: AppTypography.bodyNormal
                          .copyWith(color: AppColors.darkBlue)),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.logout,
                    color: AppColors.darkBlue,
                  ),
                ]),
              );
            }).toList();
          }
        });
  }

  TextEditingController ques = TextEditingController();

  Stream<QuerySnapshot> firebaseStream;

  @override
  void initState() {
    super.initState();
    firebaseStream =
        FirebaseFirestore.instance.collection('questions').snapshots();
  }

  bool answeredOnly = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          // Add the app bar to the CustomScrollView.
          SliverAppBar(
              snap: false,
              actions: [
                IconButton(
                  icon: Icon(answeredOnly
                      ? Icons.question_answer
                      : Icons.question_answer_outlined),
                  onPressed: () {
                    setState(() {
                      answeredOnly = !answeredOnly;
                    });
                  },
                ),
                showLogin(context)
              ],
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //mainAxisSize: MainAxisSize.min,

                  children: [
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Text(
                        "عندك سؤال؟",
                        style: AppTypography.headerMedium.copyWith(
                          fontSize: 20,
                        ),
                      ),
                    )),
                  ]),
              backgroundColor: AppColors.darkBlue,
              floating: false,
              pinned: true,
              // Display a placeholder widget to visualize the shrinking size.
              //  Make the initial height of the SliverAppBar larger than normal.
              expandedHeight: 110,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                collapseMode: CollapseMode.pin,
                background: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: FlatButton(
                          onPressed: () {
                            read_token();
                            if (!_logged_in) {
                              showDialog(
                                  context: context,
                                  builder: (_) => new AlertDialog(
                                        title: new Text(
                                            "يجب عليك تسجيل الدخول أولًا",
                                            style: AppTypography.bodyNormal
                                                .copyWith(
                                                    color: AppColors.darkBlue)),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons.google,
                                                  color: AppColors.darkBlue,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text("تسجيل دخول",
                                                    style: AppTypography
                                                        .bodyMedium
                                                        .copyWith(
                                                            color: AppColors
                                                                .darkBlue)),
                                              ],
                                            ),
                                            onPressed: () {
                                              _GooglesignIn().then((value) => Navigator.of(context).pop());
                                              
                                            },
                                          )
                                        ],
                                      ));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (_) => new AlertDialog(
                                        title: Row(children: [
                                          FaIcon(
                                            FontAwesomeIcons.pen,
                                            color: AppColors.darkBlue,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("سؤال جديد",
                                              style: AppTypography.bodyNormal
                                                  .copyWith(
                                                      color:
                                                          AppColors.darkBlue)),
                                        ]),
                                        content: TextField(
                                          style: AppTypography.bodyMedium
                                              .copyWith(
                                                  color: AppColors.darkBlue),
                                          maxLines: null,
                                          controller: ques,
                                          decoration: InputDecoration(
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors.darkBlue,
                                                    width: 1.0),
                                              ),
                                              hintText: 'اكتب سؤالك',
                                              hintStyle: AppTypography
                                                  .bodyMedium
                                                  .copyWith(
                                                      color: Colors.grey[400])),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("اسأل",
                                                style: AppTypography.bodyMedium
                                                    .copyWith(
                                                        color: AppColors
                                                            .darkBlue)),
                                            onPressed: () {
                                              String q = ques.text;
                                              db.addQuestion(
                                                  q, _fAuth.currentUser.uid);
                                              ques.clear();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          FlatButton(
                                            child: Text("الغاء",
                                                style: AppTypography.bodyMedium
                                                    .copyWith(
                                                        color: AppColors
                                                            .darkBlue)),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ));
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                FontAwesomeIcons.pen,
                                color: Colors.white,
                                size: 19,
                              ),
                              Expanded(
                                  child: Center(
                                child: Text(
                                  "اسألنا !",
                                  style: AppTypography.bodyNormal
                                      .copyWith(color: Colors.white),
                                ),
                              ))
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          // Next, create a SliverList
          StreamBuilder<QuerySnapshot>(
              stream: firebaseStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> querySnapshot) {
                if (querySnapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        "حدث خطأ في الشبكة",
                        style: AppTypography.bodyMedium
                            .copyWith(color: AppColors.darkBlue),
                      ),
                    ),
                  );
                }

                if (querySnapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  List allQuestions = querySnapshot.data.docs;
                  if (answeredOnly)
                    allQuestions
                        .removeWhere((element) => element['answer'] == null);

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => QuestionCard(
                        qid: allQuestions[index]['qID'].toString(),
                        questionText: allQuestions[index]['question'],
                        useful: allQuestions[index]['useful'],
                        answerPreview: allQuestions[index]['answer'],
                        uid: allQuestions[index]['postedBy'],
                        loggedin: _logged_in,
                      ),
                      childCount:
                          allQuestions.isNotEmpty ? allQuestions.length : 0,
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}

//SliverList(
//           // Use a delegate to build items as they're scrolled on screen.
//           delegate: SliverChildBuilderDelegate(
//             // The builder function returns a ListTile with a title that
//             // displays the index of the current item.
//             (context, index) => QuestionCard(
//               questionText: "عندي سؤال مهم جدا واللهي ومحتاج جوابه بسرعة",
//               answerPreview:
//                   "ابشر يخوي جوابك جاي عالسريع ولا يهمك لانه السفارة الاسترالية اشي خرافي يعني",
//               askedBy: "someone",
//               useful: 5,
//             ),
//             // Builds 1000 ListTiles
//
//             childCount: 100,
//           ),
//         ),
//(context, index){
//                     return QuestionCard(qid: allQuestions[index]['qid'],);
//                   }
class QuestionCard extends StatefulWidget {
  QuestionCard(
      {Key key,
      this.questionText,
      this.answerPreview,
      //this.askedBy,
      this.useful,
      //       this.photoUrl,
      //       this.interested,
      this.qid,
      this.uid,
      this.loggedin})
      : super(key: key);
  final loggedin;
  final String qid;
  final String uid;
  String questionText;
  String answerPreview;
  List useful;

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  Map userInfo;

  String askedBy;

  String photoUrl;

  @override
  void initState() {
    super.initState();
    FireStoreAPI().getUserInfo(widget.uid).then((value) => userInfo = value);
  }

  bool isLiked() {
    if (!widget.loggedin)
      return false;
    else if (widget.useful.contains(FirebaseAuth.instance.currentUser.uid))
      return true;
    else
      return false;
  }

  Color borderColor = Color(0xff219ebc);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: borderColor),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 4,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ]),
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        child: ClipOval(
                            child: userInfo == null
                                ? Image.asset('assets/avatarph.png')
                                : Image.network(userInfo['photoUrl'])),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        flex: 11,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.questionText,
                              style: AppTypography.bodyNormal
                                  .copyWith(height: 1.5),
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.answerPreview != null
                                  ? widget.answerPreview
                                  : "لم تتم الاجابة على هذا السؤال بعد",
                              style: AppTypography.answerPreview.copyWith(
                                  color: widget.answerPreview == null
                                      ? AppColors.neutrals[600]
                                      : AppColors.neutrals[900],
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
              ],
            )),
      ),
      Positioned(
        left: 20,
        bottom: 0,
        child: SizedBox(
          height: 30,
          width: 50,
          child: RaisedButton(
            padding: EdgeInsets.all(0),
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: borderColor)),
            onPressed: () {
              if (!widget.loggedin) {
                showDialog(
                    context: context,
                    builder: (_) => new AlertDialog(
                          title: new Text("يجب عليك تسجيل الدخول أولًا",
                              style: AppTypography.bodyNormal
                                  .copyWith(color: AppColors.darkBlue)),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("تم",
                                  style: AppTypography.bodyMedium
                                      .copyWith(color: AppColors.darkBlue)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ));
              } else {
                if (isLiked()) {
                  widget.useful.remove(FirebaseAuth.instance.currentUser.uid);
                  FirebaseFirestore.instance
                      .collection('questions')
                      .doc(widget.qid)
                      .update({'useful': widget.useful});
                } else {
                  widget.useful.add(FirebaseAuth.instance.currentUser.uid);
                  FirebaseFirestore.instance
                      .collection('questions')
                      .doc(widget.qid)
                      .update({'useful': widget.useful});
                }
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.useful.length.toString(),
                  style: AppTypography.bodyNormal.copyWith(
                      color:
                          isLiked() ? AppColors.darkBlue : AppColors.lightBlue),
                ),
                SizedBox(
                  width: 3,
                ),
                Icon(
                  Icons.thumb_up,
                  color: isLiked() ? AppColors.darkBlue : AppColors.lightBlue,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
