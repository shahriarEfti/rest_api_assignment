import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Controllers/data_controller.dart';
import '../Models/photo_model.dart';
import '../Services/api_fetch.dart';
import '../Utils/constants.dart';
import 'home_screen_list_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DataController dataController;
  List<PhotoModel> photoModel = [];

  @override
  void initState() {
    super.initState();
    dataController = DataController(ApiFetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(firstAppbarTitle),
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return Container(
            margin: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                FutureBuilder<List<PhotoModel>>(
                  future: dataController.loadPhotos(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: LinearProgressIndicator(),
                      );
                    } else if (snapshot.hasData && snapshot.data != null) {
                      photoModel = snapshot.data!;
                      return Visibility(
                        visible: photoModel.isNotEmpty && !dataController.isErrorOccurred,
                        replacement: _buildErrorWidget(context),
                        child: _buildPhotoList(orientation),
                      );
                    } else {
                      return _buildErrorWidget(context);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPhotoList(Orientation orientation) {
    return Expanded(
      child: ListView.separated(
        itemCount: photoModel.length,
        itemBuilder: (BuildContext context, int index) {
          return HomeScreenListLayout(
            orientation: orientation,
            photoModel: photoModel,
            index: index,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10);
        },
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              errorImage,
              height: MediaQuery.of(context).size.height * 0.4,
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(height: 10),
          const Text(errorMessage),
        ],
      ),
    );
  }
}
