import 'package:adminpanel/layout/dashboard_layout/cubit/cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/dashboard_layout/cubit/states.dart';
import '../../../models/user/user_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../translations/locale_keys.g.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    DashboardCubit.get(context).getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: 2.0),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    itemBuilder: (context, index) => SizedBox(
                      height: 110.0,
                      child: InkWell(
                        onTap: () {
                          navigateTo(
                            context,
                            OpenSellerAdminScreen(
                                user: DashboardCubit.get(context).users[index]),
                          );
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 40.0,
                              backgroundImage: NetworkImage(
                                DashboardCubit.get(context).users[index].image,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DashboardCubit.get(context).users[index].firstName +
                                      ' ' +
                                      DashboardCubit.get(context)
                                          .users[index]
                                          .secondName,
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  DashboardCubit.get(context).users[index].city,
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  DashboardCubit.get(context).users[index].area,
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor: DashboardCubit.get(context).users[index].isEmailVerfied
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                const Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: DashboardCubit.get(context).users.length,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class OpenSellerAdminScreen extends StatelessWidget {
  const OpenSellerAdminScreen({
    Key key,
    this.user,
  }) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        DashboardCubit.get(context)
                            .deleteUser(
                              uid: user.uId,
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    IconButton(
                      onPressed: () {
                        DashboardCubit.get(context)
                            .undeleteUser(
                              uid: user.uId,
                            );
                      },
                      icon: const Icon(Icons.restore_rounded),
                    ),
                  ],
                ),
                Image(
                  image: NetworkImage(
                    user.image,
                  ),
                  // width: 500,
                  width: double.infinity,
                ),
                DashboardCubit.get(context).isSaturday != null
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  DashboardCubit.get(context).isSaturday
                                      ? GestureDetector(
                                          child: buildSizeCircle(
                                              size: 'SAT', state: true),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  DashboardCubit.get(context).isSunday
                                      ? GestureDetector(
                                          child: buildSizeCircle(
                                              size: 'SUN', state: true),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  DashboardCubit.get(context).isMonday
                                      ? GestureDetector(
                                          child: buildSizeCircle(
                                              size: 'MON', state: true),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  DashboardCubit.get(context).isTuesday
                                      ? GestureDetector(
                                          child: buildSizeCircle(
                                              size: 'TUS', state: true),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  DashboardCubit.get(context).isWednesday
                                      ? GestureDetector(
                                          child: buildSizeCircle(
                                              size: 'WED', state: true),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  DashboardCubit.get(context).isThursday
                                      ? GestureDetector(
                                          child: buildSizeCircle(
                                              size: 'THU', state: true),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  DashboardCubit.get(context).isFriday
                                      ? GestureDetector(
                                          child: buildSizeCircle(
                                              size: 'FRI', state: true),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Text(
                      LocaleKeys.sellerAcountScreen_sellerName.tr() + ': ',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.firstName + ' ' + user.secondName,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      LocaleKeys.sellerRequestScreen_address.tr() + ': ',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.address,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      LocaleKeys.signUpScreen_area.tr() + ': ',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.area,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      LocaleKeys.signUpScreen_select_City.tr() + ': ',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.city,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
