import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/screens/signIn/sign_up/sign_up_controller.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/widgets/custom_button.dart';
import 'package:water_customer_app/widgets/custom_dropdown.dart';
import 'package:water_customer_app/widgets/custom_text_Field.dart';
import 'package:water_customer_app/widgets/day_selection_grid.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
 SignUpController signUpController=Get.put(SignUpController());
@override
  void initState() {
    signUpController.getEmirateLocation('sales_test','sales_test');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        color: CustomColors.white,
        image: DecorationImage(
          image: AssetImage('Assets/Images/LogIn/signInBg.png'),
          // Replace with your image path
          fit: BoxFit.none, // Adjust fit as needed (cover, fill, etc.)
        ),
      ),
      child: Scaffold(
        backgroundColor: CustomColors.whiteOP,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * .2,
                ),
                Text(
                  'Sign Up',
                  style: grayHeadStyle1,
                ),
                SizedBox(height: screenHeight * .1),
                CustomTextField(
                  // icon: Icons.person_add,
                  label: 'Full Name',
                  color: CustomColors.text,
                  borderColor: CustomColors.textBoxBorderColor,
                  border: true,
                  controller:signUpController. fullNameController, textAlign: TextAlign.left,
                ),
                Obx(()=>errorTextWidget(signUpController.errors['fullName'])),
                SizedBox(height: screenHeight * .020),
                CustomTextField(
                  // icon: Icons.account_balance_outlined,
                  label: 'Building Name',
                  color: CustomColors.text,
                  borderColor: CustomColors.textBoxBorderColor,
                  border: true,
                  controller:signUpController.buildingNameController, textAlign: TextAlign.left,
                ),
                 Obx(()=> errorTextWidget(signUpController.errors['buildingName'])),
                SizedBox(height: screenHeight * .020),
                CustomTextField(
                  // icon: Icons.person_add,
                  label: 'Floor No',
                  color: CustomColors.text,
                  borderColor: CustomColors.textBoxBorderColor,
                  border: true,
                  controller: signUpController.floorNoController, textAlign: TextAlign.left,
                ),
                 Obx(()=> errorTextWidget(signUpController.errors['floorNo'])),

                SizedBox(height: screenHeight * .020),
                CustomTextField(
                  // icon: Icons.cabin_outlined,
                  label: 'Room No/Flat No/Villa No',
                  color: CustomColors.text,
                  borderColor: CustomColors.textBoxBorderColor,
                  border: true,
                  controller: signUpController.roomNoController, textAlign: TextAlign.left,
                ),
                 Obx(()=> errorTextWidget(signUpController.errors['roomNo'])),
                SizedBox(height: screenHeight * .020),
                CustomTextField(
                  // icon: Icons.mobile_screen_share_outlined,
                  label: 'Mobile No',
                  color: CustomColors.text,
                  borderColor: CustomColors.textBoxBorderColor,
                  border: true,keyboardType: TextInputType.number,
                  controller: signUpController.mobileNoController, textAlign: TextAlign.left,
                ),
                 Obx(()=> errorTextWidget(signUpController.errors['mobileNo'])),

                SizedBox(height: screenHeight * .020),
                CustomTextField(
                  // icon: Icons.email_sharp,
                  label: 'Email Id',
                  color: CustomColors.text,
                  borderColor: CustomColors.textBoxBorderColor,
                  border: true,
                  controller: signUpController.mailIdController, textAlign: TextAlign.left,
                ),
                 Obx(()=> errorTextWidget(signUpController.errors['mailId'])),

                SizedBox(height: screenHeight * .020),
                CustomTextField(
                  // icon: Icons.checklist_outlined,
                  label: 'No of 5 Gallon required ',
                  color: CustomColors.text,
                  keyboardType: TextInputType.number,
                  borderColor: CustomColors.textBoxBorderColor,
                  border: true,
                  controller: signUpController.bottleCountController, textAlign: TextAlign.left,
                ),
                 Obx(()=> errorTextWidget(signUpController.errors['bottleCount'])),

                // SizedBox(height: screenHeight * .020),
                // CustomTextField(
                //   icon: Icons.person,
                //   label: 'Username',
                //   color: CustomColors.text,
                //   borderColor: CustomColors.textBoxBorderColor,
                //   border: true,
                //   controller: userNameController, textAlign: TextAlign.left,
                // ),
                SizedBox(height: screenHeight * .020),
                Obx(()=> CustomDropdown(
                    label: 'Select Emirate',
                    icon: Icons.location_city,
                    color: CustomColors.text,
                    borderColor: CustomColors.textBoxBorderColor,
                    items: signUpController.emiratesList.map((emirate) {
                      return DropdownMenuItem<String>(
                        value: emirate.emirateId,
                        child: Text(emirate.name ?? ''),
                      );
                    }).toList(),
                    selectedValue: signUpController.selectedEmirate,
                    onChanged: (value) => signUpController.onEmirateSelected(value),
                  ),
                ),
                 Obx(()=> errorTextWidget(signUpController.errors['emirate'])),

                SizedBox(height: screenHeight * .020),

                Obx(()=>signUpController.locationLoading.value!= true?
                CustomDropdown(
                    label: 'Select Location',
                    icon: Icons.location_on,
                    color: CustomColors.text,
                    borderColor: CustomColors.textBoxBorderColor,
                    items: signUpController.locationsList.map((location) {
                      return DropdownMenuItem<String>(
                        value: location.locationId,
                        child: Text(location.locationName ?? ''),
                      );
                    }).toList(),
                    selectedValue: signUpController.selectedLocation,
                    onChanged: (value) {
                      signUpController.selectedLocation.value = value;
                    },
                  ):
                  Center(child: CircularProgressIndicator()),
                ),

                 Obx(()=> errorTextWidget(signUpController.errors['location'])),




                SizedBox(height: screenHeight * .020),

                daySelectionGrid(),
                 Obx(()=> errorTextWidget(signUpController.errors['days'])),

                SizedBox(height: screenHeight * .020),
                CustomButton(
                  buttonText: 'Sign Up',
                  tapFunction: ()  {
                    print(signUpController.validateFields());

                    if (signUpController.validateFields()) {
                      final selectedDays = signUpController.getSelectedDays();
                      print(selectedDays);
                      signUpController.newCustomerRegistration();
                    }
                  },
                  colorGradient: CustomColors.lightGreenGradient(),
                ),
                SizedBox(height: screenHeight * .020),
                // RichText(
                //   text: TextSpan(
                //     children: [
                //       TextSpan(
                //           text: 'Already have an account.   ',
                //           style: grayTextStyle1),
                //       TextSpan(text: 'Sign In Here', style: grayTextStyleBold1),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget daySelectionGrid() {
    final weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return Container(
      padding: const EdgeInsets.only(top:5,bottom: 5,),
      decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(22),
        border: Border.all(color:  CustomColors.textBoxBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 20,),
              Text('When do you want us to deliver?',style:  TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: CustomColors.text,
                  fontFamily: 'Poppins'),),
            ],
          ),
          // Grid of days with toggleable circles
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(7, (day) {
                return Column(
                  children: [
                    Obx(() => GestureDetector(
                      onTap: () => signUpController.toggleCircle( day),
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: signUpController.isSelected[day]
                            ? Colors.green
                            : Colors.grey[300],
                      ),
                    )),
                    const SizedBox(height: 4),
                    Text(
                      weekDays[day],
                      style: grayTextStyle1, // Update with desired style
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
 Widget   errorTextWidget(String? errorMessage) {
   return  errorMessage != null && errorMessage!.isNotEmpty
       ? Row(
         children: [
           Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
           errorMessage!,
           style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
         ],
       )
       : SizedBox.shrink();
 }
}
