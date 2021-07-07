import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../constraint.dart';

import '../../../../../helpers/helpers.dart' as helpers;

import '../../../../models/models.dart' as models;
import '../../../../providers/providers.dart' as providers;

import '../../../account_information/account_information_screen.dart';

import '../provider/profile_provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController(
        text: Provider.of<providers.Auth>(context, listen: false).token);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    final appointment =
        Provider.of<providers.Appointment>(context, listen: false);
    final cart = Provider.of<providers.Cart>(context, listen: false);
    final financial = Provider.of<providers.Financial>(context, listen: false);
    final notification =
        Provider.of<providers.Notification>(context, listen: false);
    final partner = Provider.of<providers.Partner>(context, listen: false);
    final payment = Provider.of<providers.Payment>(context, listen: false);
    return Consumer<ProfileProvider>(
      child: Column(
        children: [
          ListTile(
            onTap: () => Navigator.of(context)
                .pushNamed(AccountInformationScreen.routeName),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            leading: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
              color: PsykayGreenLightColor,
              child: Icon(
                Icons.edit,
                color: PsykayGreenColor,
                size: 25,
              ),
            ),
            title: Text(
              localization.translate('Edit profile'.pascalCase()),
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              localization.translate(
                  'Please complete your personal details'.capitalize()),
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                  fontWeight: FontWeight.w600),
            ),
            trailing:
                Icon(Icons.arrow_forward_ios, color: PsykayGreyColor, size: 25),
          ),
          Divider(
            height: 10,
            color: PsykayGreenColor.withOpacity(0.3),
            thickness: 1.5,
          ),
          ListTile(
            onTap: () => null,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            leading: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
              color: PsykayGreenLightColor,
              child: Icon(
                Icons.notifications_none_rounded,
                color: PsykayGreenColor,
                size: 25,
              ),
            ),
            title: Text(
              localization.translate('Notification'.pascalCase()),
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            ),
            trailing:
                Icon(Icons.arrow_forward_ios, color: PsykayGreyColor, size: 25),
          ),
          Divider(
            height: 10,
            color: PsykayGreenColor.withOpacity(0.3),
            thickness: 1.5,
          ),
          ListTile(
            onTap: () => null,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            leading: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
              color: PsykayGreenLightColor,
              child: Icon(
                Icons.history,
                color: PsykayGreenColor,
                size: 25,
              ),
            ),
            title: Text(
              localization.translate('History'.pascalCase()),
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            ),
            trailing:
                Icon(Icons.arrow_forward_ios, color: PsykayGreyColor, size: 25),
          ),
          Divider(
            height: 10,
            color: PsykayGreenColor.withOpacity(0.3),
            thickness: 1.5,
          ),
          ListTile(
            onTap: () => null,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            leading: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
              color: PsykayGreenLightColor,
              child: Icon(
                Icons.help_outline_outlined,
                color: PsykayGreenColor,
                size: 25,
              ),
            ),
            title: Text(
              localization.translate('Support'.pascalCase()),
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            ),
            trailing:
                Icon(Icons.arrow_forward_ios, color: PsykayGreyColor, size: 25),
          ),
          Divider(
            height: 10,
            color: PsykayGreenColor.withOpacity(0.3),
            thickness: 1.5,
          ),
          ListTile(
            onTap: () => null,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            leading: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
              color: PsykayGreenLightColor,
              child: Icon(
                Icons.language,
                color: PsykayGreenColor,
                size: 25,
              ),
            ),
            title: Text(
              localization.translate('Language'.pascalCase()),
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            ),
            trailing:
                Icon(Icons.arrow_forward_ios, color: PsykayGreyColor, size: 25),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
      builder: (_, provider, child) => provider.isInit
          ? helpers.LoadingPouringHourGlass()
          : CustomScrollView(
              slivers: [
                _AppBar(
                  provider: provider,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                        margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(7),
                              bottomRight: Radius.circular(7)),
                          color: Colors.white,
                        ),
                        child: child),
                    TextField(
                      controller: _textEditingController,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () => provider.logout(
                                context: context,
                                appointment: appointment,
                                cart: cart,
                                financial: financial,
                                notification: notification,
                                partner: partner,
                                payment: payment),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.exit_to_app_rounded,
                                  color: PsykayGreenColor,
                                  size: 25,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  localization.translate('Logout'.capitalize()),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ))
                  ]),
                )
              ],
            ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({Key key, this.provider}) : super(key: key);

  final ProfileProvider provider;

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    return SliverAppBar(
      toolbarHeight: 220,
      backgroundColor: PsykayGreenColor,
      flexibleSpace: Container(
        height: 240,
        margin: const EdgeInsets.fromLTRB(15, 45, 15, 0),
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(7), topLeft: Radius.circular(7)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        image: provider.userData.pictureUrl == null
                            ? null
                            : DecorationImage(
                                image:
                                    NetworkImage(provider.userData.pictureUrl),
                                fit: BoxFit.cover),
                        shape: BoxShape.circle),
                    child: provider.userData.pictureUrl != null
                        ? null
                        : CircleAvatar(
                            backgroundColor: PsykayGreyLightColor,
                            child: Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: 70,
                            ),
                          ),
                  ),
                  Positioned(
                    right: 5,
                    bottom: 5,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return _BottomSheet(
                                provider: provider,
                              );
                            });
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: PsykayGreenColor.withOpacity(0.55),
                        child: Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${provider.userData.firstName} ${provider.userData.lastName}',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              provider.userData.email ?? '',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    localization.translate(
                        'Please enter your psychological enquiry for our psychologists to assist you better.'
                            .capitalize()),
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: PsykayOrangeLightColor,
                    border: Border.all(color: PsykayOrangeColor),
                  ),
                  child: Text(localization.translate('Start'.capitalize()),
                      style: TextStyle(
                          fontSize: 12,
                          color: PsykayOrangeColor,
                          fontWeight: FontWeight.w600)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  final ProfileProvider provider;

  const _BottomSheet({Key key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => provider.pickImageFromGalery(context),
            child: Row(
              children: [
                Icon(
                  Icons.photo,
                  size: 25,
                  color: Colors.black54,
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    localization
                        .translate('Take a picture from galery'.capitalize()),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => provider.pickImageFromCamera(context),
            child: Row(
              children: [
                Icon(
                  Icons.photo_camera_outlined,
                  color: Colors.black54,
                  size: 25,
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    localization
                        .translate('Take a picture from camera'.capitalize()),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
