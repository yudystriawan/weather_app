import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/region_form/region_form_cubit.dart';
import 'package:weather_app/features/weather/presentation/widgets/regions_bottom_sheet.dart';

class RegionFormWidget extends StatelessWidget {
  const RegionFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegionFormCubit, RegionFormState>(
      buildWhen: (p, c) => p.selectedRegion != c.selectedRegion,
      builder: (context, state) {
        final region = state.selectedRegion;
        return Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => showRegionBottomSheet(context).then((region) {
                if (region == null) return;
                context.read<RegionFormCubit>().regionChanged(region);
              }),
              child: Row(
                children: [
                  Text(
                    region.province,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),
            Text(region.city),
          ],
        );
      },
    );
  }
}
