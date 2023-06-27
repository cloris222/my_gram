import 'dart:math';

import 'package:base_project/utils/number_format_util.dart';

import '../models/http/data/dynamic_info_data.dart';
import '../models/http/data/pair_image_data.dart';
import '../models/http/data/post_info_data.dart';

enum MyGramAI {
  Rebecca("rebecca",20),
  Sophie("Sophie",22),
  Emma("Emma",24),
  Emily("Emily",25),
  Ava("Ava",21),
  Chloe("Chloe",23),
  Samantha("Samantha",26),
  Lydia("Lydia",20);

  final String assetsName;
  final int age;

  const MyGramAI(this.assetsName,this.age);
}

class PitchDataUtil {
  /// 配對頁資料
  List<PairImageData> buildPairData() {
    List<PairImageData> list = [];
    for (var ai in MyGramAI.values) {
      List<String> images = List.generate(
          6,
          (index) =>
              "assets/icon/pitch/pair/${NumberFormatUtil().integerTwoFormat((ai.index * 6) + index + 1)}.${ai.name}_01_0${index + 1}.png");
      list.add(PairImageData(
          images: images, name: ai.name, context: _getPairContext(ai),age: ai.age));
    }
    return list;
  }

  /// 動態牆(all)
  List<DynamicInfoData> buildOther() {
    return List.generate(MyGramAI.values.length,
        (index) => _getDynamicOther(MyGramAI.values[index]));
  }

  /// 動態牆(個人)
  List<DynamicInfoData> buildSelf(int length) {
    return List<DynamicInfoData>.generate(
        length,
        (index) => DynamicInfoData(
              avatar: getAvatar(MyGramAI.Rebecca),
              name: MyGramAI.Rebecca.name,
              time: '2023-05-1${9 - index} 08:00',
              context: _getDynamicSelf(index),
              images: List<String>.generate(
                  3,
                  (imageIndex) =>
                      "assets/icon/pitch/dynamic/self/0${index + 1}.rebecca_0${index + 1}_0${imageIndex + 1}.png"),
              likes: (index + 1) * 1000,
              comments: (index + 2) * 1000,
            ));
  }

  List<PostInfoData> buildSelfPostData({int length = 8}) {
    return List<PostInfoData>.generate(
        length,
        (index) => PostInfoData(context: 'GGGGGG', images: [
              "assets/icon/pitch/chart/0${index + 1}.${MyGramAI.Rebecca.assetsName}_0${index + 1}_01.png"
            ]));
  }

  /// 取得個人頭像
  String getAvatar(MyGramAI ai) {
    return "assets/icon/pitch/pair/${NumberFormatUtil().integerTwoFormat((ai.index * 6) + 1)}.${ai.name}_01_01.png";
  }

  /// 取得創建頁的隨機主頁
  String getRandomCreateDemo(){
    return "assets/icon/pitch/create/0000${Random().nextInt(10)}.png";
  }

  /// 配對內容
  String _getPairContext(MyGramAI ai) {
    switch (ai) {
      case MyGramAI.Rebecca:
        return "嗨！ 👋我是Rebecca，20歲的🦀️巨蟹座女孩熱愛戶外活動 、健身和游泳 。是個愛跳舞💃的女孩來跟隨我一起探索世界，享受生活的美好吧！";
      case MyGramAI.Sophie:
        return "哈囉！👋我是Sophie，22歲的🦁️獅子座女孩。我迷戀著音樂🎵，對旅行✈️和攝影有著無窮的熱愛。讓我們一同展開一段奇妙的冒險，共享生命中美好的時光吧！";
      case MyGramAI.Emma:
        return "Hi！👋我是Emma，24歲的🌪️雙子座女孩。我醉心於閱讀📚，喜歡將靈感化為文字。咖啡☕和寫作✍️是我舒解壓力的方式。讓我們一同品味生活中的每個瞬間，探索其中的美好吧！";
      case MyGramAI.Emily:
        return "嗨！👋我是Emily，25歲的🏹射手座女孩。我熱愛冒險與自由，喜歡戶外運動⛰️和攝影📸。一起探索大自然的奧秘，攀登高峰，細細品味生活中的每個瞬間吧！";
      case MyGramAI.Ava:
        return "Hello！👋我是Ava，21歲的⚖️天秤座女孩。我深深著迷於藝術🎨，享受與美食🍽️和電影🎥共度的時光。讓我們一同探索藝術的奧秘，品味美食的饗宴，以及電影帶來的情感體驗吧！";
      case MyGramAI.Chloe:
        return "嘿！👋我是Chloe，23歲的💦水瓶座女孩。我對音樂🎶、瑜珈🧘‍♀️和寫作✏️充滿熱情。讓我們一同跳進音樂的節奏，感受身心靈的平靜，並用文字書寫出內心深處的美好吧！";
      case MyGramAI.Samantha:
        return "嗨嗨！👋我是Samantha，26歲的🌾處女座女孩。我喜歡烹飪美食🍳、欣賞電影🎬和探索各地的旅行。讓我們一同營造美味佳餚，探索電影世界帶來的情感與啟發，並一同展開一段令人難忘的旅程吧！";
      case MyGramAI.Lydia:
        return "嘿嘿！👋我是Lydia，20歲的🐠雙魚座女孩。我熱愛閱讀📖、寫詩📝和繪畫🎨，這些藝術形式帶給我無限的靈感與情感。讓我們一同創造出詩意的時刻，在文學和藝術的海洋中尋找心靈的共鳴吧！";
    }
  }

  String _getDynamicSelf(int index) {
    switch (index) {
      case 0:
        return "探索新風格，讓今日的你與眾不同🌟👗。讓衣櫃裡的舊衣活出新意，你準備好挑戰了嗎？#OOTD #StyleChallenge";
      case 1:
        return "回歸經典，感受丹寧的魅力👖💙。輕鬆自在，卻不失風範，你的丹寧故事是什麼？#DenimVibes #ClassicChic";
      case 2:
        return "在泳池邊，讓陽光為你打造魅力光環👙☀️。這個夏天，妳是最閃亮的風景。#PoolsideGlam #SummerVibes";
      case 3:
        return "黑色的魅力，簡單又神秘⚫✨。從頭到腳都是風格，你的黑色故事是什麼？#AllBlackEverything #FashionStatement";
      case 4:
        return "找到你的最佳角度，捕捉最真實的你📸⭐。無論從哪個角度看，你都是最閃亮的那一顆。#PerfectAngle #PicturePerfect";
      case 5:
        return "行李已經打包，心情已經出發🧳🌍。生活中的小確幸，就是期待的度假旅行！#HolidayModeOn #VacayVibes";
      case 6:
        return "換上最愛的衣服，就是最好的自我表達💖👗。每一件都是你的故事，每一款都是你的風格。#FavoriteOutfit #ExpressYourself";
      case 7:
      default:
        return "運動的熱情，健康的生活💪🍏。每一次的汗水都是我們向更好的自己進發的腳步。#HealthyLiving #FitnessGoals";
    }
  }

  DynamicInfoData _getDynamicOther(MyGramAI ai) {
    List<String> images = [];
    String context = "";
    String pre = "assets/icon/pitch/dynamic/other";
    switch (ai) {
      case MyGramAI.Rebecca:
        images = [
          "$pre/07.rebecca_07_01.png",
          "$pre/07.rebecca_07_02.png",
          "$pre/07.rebecca_07_03.png"
        ];
        context =
            "換上最愛的衣服，就是最好的自我表達💖👗。每一件都是你的故事，每一款都是你的風格。#FavoriteOutfit #ExpressYourself";
        break;
      case MyGramAI.Sophie:
        images = ["$pre/07.${ai.name}_01_01.png"];
        context =
            "城市的夜晚，星星點點的燈火🌃💫。每一盞燈，都是一個故事的開始。#CityLights #NighttimeWonders";
        break;
      case MyGramAI.Emma:
        images = ["$pre/13.${ai.name}_01_01.png"];
        context =
            "綁起丸子頭，露出燦爛的微笑，勇敢秀出真實的自我🎀😊💪。你的美，是無人能及的。#BunHairstyle #RadiantSmile #BeBrave";
        break;
      case MyGramAI.Emily:
        images = ["$pre/19.${ai.name}_01_01.png"];
        context = "單寧風的街拍，都市的隨性之美👖📸。踏上街頭，秀出你的獨特風格。#StreetStyle #DenimFashion";
        break;
      case MyGramAI.Ava:
        images = ["$pre/25.${ai.name}_01_01.png"];
        context = "單寧風的街拍，都市的隨性之美👖📸。踏上街頭，秀出你的獨特風格。#StreetStyle #DenimFashion";
        break;
      case MyGramAI.Chloe:
        images = ["$pre/31.${ai.name}_01_01.png"];
        context =
            "花田中的微笑，如同陽光般燦爛🌸😊。在這個美麗的世界裡，每個人都是最閃亮的一朵花。#FlowerFields #BeamingSmiles";
        break;
      case MyGramAI.Samantha:
        images = ["$pre/37.${ai.name}_01_01.png"];
        context = "黑與白，簡單而深邃⚪⚫。無論什麼風格，你都能駕馭。#MonochromeStyle #FashionStatement";
        break;
      case MyGramAI.Lydia:
        images = ["$pre/43.${ai.name}_01_01.png"];
        context =
            "在繁星點點的城市裡，我是夜的詩人🌃🚶‍♂️。每一道燈光，都是我的故事。#CityAtNight #MyUrbanTale";
        break;
    }

    return DynamicInfoData(
        avatar: getAvatar(ai),
        name: ai.name,
        time: '2023-05-1${9 - ai.index} 08:00',
        context: context,
        images: images,
        likes: (ai.index + 1) * 1000,
        comments: (ai.index + 2) * 1000);
  }
}
