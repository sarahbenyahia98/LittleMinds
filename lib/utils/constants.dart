import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//RESPONSIVE SCREENS
class ScreenSize {
  BuildContext context;

  ScreenSize(this.context) : assert(true);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}

//USED COLORS
class AppColors {
  static const white = Color(0xffEEEEEE);
  static const black = Color(0xff1e212d);
  static const backGround = Color(0xffaf8aff);
  static const secondary = Color(0xff5fffe0);
  static const crimson = Color(0xffff5f7e);
  static const yellow = Color(0xfffbe698);
  static const orange = Color(0xffff884b);
  static const Lpink = Color(0xffffcce7);
  static const sage = Color(0xffdaf2dc);
  static const pale = Color(0xffeacfff);
  static const tale = Color(0xffdaf2dc);
  static const skyblue = Color(0xFFB2BFD8);
  static const PastelGreen = Color(0xFF77DD77);
  static const pastelBlue = Color(0xFFADD8E6);
}

//FONT STYLING
class PrimaryText extends StatelessWidget {
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final double height;

  const PrimaryText({
    required this.text,
    this.fontWeight = FontWeight.w400,
    this.color = AppColors.black,
    this.size = 20,
    this.height = 1.3,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.almarai(
        height: height,
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}

//CATEGORIES

  const CardsList = [
  {
    'imagePath': 'nums.svg',
    'ar': 'الأرقام', // Arabic
    'fr': 'Les chiffres', // French
    'en': 'Numbers', // English
  },
  {
    'imagePath': 'letters.svg',
    'ar': 'الحروف', // Arabic
    'fr': 'Les lettres', // French
    'en': 'Letters', // English
  },
  {
    'imagePath': 'animals.svg',
    'ar': 'الحيوانات', // Arabic
    'fr': 'Les animaux', // French
    'en': 'Animals', // English
  },
  {
    'imagePath': 'family.svg',
    'ar': 'العائلة', // Arabic
    'fr': 'La famille', // French
    'en': 'Family', // English
  },
  {
    'imagePath': 'fruits.svg',
    'ar': 'الفواكه', // Arabic
    'fr': 'Les fruits', // French
    'en': 'Fruits', // English
  },
  {
    'imagePath': 'vegetables.svg',
    'ar': 'الخضراوات', // Arabic
    'fr': 'Les légumes', // French
    'en': 'Vegetables', // English
  },
  {
    'imagePath': 'colors.svg',
    'ar': 'الألوان', // Arabic
    'fr': 'Les couleurs', // French
    'en': 'Colors', // English
  },
  {
    'imagePath': 'months.svg',
    'ar': 'الأشهر', // Arabic
    'fr': 'Les mois', // French
    'en': 'Months', // English
  },
  {
    'imagePath': 'days.svg',
    'ar': 'الأيام', // Arabic
    'fr': 'Les jours', // French
    'en': 'Days', // English
  },
  {
    'imagePath': 'countries.svg',
    'ar': 'البلدان', // Arabic
    'fr': 'Les pays', // French
    'en': 'Countries', // English
  },
  {
    'imagePath': 'body.svg',
    'ar': 'أجزاء الجسم', // Arabic
    'fr': 'Les parties du corps', // French
    'en': 'Body Parts', // English
  },
  {
    'imagePath': 'shapes.svg',
    'ar': 'الأشكال', // Arabic
    'fr': 'Les formes', // French
    'en': 'Shapes', // English
  }
];


//ROUTES
const routesList = [
  {
    'routePath': '/Nums',
  },
  {
    'routePath': '/Letters',
  },
  {
    'routePath': '/Animals',
  },
  {
    'routePath': '/Family',
  },
  {
    'routePath': '/Fruits',
  },
  {
    'routePath': '/Vegetables',
  },
  {
    'routePath': '/Colors',
  },
  {
    'routePath': '/Months',
  },
  {
    'routePath': '/Days',
  },
  {'routePath': '/Countries'},
  {
    'routePath': '/BodyParts',
  },
  {'routePath': '/Shapes'}
];

const GamesList = [
  {
    'ar': 'وصلة', // Arabic
    'fr': 'Lien', // French
    'en': 'Link', // English
    'imagePath': 'assets/games/color.png'
  },
  {
    'ar': 'ميمو', // Arabic
    'fr': 'Mémo', // French
    'en': 'Memo', // English
    'imagePath': 'assets/games/memo.png'
  },
  {
    'ar': 'الألغاز', // Arabic
    'fr': 'Les énigmes', // French
    'en': 'Puzzles', // English
    'imagePath': 'assets/games/puzzle.png'
  }
];


const gamesRoutes = [
  {'routePath': '/Color'},
  {'routePath': '/Memory'},
  {'routePath': '/StartupPage'},
];

//weekdays list
const weekdaysList = [
  {
    'imagePath': 'assets/days/sunday.png',
    'ar': 'الأحد', // Arabic
    'fr': 'Dimanche', // French
    'en': 'Sunday', // English
  },
  {
    'imagePath': 'assets/days/monday.png',
    'ar': 'الاثنين', // Arabic
    'fr': 'Lundi', // French
    'en': 'Monday', // English
  },
  {
    'imagePath': 'assets/days/tuesday.png',
    'ar': 'الثلاثاء', // Arabic
    'fr': 'Mardi', // French
    'en': 'Tuesday', // English
  },
  {
    'imagePath': 'assets/days/wednesday.png',
    'ar': 'الأربعاء', // Arabic
    'fr': 'Mercredi', // French
    'en': 'Wednesday', // English
  },
  {
    'imagePath': 'assets/days/thursday.png',
    'ar': 'الخميس', // Arabic
    'fr': 'Jeudi', // French
    'en': 'Thursday', // English
  },
  {
    'imagePath': 'assets/days/friday.png',
    'ar': 'الجمعة', // Arabic
    'fr': 'Vendredi', // French
    'en': 'Friday', // English
  },
  {
    'imagePath': 'assets/days/saturday.png',
    'ar': 'السبت', // Arabic
    'fr': 'Samedi', // French
    'en': 'Saturday', // English
  }
];


//months list
const monthsList = [
  {
    'imagePath': 'assets/months/janvier.png',
    'ar': 'جانْفِي', // Arabic
    'fr': 'Janvier', // French
    'en': 'January', // English
  },
  {
    'imagePath': 'assets/months/fevrier.png',
    'ar': 'فِيفْرِي', // Arabic
    'fr': 'Février', // French
    'en': 'February', // English
  },
  {
    'imagePath': 'assets/months/mars.png',
    'ar': 'مارْس', // Arabic
    'fr': 'Mars', // French
    'en': 'March', // English
  },
  {
    'imagePath': 'assets/months/avril.png',
    'ar': 'أفْرِيل', // Arabic
    'fr': 'Avril', // French
    'en': 'April', // English
  },
  {
    'imagePath': 'assets/months/may.png',
    'ar': 'ماي', // Arabic
    'fr': 'Mai', // French
    'en': 'May', // English
  },
  {
    'imagePath': 'assets/months/juin.png',
    'ar': 'جْوان', // Arabic
    'fr': 'Juin', // French
    'en': 'June', // English
  },
  {
    'imagePath': 'assets/months/juillet.png',
    'ar': 'جْوِيلِْية', // Arabic
    'fr': 'Juillet', // French
    'en': 'July', // English
  },
  {
    'imagePath': 'assets/months/aout.png',
    'ar': 'أُوت', // Arabic
    'fr': 'Août', // French
    'en': 'August', // English
  },
  {
    'imagePath': 'assets/months/septembre.png',
    'ar': 'سِبْتُمْبر', // Arabic
    'fr': 'Septembre', // French
    'en': 'September', // English
  },
  {
    'imagePath': 'assets/months/octobre.png',
    'ar': 'أُكْتُوبر', // Arabic
    'fr': 'Octobre', // French
    'en': 'October', // English
  },
  {
    'imagePath': 'assets/months/novembre.png',
    'ar': 'نُوفُمْبر', // Arabic
    'fr': 'Novembre', // French
    'en': 'November', // English
  },
  {
    'imagePath': 'assets/months/december.png',
    'ar': 'دِيسُمْبر', // Arabic
    'fr': 'Décembre', // French
    'en': 'December', // English
  }
];


//colors List
const colorsList = [
  {
    'imagePath': 'assets/colors/red.png',
    'ar': 'أحمر', // Arabic
    'fr': 'Rouge', // French
    'en': 'Red', // English
  },
  {
    'imagePath': 'assets/colors/blue.png',
    'ar': 'أزرق', // Arabic
    'fr': 'Bleu', // French
    'en': 'Blue', // English
  },
  {
    'imagePath': 'assets/colors/green.png',
    'ar': 'أخضر', // Arabic
    'fr': 'Vert', // French
    'en': 'Green', // English
  },
  {
    'imagePath': 'assets/colors/yellow.png',
    'ar': 'أصفر', // Arabic
    'fr': 'Jaune', // French
    'en': 'Yellow', // English
  },
  {
    'imagePath': 'assets/colors/orange.png',
    'ar': 'برتقالي', // Arabic
    'fr': 'Orange', // French
    'en': 'Orange', // English
  },
  {
    'imagePath': 'assets/colors/purple.png',
    'ar': 'أرجواني', // Arabic
    'fr': 'Violet', // French
    'en': 'Purple', // English
  },
  {
    'imagePath': 'assets/colors/pink.png',
    'ar': 'وردي', // Arabic
    'fr': 'Rose', // French
    'en': 'Pink', // English
  },
  {
    'imagePath': 'assets/colors/brown.png',
    'ar': 'بني', // Arabic
    'fr': 'Marron', // French
    'en': 'Brown', // English
  },
  {
    'imagePath': 'assets/colors/gray.png',
    'ar': 'رمادي', // Arabic
    'fr': 'Gris', // French
    'en': 'Gray', // English
  },
  {
    'imagePath': 'assets/colors/black.png',
    'ar': 'أسود', // Arabic
    'fr': 'Noir', // French
    'en': 'Black', // English
  },
  {
    'imagePath': 'assets/colors/white.png',
    'ar': 'أبيض', // Arabic
    'fr': 'Blanc', // French
    'en': 'White', // English
  },
  {
    'imagePath': 'assets/colors/cyan.png',
    'ar': 'سماوي', // Arabic
    'fr': 'Cyan', // French
    'en': 'Cyan', // English
  },
];


//countries list
const countriesList = [
  {
    'imagePath': 'assets/countries/usa.png',
    'ar': 'الولايات المتحدة', // Arabic
    'fr': 'États-Unis', // French
    'en': 'United States', // English
  },
  {
    'imagePath': 'assets/countries/canada.png',
    'ar': 'كندا', // Arabic
    'fr': 'Canada', // French
    'en': 'Canada', // English
  },
  {
    'imagePath': 'assets/countries/france.png',
    'ar': 'فرنسا', // Arabic
    'fr': 'France', // French
    'en': 'France', // English
  },
  {
    'imagePath': 'assets/countries/germany.png',
    'ar': 'ألمانيا', // Arabic
    'fr': 'Allemagne', // French
    'en': 'Germany', // English
  },
  {
    'imagePath': 'assets/countries/japan.png',
    'ar': 'اليابان', // Arabic
    'fr': 'Japon', // French
    'en': 'Japan', // English
  },
  {
    'imagePath': 'assets/countries/china.png',
    'ar': 'الصين', // Arabic
    'fr': 'Chine', // French
    'en': 'China', // English
  },
  {
    'imagePath': 'assets/countries/india.png',
    'ar': 'الهند', // Arabic
    'fr': 'Inde', // French
    'en': 'India', // English
  },
  {
    'imagePath': 'assets/countries/brazil.png',
    'ar': 'البرازيل', // Arabic
    'fr': 'Brésil', // French
    'en': 'Brazil', // English
  },
  {
    'imagePath': 'assets/countries/australia.png',
    'ar': 'أستراليا', // Arabic
    'fr': 'Australie', // French
    'en': 'Australia', // English
  },
  {
    'imagePath': 'assets/countries/russia.png',
    'ar': 'روسيا', // Arabic
    'fr': 'Russie', // French
    'en': 'Russia', // English
  },
];

const numsList = [
  {
    'imagePath': 'assets/numbers/0.png',
    'counterPath': 'assets/counters/hands0.png',
    'ar': 'صفر', // Arabic
    'fr': 'Zéro', // French
    'en': 'Zero', // English
  },
  {
    'imagePath': 'assets/numbers/1.png',
    'counterPath': 'assets/counters/hands1.png',
    'ar': 'واحد', // Arabic
    'fr': 'Un', // French
    'en': 'One', // English
  },
  {
    'imagePath': 'assets/numbers/2.png',
    'counterPath': 'assets/counters/hands2.png',
    'ar': 'اثنان', // Arabic
    'fr': 'Deux', // French
    'en': 'Two', // English
  },
  {
    'imagePath': 'assets/numbers/3.png',
    'counterPath': 'assets/counters/hands3.png',
    'ar': 'ثلاثة', // Arabic
    'fr': 'Trois', // French
    'en': 'Three', // English
  },
  {
    'imagePath': 'assets/numbers/4.png',
    'counterPath': 'assets/counters/hands4.png',
    'ar': 'أربعة', // Arabic
    'fr': 'Quatre', // French
    'en': 'Four', // English
  },
  {
    'imagePath': 'assets/numbers/5.png',
    'counterPath': 'assets/counters/hands5.png',
    'ar': 'خمسة', // Arabic
    'fr': 'Cinq', // French
    'en': 'Five', // English
  },
  {
    'imagePath': 'assets/numbers/6.png',
    'counterPath': 'assets/counters/hands6.png',
    'ar': 'ستة', // Arabic
    'fr': 'Six', // French
    'en': 'Six', // English
  },
  {
    'imagePath': 'assets/numbers/7.png',
    'counterPath': 'assets/counters/hands7.png',
    'ar': 'سبعة', // Arabic
    'fr': 'Sept', // French
    'en': 'Seven', // English
  },
  {
    'imagePath': 'assets/numbers/8.png',
    'counterPath': 'assets/counters/hands8.png',
    'ar': 'ثمانية', // Arabic
    'fr': 'Huit', // French
    'en': 'Eight', // English
  },
  {
    'imagePath': 'assets/numbers/9.png',
    'counterPath': 'assets/counters/hands9.png',
    'ar': 'تسعة', // Arabic
    'fr': 'Neuf', // French
    'en': 'Nine', // English
  },
];

//ANIMALS LIST
const animalsList = [
  {
    'imagePath': 'assets/animals/leo.png',
    'voice': 'voices/leo.mp3',
    'ar': 'أسد', // Arabic
    'fr': 'Lion', // French
    'en': 'Lion', // English
  },
  {
    'imagePath': 'assets/animals/duck.png',
    'voice': 'voices/duck.mp3',
    'ar': 'بطة', // Arabic
    'fr': 'Canard', // French
    'en': 'Duck', // English
  },
  {
    'imagePath': 'assets/animals/chicken.png',
    'voice': 'voices/chicken.mp3',
    'ar': 'دجاجة', // Arabic
    'fr': 'Poulet', // French
    'en': 'Chicken', // English
  },
  {
    'imagePath': 'assets/animals/horse.png',
    'voice': 'voices/horse.mp3',
    'ar': 'حصان', // Arabic
    'fr': 'Cheval', // French
    'en': 'Horse', // English
  },
  {
    'imagePath': 'assets/animals/goat.png',
    'voice': 'voices/goat.mp3',
    'ar': 'ماعز', // Arabic
    'fr': 'Chèvre', // French
    'en': 'Goat', // English
  },
  {
    'imagePath': 'assets/animals/cat.png',
    'voice': 'voices/cat.mp3',
    'ar': 'قطة', // Arabic
    'fr': 'Chat', // French
    'en': 'Cat', // English
  },
  {
    'imagePath': 'assets/animals/mouse.png',
    'voice': 'voices/mouse.mp3',
    'ar': 'فأر', // Arabic
    'fr': 'Souris', // French
    'en': 'Mouse', // English
  },
  {
    'imagePath': 'assets/animals/frog.png',
    'voice': 'voices/frog.mp3',
    'ar': 'ضفدع', // Arabic
    'fr': 'Grenouille', // French
    'en': 'Frog', // English
  },
  {
    'imagePath': 'assets/animals/dog.png',
    'voice': 'voices/dog.mp3',
    'ar': 'كلب', // Arabic
    'fr': 'Chien', // French
    'en': 'Dog', // English
  },
  {
    'imagePath': 'assets/animals/cow.png',
    'voice': 'voices/cow.mp3',
    'ar': 'بقرة', // Arabic
    'fr': 'Vache', // French
    'en': 'Cow', // English
  },
];


//LETTERS LIST
const lettersList = [
  {
    'imagePath': 'assets/letters/أ.png',
    'subImage': 'assets/letters/avatars/أرنب.png',
    'name': 'أ',
  },
  {
    'imagePath': 'assets/letters/ب.png',
    'subImage': 'assets/letters/avatars/بطة.png',
    'name': 'ب',
  },
  {
    'imagePath': 'assets/letters/ت.png',
    'subImage': 'assets/letters/avatars/تفاح.png',
    'name': 'ت',
  },
  {
    'imagePath': 'assets/letters/ث.png',
    'subImage': 'assets/letters/avatars/ثلج.png',
    'name': 'ث',
  },
  {
    'imagePath': 'assets/letters/ج.png',
    'subImage': 'assets/letters/avatars/جَزَر.png',
    'name': 'ج',
  },
  {
    'imagePath': 'assets/letters/ح.png',
    'subImage': 'assets/letters/avatars/حصان.png',
    'name': 'ح',
  },
  {
    'imagePath': 'assets/letters/خ.png',
    'subImage': 'assets/letters/avatars/خيمة.png',
    'name': 'خ',
  },
  {
    'imagePath': 'assets/letters/د.png',
    'subImage': 'assets/letters/avatars/دولفين.png',
    'name': 'د',
  },
  {
    'imagePath': 'assets/letters/ذ.png',
    'subImage': 'assets/letters/avatars/ذُره.png',
    'name': 'ذ',
  },
  {
    'imagePath': 'assets/letters/ر.png',
    'subImage': 'assets/letters/avatars/ريشة.png',
    'name': 'ر',
  },
  {
    'imagePath': 'assets/letters/ز.png',
    'subImage': 'assets/letters/avatars/زرافة.png',
    'name': 'ز',
  },
  {
    'imagePath': 'assets/letters/س.png',
    'subImage': 'assets/letters/avatars/سلحفاة.png',
    'name': 'س',
  },
  {
    'imagePath': 'assets/letters/ش.png',
    'subImage': 'assets/letters/avatars/شمعة.png',
    'name': 'ش',
  },
  {
    'imagePath': 'assets/letters/ص.png',
    'subImage': 'assets/letters/avatars/صقر.png',
    'name': 'ص',
  },
  {
    'imagePath': 'assets/letters/ض.png',
    'subImage': 'assets/letters/avatars/ضفدع.png',
    'name': 'ض',
  },
  {
    'imagePath': 'assets/letters/ط.png',
    'subImage': 'assets/letters/avatars/طائرة.png',
    'name': 'ط',
  },
  {
    'imagePath': 'assets/letters/ظ.png',
    'subImage': 'assets/letters/avatars/ظرف.png',
    'name': 'ظ',
  },
  {
    'imagePath': 'assets/letters/ع.png',
    'subImage': 'assets/letters/avatars/عصفور.png',
    'name': 'ع',
  },
  {
    'imagePath': 'assets/letters/غ.png',
    'subImage': 'assets/letters/avatars/غزالة.png',
    'name': 'غ',
  },
  {
    'imagePath': 'assets/letters/ف.png',
    'subImage': 'assets/letters/avatars/فراولة.png',
    'name': 'ف',
  },
  {
    'imagePath': 'assets/letters/ق.png',
    'subImage': 'assets/letters/avatars/قلم.png',
    'name': 'ق',
  },
  {
    'imagePath': 'assets/letters/ك.png',
    'subImage': 'assets/letters/avatars/كرة.png',
    'name': 'ك',
  },
  {
    'imagePath': 'assets/letters/ل.png',
    'subImage': 'assets/letters/avatars/لمبة.png',
    'name': 'ل',
  },
  {
    'imagePath': 'assets/letters/م.png',
    'subImage': 'assets/letters/avatars/موز.png',
    'name': 'م',
  },
  {
    'imagePath': 'assets/letters/ن.png',
    'subImage': 'assets/letters/avatars/نجمة.png',
    'name': 'ن',
  },
  {
    'imagePath': 'assets/letters/ه.png',
    'subImage': 'assets/letters/avatars/هرم.png',
    'name': 'ه',
  },
  {
    'imagePath': 'assets/letters/و.png',
    'subImage': 'assets/letters/avatars/وردة.png',
    'name': 'و',
  },
  {
    'imagePath': 'assets/letters/ي.png',
    'subImage': 'assets/letters/avatars/يد.png',
    'name': 'ي',
  },
];

//FAMILY LIST
const familyList = [
  {
    'imagePath': 'assets/family/0.png',
    'ar': 'الجد', // Arabic
    'fr': 'Grand-père', // French
    'en': 'Grandfather', // English
  },
  {
    'imagePath': 'assets/family/1.png',
    'ar': 'الجدة', 
    'fr': 'Grand-mère', 
    'en': 'Grandmother',
  },
  {
    'imagePath': 'assets/family/2.png',
    'ar': 'الأب',
    'fr': 'Père',
    'en': 'Father',
  },
  {
    'imagePath': 'assets/family/3.png',
    'ar': 'الأم',
    'fr': 'Mère',
    'en': 'Mother',
  },
  {
    'imagePath': 'assets/family/4.png',
    'ar': 'العم/الخال',
    'fr': 'Oncle',
    'en': 'Uncle',
  },
  {
    'imagePath': 'assets/family/5.png',
    'ar': 'العمة/الخالة',
    'fr': 'Tante',
    'en': 'Aunt',
  },
  {
    'imagePath': 'assets/family/6.png',
    'ar': 'الابن',
    'fr': 'Fils',
    'en': 'Son',
  },
  {
    'imagePath': 'assets/family/7.png',
    'ar': 'الابنة',
    'fr': 'Fille',
    'en': 'Daughter',
  },
  {
    'imagePath': 'assets/family/8.png',
    'ar': 'ابن/ابنة العم',
    'fr': 'Cousin(e)',
    'en': 'Cousin',
  },
];

const fruitsList = [
  {
    'imagePath': 'assets/fruits/مانجو.png',
    'ar': 'مانجو',
    'fr': 'Mangue',
    'en': 'Mango',
  },
  {
    'imagePath': 'assets/fruits/بطيخ.png',
    'ar': 'بطيخ',
    'fr': 'Pastèque',
    'en': 'Watermelon',
  },
  {
    'imagePath': 'assets/fruits/كيوي.png',
    'ar': 'كيوي',
    'fr': 'Kiwi',
    'en': 'Kiwi',
  },
  {
    'imagePath': 'assets/fruits/عنب.png',
    'ar': 'عنب',
    'fr': 'Raisin',
    'en': 'Grapes',
  },
  {
    'imagePath': 'assets/fruits/أناناس.png',
    'ar': 'أناناس',
    'fr': 'Ananas',
    'en': 'Pineapple',
  },
];

const vegetablesList = [
  {
    'imagePath': 'assets/vegetables/بطاطس.png',
    'ar': 'بطاطس',
    'fr': 'Pomme de terre',
    'en': 'Potato',
  },
  {
    'imagePath': 'assets/vegetables/بازلاء.png',
    'ar': 'بازلاء',
    'fr': 'Petit pois',
    'en': 'Peas',
  },
  {
    'imagePath': 'assets/vegetables/فلفل.png',
    'ar': 'فلفل',
    'fr': 'Poivron',
    'en': 'Pepper',
  },
  {
    'imagePath': 'assets/vegetables/باذنجان.png',
    'ar': 'باذنجان',
    'fr': 'Aubergine',
    'en': 'Eggplant',
  },
  {
    'imagePath': 'assets/vegetables/خيار.png',
    'ar': 'خيار',
    'fr': 'Concombre',
    'en': 'Cucumber',
  },
];

const shapesList = [
  {
    'ar': 'الدائرة', // Arabic
    'fr': 'Cercle', // French
    'en': 'Circle', // English
    'image': 'assets/shapes/circle_image.jpg',
  },
  {
    'ar': 'المربع',
    'fr': 'Carré',
    'en': 'Square',
    'image': 'assets/shapes/square_image.jpg',
  },
  {
    'ar': 'المستطيل',
    'fr': 'Rectangle',
    'en': 'Rectangle',
    'image': 'assets/shapes/rectangle_image.jpg',
  },
  {
    'ar': 'المثلث',
    'fr': 'Triangle',
    'en': 'Triangle',
    'image': 'assets/shapes/triangle_image.jpg',
  },
  {
    'ar': 'البيضاوي',
    'fr': 'Ovale',
    'en': 'Oval',
    'image': 'assets/shapes/oval_image.jpg',
  },
  {
    'ar': 'القلب',
    'fr': 'Cœur',
    'en': 'Heart',
    'image': 'assets/shapes/heart_image.jpg',
  },
  {
    'ar': 'النجمة',
    'fr': 'Étoile',
    'en': 'Star',
    'image': 'assets/shapes/star_image.jpg',
  },
  {
    'ar': 'الهلال',
    'fr': 'Croissant',
    'en': 'Crescent',
    'image': 'assets/shapes/crescent_image.png',
  },
  {
    'ar': 'المعين',
    'fr': 'Losange',
    'en': 'Rhombus',
    'image': 'assets/shapes/rhombus_image.jpg',
  },
];

const bodyPartsList = [
  {
    'ar': 'الرأس', // Arabic
    'fr': 'Tête', // French
    'en': 'Head', // English
    'image': 'assets/body parts/head.jpg',
  },
  {
    'ar': 'العين',
    'fr': 'Œil',
    'en': 'Eye',
    'image': 'assets/body parts/eyes.jpg',
  },
  {
    'ar': 'الأذن',
    'fr': 'Oreille',
    'en': 'Ear',
    'image': 'assets/body parts/ear.jpg',
  },
  {
    'ar': 'الأنف',
    'fr': 'Nez',
    'en': 'Nose',
    'image': 'assets/body parts/nose.jpg',
  },
  {
    'ar': 'الفم',
    'fr': 'Bouche',
    'en': 'Mouth',
    'image': 'assets/body parts/mouth.jpg',
  },
  {
    'ar': 'الذراع',
    'fr': 'Bras',
    'en': 'Arm',
    'image': 'assets/body parts/arm.jpg',
  },
  {
    'ar': 'اليد',
    'fr': 'Main',
    'en': 'Hand',
    'image': 'assets/body parts/hand.jpg',
  },
  {
    'ar': 'البطن',
    'fr': 'Ventre',
    'en': 'Stomach',
    'image': 'assets/body parts/stomach.jpg',
  },
  {
    'ar': 'الساق',
    'fr': 'Jambe',
    'en': 'Leg',
    'image': 'assets/body parts/leg.jpg',
  },
  {
    'ar': 'القدم',
    'fr': 'Pied',
    'en': 'Foot',
    'image': 'assets/body parts/foot.jpg',
  },
  {
    'ar': 'الرقبة',
    'fr': 'Cou',
    'en': 'Neck',
    'image': 'assets/body parts/neck.jpg',
  },
  {
    'ar': 'الكتف',
    'fr': 'Épaule',
    'en': 'Shoulder',
    'image': 'assets/body parts/shoulder.jpg',
  },
  {
    'ar': 'الكوع',
    'fr': 'Coude',
    'en': 'Elbow',
    'image': 'assets/body parts/elbow.jpg',
  },
  {
    'ar': 'الركبة',
    'fr': 'Genou',
    'en': 'Knee',
    'image': 'assets/body parts/knee.jpg',
  },
  {
    'ar': 'الكاحل',
    'fr': 'Cheville',
    'en': 'Ankle',
    'image': 'assets/body parts/ankle.jpg',
  },
];
