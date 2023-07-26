import '../widgets/hex_text.dart';

class PassageScreen extends StatefulWidget {
  const PassageScreen({super.key});

  @override
  State<PassageScreen> createState() => _PassageScreenState();
}

class _PassageScreenState extends State<PassageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBG,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBG,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: HexText(
          'Romans',
          fontSize: 16.sp,
          color: AppColors.black,
          fontWeight: FontWeight.normal,
        ),
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        children: [
          Padding(
            padding: EdgeInsets.all(16.h),
            child: HexText(
              'Chapter 1',
              fontSize: 16.sp,
              color: AppColors.black,
              align: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),
          ),
          HexText(
            '''   1. Lorem ipsum dolor sit amet consectetur. Cras mauris enim vulputate sapien vitae. Viverra nulla scelerisque consectetur sed quam massa non eget. Orci faucibus viverra tristique pellentesque feugiat lorem.

   2. Mauris odio scelerisque lacus nunc malesuada.
Nullam sapien neque in habitasse ante eget. Consequat massa consequat faucibus nulla in amet vel. Suscipit feugiat montes pellentesque cras turpis. 

   3. Pellentesque et quisque lacus justo tortor sapien. Eu platea a faucibus vivamus eu nulla metus diam.
Vel eu amet volutpat posuere tempor urna accumsan. Ultrices ac amet urna vel neque faucibus rutrum viverra ipsum. 

   4. Mi eu est varius commodo gravida iaculis nunc. Adipiscing lacus mauris facilisis facilisi eget quisque eu. Risus amet amet tortor sed leo facilisis. Eu netus eu sed risus tortor. Neque posuere a porttitor viverra.''',
            fontSize: 16.sp,
            color: AppColors.black,
          ),
        ],
      ),
    );
  }
}
