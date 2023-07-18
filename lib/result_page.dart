import 'package:calorie_app_danika/health_log.dart';
import 'package:calorie_app_danika/test.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({ super.key, required this.date });

  final String date;

  var food = "Apple";
  var appleQuantity = 1;
  var appleCalories = 95;
  var imageUrl = 'https://rainierfruit.com/wp-content/uploads/2021/12/Rainier-Fruit-Apple.png';
  var food2 = "Banana";
  var bananaQuantity = 1;
  var bananaCalories = 105;
  var imageUrl2 = 'https://target.scene7.com/is/image/Target/GUEST_f5d0cfc3-9d02-4ee0-a6c6-ed5dc09971d1?wid=488&hei=488&fmt=pjpeg';
  var food3 = "Strawberry";
  var strawberryQuantity = 1;
  var strawberryCalories = 5.75;
  var imageUrl3 = 'https://static.onecms.io/wp-content/uploads/sites/19/2018/02/13/strawberry-calories-hero-getty-2000.jpg';
  var food4 = "Milk";
  var milkQuantity = 1;
  var milkCalories = 77;
  var imageUrl4 = 'https://firebasestorage.googleapis.com/v0/b/inspiring-quotes-9e078.appspot.com/o/HealthLogs%2FCalorieAmounts%2Fmilk.jpg?alt=media&token=92c7ee1a-a085-4536-9425-ee4a874dcdce';
  var food5 = "Ice Cream";
  var iceCreamQuantity = 1;
  var iceCreamCalories = 137;
  var imageUrl5 = 'https://firebasestorage.googleapis.com/v0/b/inspiring-quotes-9e078.appspot.com/o/HealthLogs%2FCalorieAmounts%2Fvanilla_ice_cream.jpg?alt=media&token=98494144-c321-46c2-9138-0f82a9537aae';
  var food6 = "Pizza Crust";
  var crustQuantity = 1;
  var crustCalories = 50;
  var imageUrl6 = 'https://firebasestorage.googleapis.com/v0/b/inspiring-quotes-9e078.appspot.com/o/HealthLogs%2FCalorieAmounts%2Fpizza_crust.jpg?alt=media&token=4ac2c504-ad8d-475c-a2c9-bb821237e253';
  var food7 = "Pizza Sauce";
  var sauceQuantity = 1;
  var sauceCalories = 40;
  var imageUrl7 = 'https://firebasestorage.googleapis.com/v0/b/inspiring-quotes-9e078.appspot.com/o/HealthLogs%2FCalorieAmounts%2Fpizza_sauce.jpg?alt=media&token=758498b0-9cce-4c48-9059-c9f8861abc7c';
  var food8 = "Mozzarella";
  var mozzarellaQuantity = 1;
  var mozzarellaCalories = 26;
  var imageUrl8 = 'https://firebasestorage.googleapis.com/v0/b/inspiring-quotes-9e078.appspot.com/o/HealthLogs%2FCalorieAmounts%2Fmozzarella.jpg?alt=media&token=6038d174-b6df-4e4e-a5e2-0f4d02c94e82';
  var food9 = "Pepperoni";
  var pepperoniQuantity = 1;
  var pepperoniCalories = 10;
  var imageUrl9 = 'https://firebasestorage.googleapis.com/v0/b/inspiring-quotes-9e078.appspot.com/o/HealthLogs%2FCalorieAmounts%2Fpepperoni.jpg?alt=media&token=dbb482fc-16b9-426a-92ef-2dc56efff5f4';

  addition() {
    return appleCalories * appleQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Screen: $date'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BigCard(image: imageUrl, food: food, quantity: appleQuantity.toString(), calories: appleCalories.toString()),
              // Image.network('https://rainierfruit.com/wp-content/uploads/2021/12/Rainier-Fruit-Apple.png'),
              // Text(food),
              // Text("You ate: $appleQuantity"),
              // Text("Calories: $appleCalories"),
              BigCard(image: imageUrl2, food: food2, quantity: bananaQuantity.toString(), calories: bananaCalories.toString()),
              // Image.network('https://target.scene7.com/is/image/Target/GUEST_f5d0cfc3-9d02-4ee0-a6c6-ed5dc09971d1?wid=488&hei=488&fmt=pjpeg'),
              // Text(food2),
              // Text("You ate: $bananaQuantity"),
              // Text("Calories: $bananaCalories"),
              BigCard(image: imageUrl3, food: food3, quantity: strawberryQuantity.toString(), calories: strawberryCalories.toString()),
              // Image.network('https://static.onecms.io/wp-content/uploads/sites/19/2018/02/13/strawberry-calories-hero-getty-2000.jpg'),
              // Text(food3),
              // Text("You ate: $strawberryQuantity"),
              // Text("Calories: $strawberryCalories"),
              BigCard(image: imageUrl4, food: food4, quantity: milkQuantity.toString(), calories: milkCalories.toString()),
              // Image.network('https://firebasestorage.googleapis.com/v0/b/inspiring-quotes-9e078.appspot.com/o/HealthLogs%2FCalorieAmounts%2Fmilk.jpg?alt=media&token=92c7ee1a-a085-4536-9425-ee4a874dcdce'),
              // Text(food4),
              // Text("You ate: $milkQuantity"),
              // Text("Calories: $milkCalories"),
              BigCard(image: imageUrl5, food: food5, quantity: iceCreamQuantity.toString(), calories: iceCreamCalories.toString()),
              // Image.network('https://firebasestorage.googleapis.com/v0/b/inspiring-quotes-9e078.appspot.com/o/HealthLogs%2FCalorieAmounts%2Fvanilla_ice_cream.jpg?alt=media&token=98494144-c321-46c2-9138-0f82a9537aae'),
              // Text(food5),
              // Text("You ate: $iceCreamQuantity"),
              // Text("Calories: $iceCreamCalories"),
              BigCard(image: imageUrl6, food: food6, quantity: crustQuantity.toString(), calories: crustCalories.toString()),
              // Image.network('https://firebasestorage.googleapis.com/v0/b/inspiring-quotes-9e078.appspot.com/o/HealthLogs%2FCalorieAmounts%2Fpizza_crust.jpg?alt=media&token=4ac2c504-ad8d-475c-a2c9-bb821237e253'),
              // Text(food6),
              // Text("You ate: $crustQuantity"),
              // Text("Calories: $crustCalories"),
              BigCard(image: imageUrl7, food: food7, quantity: sauceQuantity.toString(), calories: sauceCalories.toString()),
              // Image.network('https://firebasestorage.googleapis.com/v0/b/inspiring-quotes-9e078.appspot.com/o/HealthLogs%2FCalorieAmounts%2Fpizza_sauce.jpg?alt=media&token=758498b0-9cce-4c48-9059-c9f8861abc7c'),
              // Text(food7),
              // Text("You ate: $sauceQuantity"),
              // Text("Calories: $sauceCalories"),
              BigCard(image: imageUrl8, food: food8, quantity: mozzarellaQuantity.toString(), calories: mozzarellaCalories.toString()),
              // Image.network('https://firebasestorage.googleapis.com/v0/b/inspiring-quotes-9e078.appspot.com/o/HealthLogs%2FCalorieAmounts%2Fmozzarella.jpg?alt=media&token=6038d174-b6df-4e4e-a5e2-0f4d02c94e82'),
              // Text(food8),
              // Text("You ate: $mozzarellaQuantity"),
              // Text("Calories: $mozzarellaCalories"),
              BigCard(image: imageUrl9, food: food9, quantity: pepperoniQuantity.toString(), calories: pepperoniCalories.toString()),
              // Image.network('https://firebasestorage.googleapis.com/v0/b/inspiring-quotes-9e078.appspot.com/o/HealthLogs%2FCalorieAmounts%2Fpepperoni.jpg?alt=media&token=dbb482fc-16b9-426a-92ef-2dc56efff5f4'),
              // Text(food9),
              // Text("You ate: $pepperoniQuantity"),
              // Text("Calories: $pepperoniCalories"),
            ],
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Bird(),
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add_circle),
      ),
    );
  }
}

class BigCard extends StatelessWidget {

  const BigCard({
    Key? key,
    required this.image,
    required this.food,
    required this.quantity,
    required this.calories,

  }) : super(key: key);

  final String image;
  final String food;
  final String quantity;
  final String calories;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: Colors.lightGreenAccent,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: AnimatedSize(
          duration: Duration(milliseconds: 200),
          // Make sure that the compound word wraps correctly when the window
          // is too narrow.
          child: MergeSemantics(
            child: Wrap(
              children: [
                Image.network(image),
                Text(
                  food,
                  style: style.copyWith(fontWeight: FontWeight.w200),
                ),
                Text(
                  quantity,
                  style: style.copyWith(fontWeight: FontWeight.w200),
                ),
                Text(
                  calories,
                  style: style.copyWith(fontWeight: FontWeight.w200),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

