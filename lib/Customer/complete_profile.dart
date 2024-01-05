
import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:flutter/cupertino.dart';

class CompleteCustomerProfile extends StatefulWidget {
  const CompleteCustomerProfile({super.key});

  @override
  State<CompleteCustomerProfile> createState() => _CompleteCustomerProfileState();
}

class _CompleteCustomerProfileState extends State<CompleteCustomerProfile> {

    int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return MyCupertinoStepper();
  }
   CupertinoStepper MyCupertinoStepper() {

      bool canCancel = currentStep > 0;
  bool canContinue = currentStep < 3;


    return CupertinoStepper(
    type: StepperType.vertical,
    currentStep: currentStep,
    onStepTapped: (step) => setState(() => currentStep = step),
    onStepCancel: canCancel ? () => setState(() => --currentStep) : null,
    onStepContinue: canContinue ? () => setState(() => ++currentStep) : null,
    steps: [
      for (var i = 0; i < 2; ++i)
        _buildStep(
          title: Text('Step ${i + 1}'),
          subtitle: "Step Sub ${i + 1}" ,
          isActive: i == currentStep,
          state: i == currentStep
              ? StepState.editing
              : i < currentStep ? StepState.complete : StepState.indexed,
        ),
      // _buildStep(
      //   title: const Text('Error'),
      //   subtitle: "Finished" ,
      //   state: StepState.error,
      // ),
      // _buildStep(
      //   title: const Text('Disabled'),
      //   subtitle: "Finished" ,
      //   state: StepState.disabled,
      // )
    ],
         );
    }


      Step _buildStep({
    required Widget title,
    required String subtitle,
    StepState state = StepState.indexed,
    bool isActive = false,
  }) {
    return Step(
      title: title,
      subtitle:  Text(subtitle),
      state: state,
      isActive: isActive,
      content: LimitedBox(
        maxWidth: 200,
        maxHeight: 200,
        child: Container(color: CupertinoColors.systemGrey),
      ),
    );
  }
  }
