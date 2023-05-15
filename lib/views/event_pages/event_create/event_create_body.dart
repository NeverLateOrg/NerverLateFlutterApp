import 'package:flutter/material.dart';
import 'package:never_late_api_refont/extensions/date_time_extensions.dart';
import 'package:never_late_api_refont/main.dart';
import 'package:never_late_api_refont/models/google_location.dart';
import 'package:never_late_api_refont/services/api_services/dtos/events/CreateEventDTO.dart';
import 'package:never_late_api_refont/services/data_services/event_service.dart';
import 'package:never_late_api_refont/views/locations_page/search_page/locations_search_page.dart';
import 'package:never_late_api_refont/widgets/date_time_selector.dart';

class EventCreateBody extends StatefulWidget {
  const EventCreateBody({Key? key}) : super(key: key);

  @override
  _EventCreateBodyState createState() => _EventCreateBodyState();
}

class _EventCreateBodyState extends State<EventCreateBody> {
  final GlobalKey<FormState> _form = GlobalKey();

  late TextEditingController _startDateController;
  late TextEditingController _startTimeController;
  late TextEditingController _endDateController;
  late TextEditingController _endTimeController;

  String _title = "";

  late DateTime _startDate;
  late DateTime _endDate;
  DateTime? _endTime;
  DateTime? _startTime;
  late String? _location;

  // FIXME: This should be used instead of `_location`
  GoogleLocation? _locationObject;

  @override
  void initState() {
    super.initState();

    _startDateController = TextEditingController();
    _startDateController.text =
        DateTime.now().dateToStringWithFormat(format: "dd/MM/yyyy");
    _startTimeController = TextEditingController();
    _endDateController = TextEditingController();
    _endDateController.text =
        DateTime.now().dateToStringWithFormat(format: "dd/MM/yyyy");
    _endTimeController = TextEditingController();
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _startTimeController.dispose();
    _endDateController.dispose();
    _endTimeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Event Title",
              ),
              onSaved: (newValue) => _title = newValue?.trim() ?? "",
              validator: (value) {
                if (value == null || value == "") {
                  return "Please enter event title.";
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: DateTimeSelectorFormField(
                    controller: _startDateController,
                    decoration: const InputDecoration(labelText: "Start Date"),
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please select start date.";
                      }
                      return null;
                    },
                    onSave: (date) => _startDate = date,
                    type: DateTimeSelectionType.date,
                  ),
                ),
                Expanded(
                  child: DateTimeSelectorFormField(
                    controller: _startTimeController,
                    decoration: const InputDecoration(labelText: "Start Time"),
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please select start time.";
                      }
                      return null;
                    },
                    onSave: (date) => _startTime = date,
                    type: DateTimeSelectionType.time,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: DateTimeSelectorFormField(
                    controller: _endDateController,
                    decoration: const InputDecoration(labelText: "End Date"),
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please select end date.";
                      }
                      return null;
                    },
                    onSave: (date) => _endDate = date,
                    type: DateTimeSelectionType.date,
                  ),
                ),
                Expanded(
                  child: DateTimeSelectorFormField(
                    controller: _endTimeController,
                    decoration: const InputDecoration(labelText: "End Time"),
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please select end time.";
                      }
                      return null;
                    },
                    onSave: (date) => _endTime = date,
                    type: DateTimeSelectionType.time,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: SizedBox(
              width: double.infinity,
              height: 60.0,
              child: InkWell(
                onTap: () => _addLocation(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add_location),
                      const SizedBox(width: 8),
                      _locationObject != null
                          ? Expanded(
                              child: Text(
                                '${_locationObject!.name}, ${_locationObject!.address}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Text(
                              'Add location',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () => _createEvent(context),
              child: const Text("Create Event"),
            ),
          ),
        ],
      ),
    );
  }

  void _addLocation() async {
    final selectedLocation = await navigatorKey.currentState!.push<
            GoogleLocation>(
        MaterialPageRoute(builder: (context) => const LocationsSearchPage()));
    if (selectedLocation != null) {
      setState(() {
        _locationObject = selectedLocation;
      });
    }
  }

  void _createEvent(BuildContext context) async {
    if (!(_form.currentState?.validate() ?? true)) return;

    _form.currentState?.save();
    final start = _startTime!.changeDateTo(_startDate);
    final end = _endTime!.changeDateTo(_endDate);

    final eventDTO = CreateEventDTO(
      title: _title,
      startDate: start,
      endDate: end,
      location: _locationObject?.address,
    );

    final validation = eventDTO.isValid();
    if (!validation) {
      print('TODO: Shoidw error message for $validation');
      return;
    }

    _resetForm();
    await EventService().createEvent(eventDTO);
    navigatorKey.currentState!.pop();
  }

  void _resetForm() {
    _form.currentState?.reset();
    _startDateController.text = "";
    _startTimeController.text = "";
    _endDateController.text = "";
    _endTimeController.text = "";
  }
}
