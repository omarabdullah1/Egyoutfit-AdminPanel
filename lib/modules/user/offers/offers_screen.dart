import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../models/shop_app/products_model.dart';
import '../../../shared/components/components.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({Key key}) : super(key: key);

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}
class _OffersScreenState extends State<OffersScreen> {
  @override
  void initState() {
    ShopCubit.get(context).getAllOffers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        ShopCubit.get(context).getAllOffers();
        return BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            // return const Center(child: Text('offers'),);
            return ListView.separated(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  height: 200,
                  child: Image(
                    image: NetworkImage(ShopCubit.get(context).offers[index]),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: ShopCubit.get(context).offers.length,
            );
          },
        );
      }
    );
  }

  Widget buildCatItem(ShopProductsModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image.first),
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              model.name,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      );
}
