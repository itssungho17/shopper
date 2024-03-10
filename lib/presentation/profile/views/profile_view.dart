import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopper/data/models/auth/user.dart';
import 'package:shopper/presentation/profile/viewmodels/profile_viewmodel.dart';
import 'package:shopper/domain/providers/auth_provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late ProfileViewModel _vm;

  @override
  void initState() {
    _vm = ProfileViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('프로필',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 32),
          Visibility(
            visible: user == null,
            child: Column(
              children: [
                Text('로그인 후 서비스를 이용해주세요.',
                  style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 32),
                SizedBox(
                  width: 200,
                  child: Text('username: kminchelle',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 200,
                  child: Text('password: 0lelplR',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),),
                ),
              ]
            )
          ),
          Visibility(
            visible: user != null,
            child: Column(
              children: [
                _buildProfileImage(user, context),
                const SizedBox(height: 32),
                Text('${ user?.firstName ?? ''} ${user?.lastName ?? ''}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                Text(user?.email ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          _buildLoginButton(user, context)
        ]
      ),
    );
  }

  Container _buildProfileImage(User? user, BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(user?.image ?? ''),
        ),
      ),
    );
  }

  Container _buildLoginButton(User? user, BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 120,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(user == null ? '로그인' : '로그아웃',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            )
          ),
        ),
        onPressed: () {
          if (user == null) {
            _vm.login();
          } else {
            context.read<AuthProvider>().logout();
          }
        }
      )
    );
  }
}
