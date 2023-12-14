abstract class SchedulerState{}

class LoadingState extends SchedulerState{}

class GetDataState extends SchedulerState{
  final String start_time;
  final String  end_time;
  GetDataState(this.start_time,this.end_time);
}

class ErrorState extends SchedulerState{}