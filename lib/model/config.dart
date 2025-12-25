import 'package:test_flutter/model/basic.dart';

// 配置信息
class ConfigData {
  String? title;
  String? image;
  String? icp;
  String? beian;
  String? siteUrl;
  String? siteTitle;
  String? siteDesc;
  String? siteKeywords;
  String? usersTitle;
  String? usersDesc;
  String? usersKeywords;
  String? tagsTitle;
  String? tagsDesc;
  String? tagsKeywords;
  String? siteCountJs;
  String? searchHotWords;
  String? imageHost;
  String? linkQq;
  String? welfareApp;
  String? linkGithub;
  String? linkTwitter;
  String? linkTelegram;
  String? linkTelegramGroup;
  String? linkEmail;
  String? footerTxt;
  String? contentAfter;
  String? notification;
  List<String>? searchHistory;

  ConfigData({
    this.title,
    this.image,
    this.icp,
    this.beian,
    this.siteUrl,
    this.siteTitle,
    this.siteDesc,
    this.siteKeywords,
    this.usersTitle,
    this.usersDesc,
    this.usersKeywords,
    this.tagsTitle,
    this.tagsDesc,
    this.tagsKeywords,
    this.siteCountJs,
    this.searchHotWords,
    this.imageHost,
    this.linkQq,
    this.welfareApp,
    this.linkGithub,
    this.linkTwitter,
    this.linkTelegram,
    this.linkTelegramGroup,
    this.linkEmail,
    this.footerTxt,
    this.contentAfter,
    this.notification,
    this.searchHistory,
  });

  ConfigData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    icp = json['icp'];
    beian = json['beian'];
    siteUrl = json['site_url'];
    siteTitle = json['site_title'];
    siteDesc = json['site_desc'];
    siteKeywords = json['site_keywords'];
    usersTitle = json['users_title'];
    usersDesc = json['users_desc'];
    usersKeywords = json['users_keywords'];
    tagsTitle = json['tags_title'];
    tagsDesc = json['tags_desc'];
    tagsKeywords = json['tags_keywords'];
    siteCountJs = json['site_count_js'];
    searchHotWords = json['search_hot_words'];
    imageHost = json['image_host'];
    linkQq = json['link_qq'];
    welfareApp = json['welfare_app'];
    linkGithub = json['link_github'];
    linkTwitter = json['link_twitter'];
    linkTelegram = json['link_telegram'];
    linkTelegramGroup = json['link_telegram_group'];
    linkEmail = json['link_email'];
    footerTxt = json['footer_txt'];
    contentAfter = json['content_after'];
    notification = json['notification'];
    searchHistory = json['search_history'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['image'] = image;
    data['icp'] = icp;
    data['beian'] = beian;
    data['site_url'] = siteUrl;
    data['site_title'] = siteTitle;
    data['site_desc'] = siteDesc;
    data['site_keywords'] = siteKeywords;
    data['users_title'] = usersTitle;
    data['users_desc'] = usersDesc;
    data['users_keywords'] = usersKeywords;
    data['tags_title'] = tagsTitle;
    data['tags_desc'] = tagsDesc;
    data['tags_keywords'] = tagsKeywords;
    data['site_count_js'] = siteCountJs;
    data['search_hot_words'] = searchHotWords;
    data['image_host'] = imageHost;
    data['link_qq'] = linkQq;
    data['welfare_app'] = welfareApp;
    data['link_github'] = linkGithub;
    data['link_twitter'] = linkTwitter;
    data['link_telegram'] = linkTelegram;
    data['link_telegram_group'] = linkTelegramGroup;
    data['link_email'] = linkEmail;
    data['footer_txt'] = footerTxt;
    data['content_after'] = contentAfter;
    data['notification'] = notification;
    data['search_history'] = searchHistory;
    return data;
  }
}

class ModelConfig extends ModelBasic<ConfigData> {
  ModelConfig({required super.code, required super.msg, required super.data});
  factory ModelConfig.fromJson(Map<dynamic, dynamic> json) {
    final int code = json['code'] ?? 500;
    final String msg = json['msg'] ?? '请求成功';
    ConfigData? configData;
    if (json['data'] != null && json['data'] is Map<String, dynamic>) {
      configData = ConfigData.fromJson(json['data'] as Map<String, dynamic>);
    }
    return ModelConfig(code: code, msg: msg, data: configData);
  }
}
