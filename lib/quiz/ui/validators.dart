class Validators{

 static String? question(String? value) {
    if (value == null || value.isEmpty) {
      return 'question is mandatory';
    }
  }
 static String? option1(String? value) {
   if (value == null || value.isEmpty) {
     return 'Option A is mandatory';
   }
 }
 static String? option2(String? value) {
   if (value == null || value.isEmpty) {
     return 'Option B is mandatory';
   }
 }
 static String? option3(String? value) {
   if (value == null || value.isEmpty) {
     return 'Option C is mandatory';
   }
 }
 static String? option4(String? value) {
   if (value == null || value.isEmpty) {
     return 'Option D is mandatory';
   }
 }

}