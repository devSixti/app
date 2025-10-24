// Archivo que contiene la lista de redes sociales

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class SocialLink {
  final IconData icon;
  final String name;
  final String url;

  const SocialLink({
    required this.icon,
    required this.name,
    required this.url,
  });
}

class XistiLinks {
  XistiLinks._();

  /// Lista inmutable de redes visibles en el panel.
  static const List<SocialLink> all = [
    // 1) Instagram
    SocialLink(
      icon: FontAwesomeIcons.instagram,
      name: 'Instagram',
      url: 'https://www.instagram.com/xistiapp/',
    ),
    // 2) TikTok
    SocialLink(
      icon: FontAwesomeIcons.tiktok,
      name: 'TikTok',
      url: 'https://www.tiktok.com/@xistiapp',
    ),
    // 3) Facebook
    SocialLink(
      icon: FontAwesomeIcons.facebookF,
      name: 'Facebook',
      url: 'https://www.facebook.com/xistiapp?locale=es_LA',
    ),
    // 4) YouTube
    SocialLink(
      icon: FontAwesomeIcons.youtube,
      name: 'YouTube',
      url: 'https://www.youtube.com/@XISTIAPP',
    ),
    // 5) X (Twitter)
    SocialLink(
      icon: FontAwesomeIcons.xTwitter,
      name: 'X (Twitter)',
      url: 'https://x.com/Xistiapp',
    ),
    // 6) LinkedIn
    SocialLink(
      icon: FontAwesomeIcons.linkedinIn,
      name: 'LinkedIn',
      url: 'https://www.linkedin.com/company/xistiapp',
    ),
    // 7) Telegram
    SocialLink(
      icon: FontAwesomeIcons.telegram,
      name: 'Telegram',
      url: 'https://t.me/xistiapp',
    ),
    // 8) Página web
    SocialLink(
      icon: FontAwesomeIcons.globe,
      name: 'Página web',
      url: 'https://www.xistiapp.com/',
    ),
  ];
}
