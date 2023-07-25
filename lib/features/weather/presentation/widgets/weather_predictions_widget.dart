import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/styles/typography/text_style.dart';
import 'package:weather_app/core/utils/date_formatter.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_image.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_temp_info_widget.dart';

import '../bloc/weather_loader/weather_loader_cubit.dart';

class WeatherPredictionsWidget extends StatelessWidget {
  const WeatherPredictionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherLoaderCubit, WeatherLoaderState>(
      builder: (context, state) {
        return state.map(
          initial: (_) => const SizedBox(),
          loadInProgress: (_) => const Center(
            child: CircularProgressIndicator(),
          ),
          loadFailure: (_) => const SizedBox(),
          loadSuccess: (value) {
            final weathersMap = value.weathers;

            return DefaultTabController(
              length: weathersMap.keys.size,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    isScrollable: true,
                    physics: const NeverScrollableScrollPhysics(),
                    labelStyle: AppTextStyle.bodyText1.bold,
                    labelPadding: EdgeInsets.only(right: 12.w),
                    tabs: weathersMap.keys
                        .asSet()
                        .map(
                          (dateTime) => Tab(
                            text: dateTime.toDayFormatted(),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    height: 16.w,
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: weathersMap.values.iter
                          .map(
                            (weatherList) => ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              itemCount: weatherList.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  width: 36.w,
                                );
                              },
                              itemBuilder: (BuildContext context, int index) {
                                final weather = weatherList[index];
                                return SingleChildScrollView(
                                  physics: const ClampingScrollPhysics(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        weather.time!.toDateFormatted('HH:mm'),
                                        style: AppTextStyle.bodyText1.bold,
                                      ),
                                      SizedBox(
                                        height: 16.w,
                                      ),
                                      WeatherImage(
                                        weather: weather,
                                        size: 48.w,
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      WeatherTempInfoWidget(
                                        style: AppTextStyle.headline6.bold,
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            );

            // return ListView.separated(
            //   shrinkWrap: true,
            //   scrollDirection: Axis.horizontal,
            //   itemCount: weathers.size,
            //   separatorBuilder: (BuildContext context, int index) {
            //     return const SizedBox(
            //       width: 12,
            //     );
            //   },
            //   itemBuilder: (BuildContext context, int index) {
            //     final weather = weathers[index];
            //     return Column(
            //       children: [
            //         Text(weather.time.toDateFormatted('hh:mm')),
            //         Text(weather.tempC.toString()),
            //       ],
            //     );
            //   },
            // );
          },
        );
      },
    );
  }
}
