import 'package:about_australia/components/onboarding_data.dart';
import 'package:flutter/material.dart';
import 'package:about_australia/components/bottom_navigation_tabs_controller.dart';
import 'package:about_australia/theme/app_typography.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:about_australia/fireStore_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:about_australia/theme/app_colors.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<SliderModel> slide = new List<SliderModel>();
  int currentIndex = 0;
  PageController controller = new PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    slide = getSlides();
  }

  Widget pageIndexIndicator(bool isCurrent, int index, colour) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2),
        height: isCurrent ? 15.0 : 9.0,
        width: isCurrent ? 15.0 : 9.0,
        decoration: BoxDecoration(
          color: isCurrent ? colour : Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  //auth params, I didn't put them in a separate class cuz it fucked everything up when I tried
  var _token;

  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  bool _logged_in;
  final storage = new FlutterSecureStorage();
  DatabaseReference ref = FirebaseDatabase.instance.reference();
  final db = FireStoreAPI();

  //Google login
  //login proved us with username, imageurl, token and user id
  // ignore: non_constant_identifier_names
  Future<User> _GooglesignIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: gSA.accessToken,
      idToken: gSA.idToken,
    );

    User googleuser = (await _fAuth.signInWithCredential(credential)).user;

    var displayname = googleuser.displayName;
    var photourl = googleuser.photoURL;
    var userid = googleSignInAccount.id;
    var token = gSA.accessToken;
    var uid = _fAuth.currentUser.uid;
    db.addUser(displayname, photourl, userid, token, uid);
    print(displayname);

    store_token(token);
    read_token();
    ref.child('user').child(userid).once().then((DataSnapshot snap) {
      var data = snap.value;
      if (data == null) {
        ref.child('newuser').set(displayname);
        post_UserData(userid, displayname, photourl);
      } else {
        post_UserData(userid, displayname, photourl);
      }
    });

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

  void post_UserData(var userid, var username, var userimage) {
    ref.child('user').child(userid).child('imageurl').set(userimage);
    ref.child('user').child(userid).child('name').set(username);
  }

  Future store_token(String valid_token) async {
    await storage.write(key: 'valid_token', value: '$valid_token');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: <Widget>[
        PageView.builder(
          controller: controller,
          itemCount: slide.length,
          onPageChanged: (val) {
            setState(() {
              currentIndex = val;
            });
          },
          itemBuilder: (context, index) {
            return Slider(
              imageAssetPath: slide[index].getImageAssetPath(),
              title: slide[index].getTitle(),
              desc: slide[index].getDesc(),
              colour: slide[index].getColour(),
            );
          },
        ),
        currentIndex == 3
            ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 10, top: 10, bottom: 10),
                          child: Container(
                            height: 50,
                            child: Expanded(
                              flex: 6,
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavigationBarController(
                                                currentIndex: 1)),
                                  );
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                color: Colors.transparent,
                                child: Text("المتابعة بدون حساب",
                                    style: AppTypography.bodyMedium
                                        .copyWith(color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 5, top: 10, bottom: 10),
                          child: Container(
                            height: 50,
                            child: Expanded(
                              flex: 4,
                              child: FlatButton(
                                onPressed: () {
                                  _GooglesignIn().then((value) => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavigationBarController(
                                                currentIndex: 1)),
                                  ));
                                  
                                },
                                color: Colors.grey.withOpacity(0.4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.google,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("تسجيل دخول",
                                        style: AppTypography.bodyMedium
                                            .copyWith(color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 40,
                      width: 75,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        hoverColor: Colors.redAccent,
                        onPressed: () {
                          controller.animateToPage(3,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.linear);
                        },
                        color: Colors.grey.withOpacity(0.3),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: Text("تخطي",
                              style: AppTypography.bodyMedium
                                  .copyWith(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Material(
                            color: Colors.transparent,
                            child: IconButton(
                              icon: Icon(Icons.navigate_before,
                                  color: currentIndex != 0
                                      ? Colors.white
                                      : Colors.transparent),
                              iconSize: 40,
                              onPressed: () {
                                controller.animateToPage(currentIndex - 1,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.linear);
                              },
                            )),
                        Row(
                          children: <Widget>[
                            for (int i = 0; i < slide.length; i++)
                              currentIndex == i
                                  ? pageIndexIndicator(true, i, slide[i].colour)
                                  : pageIndexIndicator(
                                      false, i, slide[i].colour),
                          ],
                        ),
                        Material(
                            color: Colors.transparent,
                            child: IconButton(
                              icon: Icon(Icons.navigate_next,
                                  color: Colors.white),
                              iconSize: 40,
                              onPressed: () {
                                controller.animateToPage(currentIndex + 1,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.linear);
                              },
                            )),
                      ],
                    ),
                  ),
                ],
              )
      ]),
    );
  }
}

class Slider extends StatelessWidget {
  String imageAssetPath, title, desc;
  Color colour;

  Slider({this.imageAssetPath, this.title, this.desc, this.colour});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageAssetPath),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      AppColors.darkBlue.withOpacity(0.6),
                      AppColors.darkBlue.withOpacity(0.4),
                      AppColors.darkBlue.withOpacity(0.3),
                      Colors.white.withOpacity(0.3),
                      Colors.grey.withOpacity(0.6),
                    ],
                    begin: AlignmentDirectional.topCenter,
                    end: Alignment.bottomCenter),
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [],
                  ),
                  SizedBox(
                    height: 250,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    height: 40,
                    width: 110,
                    child: Center(
                      child: Text(title,
                          textAlign: TextAlign.center,
                          style: AppTypography.bodyMedium
                              .copyWith(color: Colors.white)),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: colour),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    desc,
                    style:
                        AppTypography.bodyNormal.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//                  Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             BottomNavigationBarController(currentIndex: 0)),
//                   );
