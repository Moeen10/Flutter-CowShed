import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/Scheduler/Cubit/SchedilerCubit.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/Scheduler/Cubit/SchedulerState.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/addScheduler.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/LoadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Scheduler extends StatelessWidget {
  const Scheduler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("সময়সূচী"),
          centerTitle: true,
      ),
      body:
      BlocProvider(
        create: (context) => SchedulerCubit(),
        child: Builder(
          builder: (context) {
            final cubit = BlocProvider.of<SchedulerCubit>(context);

            return BlocConsumer<SchedulerCubit, SchedulerState>(
              bloc: cubit,
              builder: (context, state){
                if(state is LoadingState){
                  return LoadingIndicator();
                }
                else if(state is GetDataState){
                  return Container(
                    height: 150,
                    child: Card(
                      elevation: 4.0,
                      margin: EdgeInsets.all(16.0),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text( "শুরুর সময়: ${state.start_time}",style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                                Spacer(),
                                Text( "শেষ সময় : ${state.end_time}",style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );


                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text( "Start Time : ${DateFormat('hh:mm a').format(
                        DateTime.parse("0000-00-00 ${state.start_time[0]}${state.start_time[1]}:${state.start_time[2]}${state.start_time[3]}:00"),
                      )}",),
                      Text( "End Time : ${DateFormat('hh:mm a').format(
                        DateTime.parse("0000-00-00 ${state.end_time[0]}${state.end_time[1]}:${state.end_time[2]}${state.end_time[3]}:00"),
                      )}",)
                    ],
                  );
                }
                else{
                  return Container();
                }
              },
              listener: (context, state) {},
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddScheduler(),));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
