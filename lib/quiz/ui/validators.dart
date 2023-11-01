class Validators{

 static String? question(String? value) {
    if (value == null || value.isEmpty) {
      return 'question is mandatory';
    }
  }
 static String? option1(String? value) {
   if (value == null || value.isEmpty) {
     return 'Option 1 is mandatory';
   }
 }
 static String? option2(String? value) {
   if (value == null || value.isEmpty) {
     return 'Option 2 is mandatory';
   }
 }
 static String? option3(String? value) {
   if (value == null || value.isEmpty) {
     return 'Option 3 is mandatory';
   }
 }
 static String? option4(String? value) {
   if (value == null || value.isEmpty) {
     return 'Option 4 is mandatory';
   }
 }

}