import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/screens/profile_screen.dart/widget/edit_profile_form.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


class ProfileSection extends StatelessWidget {
   ProfileSection({super.key});

  final String _fullName = "Nick Frost";

  final String _bio =
      "\"Find the latest fashion trends, discover unique home decor pieces, and explore effective beauty products while enjoying a seamless and secure e-commerce shopping experience.\"";

  final String _followers = "173";

  final String _posts = "24";

  final String _scores = "450";

  final _formKey = GlobalKey<FormBuilderState>();

  //final _formData = FormData();
  @override
  Widget build(BuildContext context) {
  //  final lang = Lang.of(context);
    final themeData = Theme.of(context);
    Size screenSize = MediaQuery.of(context).size;
    return PortalMasterLayout(
      body: EntranceFader(
        child: ListView(
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 150,
                      color: AppColors.defaultColor.withOpacity(0.6),  
                    ),
                    Align(
                      // heightFactor: 0.01,
                      child: Container(
                        height: 100,
                        alignment: Alignment.centerLeft,
                        padding:  EdgeInsets.symmetric(
                         
                            horizontal: kDefaultPadding),
                        margin:  EdgeInsets.all(kDefaultPadding),
                        decoration: BoxDecoration(
                            color: themeData.cardColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/profile3.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                            buildSizedboxW(kDefaultPadding),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Admin',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500)),
                                Text('Flutter devlopment',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                buildSizedBoxH(kDefaultPadding * 3),
                screenSize.width >= kScreenWidthLg
                    ? Padding(
                        padding:  EdgeInsets.symmetric(
                            horizontal: kDefaultPadding,
                            vertical: kDefaultPadding + kTextPadding),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                                flex: 2, child: editProile( themeData)),
                            buildSizedboxW(kDefaultPadding),
                            Container(
                              // pa: const EdgeInsets.only(right: kDefaultPadding),
                              width: screenSize.width / 4,
                              decoration: BoxDecoration(
                                  color: themeData.cardColor,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Stack(
                                children: <Widget>[
                                  _buildCoverImage(screenSize),
                                  Padding(
                                    padding:  EdgeInsets.symmetric(
                                        horizontal: kDefaultPadding,
                                        vertical: kDefaultPadding),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(
                                            height: screenSize.height / 3.9),
                                        _buildProfileImage(),
                                        _buildStatContainer(),
                                        _buildBio(context),
                                        _buildSeparator(screenSize),
                                        const SizedBox(height: 10.0),
                                        _buildGetInTouch(context),
                                        const SizedBox(height: 8.0),
                                        _buildButtons(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding:  EdgeInsets.symmetric(
                            horizontal: kDefaultPadding,
                            vertical: kDefaultPadding + kTextPadding),
                        child: Column(
                          children: [
                            editProile(themeData),
                            buildSizedBoxH(kDefaultPadding),
                            Center(
                              child: Container(
                                // margin: const EdgeInsets.only(right: kDefaultPadding),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: themeData.cardColor,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Stack(
                                  children: <Widget>[
                                    _buildCoverImage(screenSize),
                                    Padding(
                                      padding:  EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding,
                                          vertical: kDefaultPadding),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                              height: screenSize.height / 3.9),
                                          _buildProfileImage(),
                                          _buildStatContainer(),
                                          _buildBio(context),
                                          _buildSeparator(screenSize),
                                          const SizedBox(height: 10.0),
                                          _buildGetInTouch(context),
                                          const SizedBox(height: 8.0),
                                          _buildButtons(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
            buildSizedBoxH(kDefaultPadding),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.8,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        image: DecorationImage(
          image: NetworkImage(
              'https://pbs.twimg.com/profile_banners/3015219910/1559145714/1500x500'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/profile3.jpg'),   
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle statLabelTextStyle = const TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle statCountTextStyle = const TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: statCountTextStyle,
        ),
        Text(
          label,
          style: statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Followers", _followers),
          _buildStatItem("Posts", _posts),
          _buildStatItem("Scores", _scores),
        ],
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = const TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400, //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        _bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black26,
      margin: const EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildGetInTouch(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        "Get in Touch with ${_fullName.split(" ")[0]},",
        style: const TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => print("followed"),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: const Color(0xFF404A5C),
                ),
                child: const Center(
                  child: Text(
                    "FOLLOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              onTap: () => print("Message"),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("MESSAGE",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget editProile( ThemeData themeData) {
    return Container(
      padding:  EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
          color: themeData.cardColor, borderRadius: BorderRadius.circular(12)),
      child: const EditProfileForm()  
    );
  }
}
