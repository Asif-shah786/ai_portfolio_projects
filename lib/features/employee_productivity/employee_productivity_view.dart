import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../models/productivity_sample_model.dart';
import 'bloc/emplyee_productivity_bloc.dart';

class EmployeeProductivityView extends HookWidget {
  const EmployeeProductivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildHeader(context),
            _buildProductivityForm(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildHeader(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Employee Productivity",
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      const SizedBox(height: 8),
      Text(
        "Machine Learning Approach for Predicting and Optimizing Garment Industry Employee Productivity",
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey[600],
            ),
      ),
    ],
  );
}

enum InputMode { sample, manual }

Widget _buildProductivityForm(BuildContext context) {
  final selectedMode = useState(InputMode.sample);
  final selectedSample = useState<ProductivitySample?>(null);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 24),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio<InputMode>(
            value: InputMode.sample,
            groupValue: selectedMode.value,
            onChanged: (value) => selectedMode.value = value!,
          ),
          const Text('Select Sample Input'),
          const SizedBox(width: 16),
          Radio<InputMode>(
            value: InputMode.manual,
            groupValue: selectedMode.value,
            onChanged: (value) => selectedMode.value = value!,
          ),
          const Text('Insert Input'),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: selectedMode.value == InputMode.sample
            ? _SampleInputList(
                selectedSample: selectedSample.value,
                onSampleSelected: (sample) => selectedSample.value = sample,
              )
            : const _ManualInputForm(),
      ),
      const SizedBox(height: 16),
      ResultWidget(
        sample: selectedSample.value,
      ),
    ],
  );
}

class _SampleInputList extends StatelessWidget {
  const _SampleInputList({
    required this.selectedSample,
    required this.onSampleSelected,
  });

  final ProductivitySample? selectedSample;
  final void Function(ProductivitySample?) onSampleSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...sampleData.map((sample) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                  selected: selectedSample == sample,
                  selectedTileColor: Colors.blue[50],
                  title: Text('Team ${sample.team} - ${sample.department}'),
                  subtitle:
                      Text('${sample.day} | Workers: ${sample.noOfWorkers}\nSMV: ${sample.smv} | WIP: ${sample.wip}'),
                  onTap: () => onSampleSelected(selectedSample == sample ? null : sample),
                  trailing: Icon(selectedSample == sample ? Icons.check : null)),
            )),
      ],
    );
  }
}

class _ManualInputForm extends StatelessWidget {
  const _ManualInputForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text('Feature is in Backlog...')),
      ],
    );
  }
}

class ResultWidget extends HookWidget {
  const ResultWidget({
    super.key,
    required this.sample,
  });

  final ProductivitySample? sample;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmplyeeProductivityBloc, EmplyeeProductivityState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: sample == null
                  ? null
                  : () {
                      context.read<EmplyeeProductivityBloc>().add(PredictProductivity(sample!));
                    },
              child: Text(state is EmplyeeProductivityLoading ? 'Loading...' : 'Fetch Results'),
            ),
            const SizedBox(height: 16),
            if (state is EmplyeeProductivityLoading)
              SizedBox(height: 30, width: 30, child: const CircularProgressIndicator())
            else if (state is EmplyeeProductivityLoaded)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: state.prediction > 0.5 ? Colors.green[100] : Colors.red[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'With current inputs, the productivity of your employee will ${state.prediction == 1 ? 'be Excellent' : 'not be Good'}. ${state.prediction > 0.7 ? 'Keep up the good work!' : 'Consider optimizing the work conditions.'}',
                ),
              )
            else if (state is EmplyeeProductivityError)
              Text('Error: ${state.message}', style: const TextStyle(color: Colors.red)),
          ],
        );
      },
    );
  }
}
