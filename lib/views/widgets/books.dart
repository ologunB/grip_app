import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

foo() async {
  Map all = {};
  for (var a in List.generate(66, (i) => i + 1)) {
    Response res = await Dio().get('https://api.getbible.net/v2/kjv/$a.json');
    dynamic data = res.data;
    List<int> temp = [];
    for (var b in data['chapters']) {
      temp.add(b['verses'].length);
    }
    all.putIfAbsent(data['name'], () => temp);
    print(data['name']);
  }

  log(jsonEncode(all));
}

var trans = {
  "akjv": {
    "translation": "American King James Version",
    "abbreviation": "akjv",
    "description": "American King James Version",
    "lang": "en",
    "language": "English",
    "direction": "LTR",
    "encoding": "",
    "distribution_lcsh": "Bible. English.",
    "distribution_version": "1.4",
    "distribution_version_date": "2007-04-30",
    "distribution_abbreviation": "akjv",
    "distribution_about":
        "American King James Version\\par Produced by Stone Engelbrite\\par\\par This is a new translation of the Bible, based on the original King James Version. It is a simple word for word update from the King James English. I have taken care to change nothing doctrinely, but to simply update the spelling and vocabulary. I have not changed the grammar because that could alter it doctrinely.\\par\\par I am hereby putting the American King James version of the Bible into the public domain on November 8, 1999.\\par\\par       Michael Peter (Stone) Engelbrite\\par\\par You may use it in any manner you wish: copy it, sell it, modify it, etc.\\par You can't copyright it or prevent others from using it.\\par You can't claim that you created it, because you didn't.\\par Visit http://www.inspiredidea.com/akj.htm for more information.",
    "distribution_license": "Copyrighted; Free non-commercial distribution",
    "distribution_sourcetype": "",
    "distribution_source": "http://www.inspiredidea.com/home/akj",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.4": "Updated TextSource",
      "history_1.3": "compressed module",
      "history_1.2": "Updated to new text and fixed a couple incomplete verses."
    },
    "url": "https://api.getbible.net/v2/akjv.json",
    "sha": "2c0b022e7396795322a8a9dc02fa451fa4cbce42"
  },
  "aleppo": {
    "translation": "Aleppo Codex",
    "abbreviation": "aleppo",
    "description": "Aleppo Codex",
    "lang": "hbo",
    "language": "Hebrew",
    "direction": "RTL",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. O.T. Hebrew.",
    "distribution_version": "2.0.1",
    "distribution_version_date": "2008-11-07",
    "distribution_abbreviation": "aleppo",
    "distribution_about":
        "The Aleppo Codex without Vowel Points or Punctuation\\par Based on the electronic edition at http://www.mechon-mamre.org",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://www.mechon-mamre.org/",
    "distribution_versification": "MT",
    "distribution_history": {
      "history_1.1":
          "Converted to OSIS, removed prepended Hebrew verse numbers, removed extraneous copies of verses",
      "history_2.0": "Changed to native versification (MT)",
      "history_2.0.1": "(2022-08-06) Change Lang to Hebrew Ancient"
    },
    "url": "https://api.getbible.net/v2/aleppo.json",
    "sha": "6044d31a59450ba0507d92bfab1abf15eaf1ac2c"
  },
  "almeida": {
    "translation": "Almeida Atualizada",
    "abbreviation": "almeida",
    "description": "Bíblia Almeida Recebida (AR)",
    "lang": "pt",
    "language": "Portuguese",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. Portuguese.",
    "distribution_version": "1.3.1",
    "distribution_version_date": "2012-08-13",
    "distribution_abbreviation": "almeida",
    "distribution_about": "A Traduçao do Texto Recebido (Textus Receptus)",
    "distribution_license": "Creative Commons: BY-ND 4.0",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://www.almeidarecebida.org/",
    "distribution_versification": "KJV",
    "distribution_history": {
      "history_1.0":
          "Initial release, based on version 1.1, 2012-03-19 text (2012-07-10)",
      "history_1.2": "Updated to version 1.2, 2012-08-01 text (2012-08-02)",
      "history_1.3": "Updated to version 1.2+ε, 2012-08-03 text (2012-08-13)",
      "history_1.3.1": "(2022-08-06) Fix typo in DistributionLicense"
    },
    "url": "https://api.getbible.net/v2/almeida.json",
    "sha": "7b100492e5db9178e575f077b4145fd87afb1ca8"
  },
  "aov": {
    "translation": "Ou Vertaling",
    "abbreviation": "aov",
    "description": "1933/1953 Afrikaans Bybel",
    "lang": "af",
    "language": "Afrikaans",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. Afrikaans.",
    "distribution_version": "1.3.3",
    "distribution_version_date": "2009-03-24",
    "distribution_abbreviation": "aov",
    "distribution_about":
        "1933/1953 Afrikaans Bybel,\\par Copyright 1933, 1953, Bybelgenootskap van Suid Afrika\\par This copyright Bible has kindly been made available by the Bible Society of South Africa, strictly for non-commercial use with The SWORD Project.  Please consider making a contribution to them to help fund their continuing efforts in Bible translation, such as their current Southern Ndebele translation project.  To contribute towards the distribution of affordable Bibles in South Africa, visit: http://www.biblesociety.co.za/contributions.htm.",
    "distribution_license":
        "Copyrighted; Permission to distribute granted to CrossWire",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://www.biblesociety.co.za",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.1": "replaced missing verses",
      "history_1.2": "unlocked",
      "history_1.3": "corrected a number of encoding errors",
      "history_1.3.1": "corrected conf file",
      "history_1.3.2": "conf file correction",
      "history_1.3.3": "(2022-08-01) conf file correction"
    },
    "url": "https://api.getbible.net/v2/aov.json",
    "sha": "e395e50cd43530b54238ac897593bdd04a46e233"
  },
  "arabicsv": {
    "translation": "Smith and Van Dyke",
    "abbreviation": "arabicsv",
    "description": "Smith and van Dyck's al-Kitab al-Muqaddas (Arabic Bible)",
    "lang": "ar",
    "language": "Arabic",
    "direction": "RTL",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Arabic",
    "distribution_version": "2.3",
    "distribution_version_date": "2023-01-18",
    "distribution_abbreviation": "SVD",
    "distribution_about":
        "Al-Kitab al-Muqaddas (Arabic Bible)\\par Translated by Drs. Eli Smith & Cornelius van Alen van Dyck, 1865.\\par\\par Per kind permissions from:\\par Arabic Bible Outreach Ministry\\par P.O. 486\\par Dracut, MA 08126\\par USA\\par\\par http://www.arabicbible.com/\\par\\par This Bible module may be re-distributed in Sword format only. Conversion to other formats is not permitted without express permission of the copyright holder.",
    "distribution_license":
        "Copyrighted; Permission granted to distribute non-commercially in SWORD format",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "https://www.arabicbible.com/arabic-bible.html",
    "distribution_versification": "KJV",
    "distribution_history": {
      "history_1.1": "Tagged as a right to left module",
      "history_1.5":
          "Switched to vocalized source from http://www.arabicbible.com/",
      "history_1.6": "Fixed 2Peter text",
      "history_1.7": "Rectified distribution license",
      "history_1.8": "Corrected missing parts of many verses",
      "history_2.0": "(2020-02-08) Fix Ps 119 issue",
      "history_2.1": "(2021-01-12) Corrections in the source text",
      "history_2.2":
          "(2022-02-05) Spurious characters in the text, bug report MOD-430",
      "history_2.3":
          "(2023-01-18) Solves MOD-443: 2Cor 8:3 Is Missing Matt 17:25, 26, 27 Mar 4:2 3John 1:14 Versification issues"
    },
    "url": "https://api.getbible.net/v2/arabicsv.json",
    "sha": "3aa9d71618dfb0693e6579602a8beb6def3e2af4"
  },
  "asv": {
    "translation": "American Standard Version",
    "abbreviation": "asv",
    "description": "American Standard Version (1901)",
    "lang": "en",
    "language": "English",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible .English",
    "distribution_version": "2.0",
    "distribution_version_date": "2021-02-18",
    "distribution_abbreviation": "ASV",
    "distribution_about":
        "The American Standard Version (ASV) of the Holy Bible is in the Public Domain. Please feel free to copy it, give it away, memorize it, publish it, sell it, or whatever God leads you to do with it.\\par\\par The American Standard Version of 1901 is an Americanization of the English Revised Bible, which is an update of the KJV to less archaic spelling and greater accuracy of translation. It has been called \"The Rock of Biblical Honesty.\" It is the product of the work of over 50 Evangelical Christian scholars.\\par\\par While the ASV retains many archaic word forms, it is still more understandable to the modern reader than the KJV in many passages. The ASV also forms the basis for several modern English translations, including the World English Bible (http://www.eBible.org/bible/WEB), which is also in the Public Domain. The ASV uses \"Jehovah\" for Godߴs proper name. While the current consensus is that this Holy Name was more likely pronounced \"Yahweh,\" it is refreshing to see this rendition instead of the overloading of the word \"Lord\" that the KJV, NASB, and many others do.\\par\\par Pronouns referring to God are not capitalized in the ASV, as they are not in the NIV and some others, breaking the tradition of the KJV. Since Hebrew has no such thing as tense, and the oldest Greek manuscripts are all upper case, anyway, this tradition was based only on English usage around 1600, anyway. Not capitalizing these pronouns solves some translational problems, such as the coronation psalms, which refer equally well to an earthly king and to God.",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://www.ebible.org/bible/asv/",
    "distribution_versification": "KJV",
    "distribution_history": {
      "history_1.1": "Repaired footnotes from sourcetext",
      "history_1.2": "Fixed extraneous spacing and markup",
      "history_1.3": "Compressed the module",
      "history_2.0": "(2021-02-18) New text source, solves MOD-183"
    },
    "url": "https://api.getbible.net/v2/asv.json",
    "sha": "c647bcf268a540b7fd64a65ae4282a9f23869010"
  },
  "basicenglish": {
    "translation": "Basic English Bible",
    "abbreviation": "basicenglish",
    "description": "1949/1964 Bible in Basic English",
    "lang": "en",
    "language": "English",
    "direction": "LTR",
    "encoding": "",
    "distribution_lcsh": "Bible. English.",
    "distribution_version": "1.3",
    "distribution_version_date": "2008-04-21",
    "distribution_abbreviation": "basicenglish",
    "distribution_about":
        "1949/1964 Bible in Basic English\\par Public Domain -- Copy Freely\\par\\par The Bible In Basic English was printed in 1965 by Cambridge Press in England.  Published without any copyright notice and distributed in America, this work fell immediatly and irretrievably into the Public Domain in the United States according to the UCC convention of that time.  A call to Cambridge prior to placing this work in etext resulted in an admission of this fact.\\par\\par For more information about the text, see the file BBE.DOC which contains the printed introduction page.\\par\\par The most current and correct copies of these files can be obtained from the following.  If any errors are located, please ensure you have the latest files, and if so, we would appreciate being informed of the error.\\par\\par \tThe Bible Foundation\\par \thttp://www.bf.org\\par\\par Or by contacting:\\par \tMark Fuller\\par \t1129 East Loyola Drive\\par \tTempe, Arizona, 85282\\par \t602-829-8542 (voice)",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "Unbound Bible",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.3": "switched to Unbound Bible source and OSIS encoding",
      "history_1.2": "compressed module",
      "history_1.1": "minor correction to Rev 12:1"
    },
    "url": "https://api.getbible.net/v2/basicenglish.json",
    "sha": "a403c9b708b44dfba83ea9a432a314264e64513d"
  },
  "basque": {
    "translation": "(Navarro Labourdin) NT",
    "abbreviation": "basque",
    "description": "1571 Navarro-Labourdin Basque NT",
    "lang": "eu",
    "language": "Basque",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. N.T. Basque.",
    "distribution_version": "1.5",
    "distribution_version_date": "2008-07-19",
    "distribution_abbreviation": "basque",
    "distribution_about":
        "1571 Navarro-Labourdin Basque NT\\par Translated, and published on August 22, 1571, by Pierre Hautin.",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://www.vc.ehu.es/gordailua/testamentu.htm",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.5": "Switched to upstream text source",
      "history_1.1": "Updated text source",
      "history_1.0": "First version"
    },
    "url": "https://api.getbible.net/v2/basque.json",
    "sha": "4d67722c85f64f66368fc27d7254fd4d31a9450a"
  },
  "bibelselskap": {
    "translation": "Det Norsk Bibelselskap (1930)",
    "abbreviation": "bibelselskap",
    "description": "Bibelen på Norsk (1930)",
    "lang": "nb",
    "language": "Norwegian bokmal",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Norwegian Bokmal",
    "distribution_version": "2.0",
    "distribution_version_date": "2020-02-08",
    "distribution_abbreviation": "Bibelen på Norsk",
    "distribution_about":
        "Denne er det Norsk Bibelselskapets 1930 utgave av Bibelen på Norsk (Bokmål)\\par This is the Norwegian Bible Society’s 1930 edition of the Bible in Bokmål Norwegian\\par Text scanned and proofed by H. Priebe and co-workers. Based on the version prepared by Tore Vamraak.",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://unbound.biola.edu/",
    "distribution_versification": "KJV",
    "distribution_history": {
      "history_1.0": "initial release",
      "history_1.1": "Compressed the module",
      "history_1.5": "Updated to new source, OSIS encoding",
      "history_2.0": "(2020-02-08) New module, added notes and crossreferences"
    },
    "url": "https://api.getbible.net/v2/bibelselskap.json",
    "sha": "aefc6507fc93ccdd56f850f4169cb5a97702654d"
  },
  "bkr": {
    "translation": "Czech BKR",
    "abbreviation": "bkr",
    "description": "Czech Bible Kralicka",
    "lang": "cs",
    "language": "Czech",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Czech",
    "distribution_version": "1.5",
    "distribution_version_date": "2023-01-18",
    "distribution_abbreviation": "bkr",
    "distribution_about":
        "Czech Bible Kralicka: Bible svata aneb vsecka svata pisma\\par Stareho i Noveho Zakona podle posledniho vydani kralickeho z roku 1613.",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "https://cs.wikisource.org/wiki/Bible_kralická/",
    "distribution_versification": "KJV",
    "distribution_history": {
      "history_1.1": "[2003-03-21]UTF-8 encoded and compressed",
      "history_1.2": "[2015-10-06] version downloaded from WikiSource.",
      "history_1.3": "[2015-12-10] Fix headlines of Psalms",
      "history_1.4":
          "[2016-11-18] Refresh from upstream source, particularly fix J 19:18",
      "history_1.5":
          "(2023-01-18) Mainly fixing missing text in John-10:38 (MOD-449)"
    },
    "url": "https://api.getbible.net/v2/bkr.json",
    "sha": "5ba992b98186ae032ec8bb860dc67f73def6298c"
  },
  "breton": {
    "translation": "Gospels",
    "abbreviation": "breton",
    "description": "Breton New Testament (Koad 21)",
    "lang": "br",
    "language": "Breton",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. Breton.",
    "distribution_version": "1.1.1",
    "distribution_version_date": "2012-03-29",
    "distribution_abbreviation": "Koad 21",
    "distribution_about":
        "Breton New Testament.\\par\\par TESTAMANT NEVEZ HON AOTROÙ HAG HOR SALVER JEZUZ-KRIST lakaet e brezhoneg da gentañ en naontekvet kantved gant Gwilh Ar C'hoad, hag embannet gant Unvaniezh Dreinderian ar Bibl evit ar Vretoned e 1893, adwelet, lakaet e brezhoneg a-vremañ gant Lukaz Bernikod, hag embannet gant Unvaniezh ar Bibl en Anjev e 2004, adweladenn gwellaet e 2011, anvet TROIDIGEZH KOAD 21.\\par\\par NOUVEAU TESTAMENT DE NOTRE SEIGNEUR ET SAUVEUR JÉSUS-CHRIST EN LANGUE BRETONNE traduit d'abord au 19ème siècle par Guillaume Le Coat et édité par la Société Biblique Trinitaire pour la Bretagne en 1893 révisé, mis en langue bretonne moderne par Luc Bernicot, et édité par la Société Biblique d'Anjou en 2004, révision améliorée en 2011, nommé VERSION KOAD 21.\\par\\par NEW TESTAMENT OF OUR LORD AND SAVIOUR JESUS CHRIST IN BRETON LANGUAGE first translated during the 19th century by Guillaume Le Coat and published by the Brittany Trinitarian Bible Society in 1893 revised, transposed into modern Breton language by Luc Bernicot, and published by the Anjou Bible Society in 2004, revision improved 2011, called KOAD 21 VERSION.\\par\\par Text copyright © 2004, 2007, 2011 Anjou Bible Society.\\par http://sites.google.com/site/bibleenanjou/",
    "distribution_license":
        "Copyrighted; Permission to distribute granted to CrossWire",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://pagesperso-orange.fr/testamant.nevez/",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.1.1": "[2015-2-16] corrected conf file",
      "history_1.1":
          "[2012-03-29] Rebuilt module from source text (2011 edition)",
      "history_1.0":
          "[2012-02-29] Initial build  from source text (2010 edition)"
    },
    "url": "https://api.getbible.net/v2/breton.json",
    "sha": "648ad897438b779641b8b81695f1fc879c70a59b"
  },
  "cep": {
    "translation": "Czech CEP",
    "abbreviation": "cep",
    "description": "Czech Ekumenicky Cesky preklad",
    "lang": "cs",
    "language": "Czech",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Czech",
    "distribution_version": "1.8",
    "distribution_version_date": "2020-01-23",
    "distribution_abbreviation": "CEP",
    "distribution_about":
        "Czech Ekumenicky Cesky preklad: Bible Pismo svate Stareho i Noveho Zakona podle ekumenickeho vydani z r. 2001 (c) Ekumenicka\\par rada cirkvi v CR.",
    "distribution_license":
        "Copyrighted; Permission to distribute granted to CrossWire",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "",
    "distribution_versification": "German",
    "distribution_history": {
      "history_1.1": "enciphered module",
      "history_1.2": "deciphered module",
      "history_1.3": "corrected verse numberings to match KJV",
      "history_1.4": "UTF-8 encoded and compressed",
      "history_1.5":
          "(2017.02.18) Tiny (but embarassing) grammar error in Isa 41:7 fixed. Source code reconstructed.",
      "history_1.5.1": "correction to conf file",
      "history_1.5.2": "correction to conf file",
      "history_1.6": "Another typo in Jer.23.29",
      "history_1.6.1": "(2017-02-28) Fix xml:lang attribute in OSIS file",
      "history_1.8":
          "(2020-01-23) Fix multiple typos in the text (mostly suggested by Libor Štefek)."
    },
    "url": "https://api.getbible.net/v2/cep.json",
    "sha": "258aab7b8ec993ba3aeec817de5d846b96810539"
  },
  "chamorro": {
    "translation": "(Psalms Gospels Acts)",
    "abbreviation": "chamorro",
    "description": "Chamorro: Y Santa Biblia (1908)",
    "lang": "ch",
    "language": "Chamorro",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. Chamorro.",
    "distribution_version": "2.7.2",
    "distribution_version_date": "2013-08-20",
    "distribution_abbreviation": "chamorro",
    "distribution_about":
        "Chamorro: Y Santa Biblia: Y Cuatro Ebangelio Sija Yan Y Checho Y Apostoles Sija Gui Testamento Nuebo Y Señotta Yan Y Satbadotta Si Jesucristo Yan Y Salmo Sija (1908)\\par The Chamorro language is the native and an official language of the US Territory of Guam and the Commonwealth of the Northern Mariana Islands (in political union with the United States of America).\\par\\par Formally titled  Chamorro and English Scriptures: Y Cuatro Ebangelio Sija Yan Y Checho Y Apostoles Sija Gui Testamento Nuebo Y Señotta Yan Y Satbadotta Si Jesucristo Yan Y Salmo Sija, the 1908 Chamorro Bible is composed of six books in diglot format (Chamorro on the left page and English on the right page): San Mateo, San Marcos, San Lucas, San Juan, Y Checho Y Apostoles Sija, and Y Salmo Sija (Saint Matthew, Saint Mark, Saint Luke, Saint John, The Acts of the Apostles, and The Psalms).  In 1908, about 1000 copies were printed by the American Bible Society.  Outside of libraries, very few are known to exist (as of this writing, one).\\par\\par San Mateo, San Marcos, San Lucas, San Juan, Y Checho Y Apostoles Sija, and Y Salmo Sija were translated in the early 1900's by Francis Marion Price, missionary of the American Board of Commissioners for Foreign Missions (ABCFM), assisted by five currently unidentified Chamorros in Guam.  According to Chamorro Scriptures for the Island of Guam (Bible Society Record, July 1908, Volume 53, Number 7, American Bible Society, New York, New York, USA), the \"translations were made from the Westcott-Hort Greek Testament\".  Francis Marion Price and his wife Sarah Jane Price (maiden name, Freeborn) were Guam's first Protestant missionaries.  Prior to their Guam assignment they worked in China and Truk (Chuuk), Caroline Islands.\\par\\par The 1908 Chamorro Bible is an important part of Chamorro history. Its background, surprising discovery, and reemergence are documented at http://ChamorroBible.org, the official home for the 2001-2002 Chamorro Bible Project. On January 28th, 2004, the Chamorro Bible was officially and publicly honored by I Mina'Bente Siete Na Liheslaturan Guåhan - The 27th Guam Legislature (http://ChamorroBible.org/chamorrobibleproject/the-27th-guam-legislature) with the presentation of three full legislative session (LS) resolutions: Resolution No. 87(LS), Resolution No. 88(LS), and Resolution No. 89(LS).  They also acknowledge the translation team and others more recently involved with the 1908 Chamorro Bible. You can read the text of each resolution at http://ChamorroBible.org. The Internet site http://RleneLive.com is another important source of Chamorro Bible research documented in articles, photographs, and audio.\\par\\par As part of the CrossWire Bible Society's (http://CrossWire.org) SWORD distribution, the Chamorro Bible is again making history: It is the first time these Scriptures are part of a Bible study software package.  The layout of each chapter or Psalm is similar to the PDF, RTF, and HTML formats, including, retaining the paragraph marks (¶) and the \"Red Letter\" markup (the words of Jesus Christ, Jesuscristo in Chamorro, are colored red).  ChamorroBible.org holds the latest and official electronic texts, as well as the historic audio recordings of the 1908 Chamorro Bible.\\par\\par Jesuscristo says, \"Aligao y tinigue sija sa y jinasonmiyo iya güiya nae inguaja y linâlâ na taejinecog; ya sija todo ufanmannae testimonio nu guajo\", \"Todo y ninasiña manaeyo, gui langet yan y tano.  Fanjanao, ya fannaquilisyano todo y nasion sija, tagpange sija pot y naan y Tata, yan y Lajiña, yan y Espiritu Santo: Fanagüe sija, na ujaadaje todosija ni jutago jamyo; sa estagüe jugagaegueja guiya jamyo todo y jaane, asta y jinecog y tano. Amen.\"  Juan 5:39; Mateo 28:18-20.\\par\\par Editor, ChamorroBible.org\\par Thursday, February 19, 2004 ChST (Chamorro Standard Time)",
    "distribution_license": "Copyrighted; Freely distributable",
    "distribution_sourcetype": "GBF",
    "distribution_source": "http://ChamorroBible.org",
    "distribution_versification": "",
    "distribution_history": {
      "history_2.7.2": "Encoding entry corrected",
      "history_2.7.1": "normalized History dates (2013-08-20)",
      "history_2.7": "Compressed the module (2006-10-25)",
      "history_2.6":
          "In Salmo 41:5 capitalize the first \"y\" (\"y enemigujo jasangan\" is now \"Y enemigujo jasangan\"). (2006-04-17)",
      "history_2.5":
          "In Salmo 150:1 replace \"alaba gue\" with \"alaba güe\". (2005-11-16)",
      "history_2.4":
          "In San Lucas 13:17 remove red Letter markup on \"Mayute ya ti manasiña machule gui tase pot y minegae y güijan.\" (2005-08-03)",
      "history_2.3":
          "For San Juan 7:39, \"sa si Jesus ti rumesibe y minalagña,\" comma (,) replaced with a period (.). (2005-07-25)",
      "history_2.2":
          "Red Letter markup removed for San Lucas 13:17. (2005-07-13)",
      "history_2.1":
          "For Y Checho Y Apostoles Sija 26:29, \"Ya si Pablo ilegña,\" comma (,) replaced with a period (.). (2005-06-05)",
      "history_2.0":
          "For San Juan 12:34, \"Na y Lajin taotao nesesita umajatsa?\" removed red-letter markup. (2005-04-05)",
      "history_1.9":
          "For San Mateo 4:4, red-letter \"Matugue esta:\". (2005-02-15)",
      "history_1.8":
          "For San Marcos 1:17, red-letter these two words \"Maela dalalagyo\". (2005-02-10)",
      "history_1.7":
          "For San Juan 10:11, typo in the first word - removed the accent mark in the word Guajo. (2004-06-25)",
      "history_1.6":
          "For San Mateo 17:11, capitalization and punctuation correction; added Red Letter markup. (2004-03-11)",
      "history_1.5": "Typo fixed in the \"About\" entry below. (2004-02-28)",
      "history_1.4":
          "Red Letter markup corrected/updated for New Testament books, \"San Mateo\", \"San Marcos\", \"San Lucas\", \"San Juan\", and \"Y Checho Y Apostoles Sija\". (2004-02-23)",
      "history_1.0":
          "The 1908 Chamorro Bible introduced as a module for CrossWire Bible Society's \"The SWORD Project\".  This is an important date in the 1908 Chamorro Bible's history. (2004-02-19)"
    },
    "url": "https://api.getbible.net/v2/chamorro.json",
    "sha": "6b51caa125b55c46a84b73bac625201ff9f2ce1b"
  },
  "cns": {
    "translation": "NCV Simplified",
    "abbreviation": "cns",
    "description": "新译本",
    "lang": "zh-Hans",
    "language": "Chinese",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Chinese (Subform \"hans\")",
    "distribution_version": "1.1.1",
    "distribution_version_date": "2020-12-20",
    "distribution_abbreviation": "NCVs",
    "distribution_about":
        "新译本 Chinese New Version (simplified) copyright © 1976, 1992, 1999, 2001, 2005, 2010 The Worldwide Bible Society Limited Language: 中文 (Chinese) Dialect: Mandarin, simplified script Translation by: The Worldwide Bible Society Ltd. 2014-02-07",
    "distribution_license":
        "Copyrighted; Permission to distribute granted to CrossWire",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "https://www.worldbiblesociety.org",
    "distribution_versification": "NRSV",
    "distribution_history": {
      "history_1.0": "First release",
      "history_1.1": "(2020-12-28) New release. Fix MOD-?",
      "history_1.1.1": "(2022-08-02) Fix typos in configuration file"
    },
    "url": "https://api.getbible.net/v2/cns.json",
    "sha": "daa5e614f7dc3ec24076c797d3fdbb6f548e596e"
  },
  "cnt": {
    "translation": "NCV Traditional",
    "abbreviation": "cnt",
    "description": "新譯本",
    "lang": "zh-Hant",
    "language": "Chinese",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Chinese (Subform \"hant\")",
    "distribution_version": "1.1.1",
    "distribution_version_date": "2020-12-21",
    "distribution_abbreviation": "NCVt",
    "distribution_about":
        "新譯本 Chinese New Version (traditional) copyright © 1976, 1992, 1999, 2001, 2005, 2010 The Worldwide Bible Society Limited Language: 中國語文 (Chinese) Dialect: Mandarin, traditional script Translation by: The Worldwide Bible Society 2020-08-07 \\\nLanguage: 繁体中文 (Chinese, Traditional)",
    "distribution_license":
        "Copyrighted; Permission to distribute granted to CrossWire",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "https://www.worldbiblesociety.org",
    "distribution_versification": "KJV",
    "distribution_history": {
      "history_1.0": "First Release",
      "history_1.1": "(2020-12-28) New Source",
      "history_1.1.1": "(2022-08-02) Fix typos in configuration file"
    },
    "url": "https://api.getbible.net/v2/cnt.json",
    "sha": "46a734bf685e1ad3a0b0091641582a25ac37d91b"
  },
  "codex": {
    "translation": "OT Westminster Leningrad Codex",
    "abbreviation": "codex",
    "description": "Westminster Leningrad Codex",
    "lang": "hbo",
    "language": "Hebrew",
    "direction": "RTL",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Ancient Hebrew",
    "distribution_version": "2.0",
    "distribution_version_date": "2022-09-17",
    "distribution_abbreviation": "codex",
    "distribution_about":
        "This text began as an electronic transcription by Whitaker and Parunak of the 1983 printed edition of Biblia Hebraica Stuttgartensia (BHS). The transcription is called the Michigan-Claremont electronic text and was archived at the Oxford Text Archive (OTA) in 1987. Since that time, the text has been modified to conform to the photo-facsimile of the Leningrad Codex, Firkovich B19A, residing at the Russian National Library, St. Petersberg; hence the change of name. This version contains all 6 of the textual elements of the OTA document: consonants, vowels, cantillation marks, \"paragraph\" (pe, samekh) markers, and ketiv-qere variants. Morphological divisions have been added.\\par\\par The BHS so-called \"paragraph\" markers (pe and samekh) do not actually occur in the Leningrad Codex. The editors of BHS use them to indicate open space deliberately left blank by the scribe. Pe (\"open\" paragraph) represents a space between verses, where the new verse begins on a new column line. This represents a major section of the text. Samekh (\"closed\" paragraph) represents a space of less than a line between verses. This is understood to be a subdivision of the corresponding \"open\" section. Since these markers represent an actual physical feature of the text, they have been retained.\\par\\par The WLC is maintained by the Westminster Hebrew Institute, Philadelphia, PA (http://whi.wts.edu/WHI). This edition is based on Christopher V. Kimball's edition (http://www.tanach.us/Tanach.xml), which also adds textual source assignment based in the Pentateuch on the documentary hypothesis.",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source":
        "http://whi.wts.edu/WHI, http://www.tanach.us/Tanach.xml",
    "distribution_versification": "Leningrad",
    "distribution_history": {
      "history_1.0": "First public version.",
      "history_1.1":
          "Update to newer version (wlc43-20050319) of the WLC from WHI; Bugfixes in the conversion program that caused textual errors (thanks to Chris Kimball); Fixed one footnote text template.",
      "history_1.2":
          "Bugfix for textual errors. Re-added setumot and paraschot, even though their presence in L is not verified, according to Kirk Lowery. Fixed transcription note values. Included morphological segmentation in preliminary markup. Added xml:lang=\"en\" to notes. Update to newer version (wlc-4.4).",
      "history_1.3": "Fixed the conf",
      "history_1.4":
          "Corrected internal markup to conform to OSIS 2.1.1 schema, changed About markup to RTF (2008-07-02)",
      "history_1.5":
          "Updated to WLC 4.10 with additions from www.tanach.us, using native versification",
      "history_1.6":
          "Updated source attribution, undid NFC normalization, placed DH identification notes inline, fixed spacing problem (2009-05-26)",
      "history_1.7":
          "Updated to WLC 4.14, corrected some spurious markup (2012-04-14)",
      "history_1.8": "Added pe & samekh 'paragraph' marks to text (2012-04-17)",
      "history_1.9": "Updated to WLC 4.18 (2013-10-11)",
      "history_1.9.1": "(2022-08-20) Change Lang to Hebrew Ancient",
      "history_2.0":
          "(2022-09-17) Updated to WLC 20220916. Solves MOD-287, MOD-288: maqaf punctuation is no more followed by a space, MOD-303: Spurious notes entries removed."
    },
    "url": "https://api.getbible.net/v2/codex.json",
    "sha": "b4182ca700593decfb84e32efb91ecd9d45b897c"
  },
  "coptic": {
    "translation": "New Testament",
    "abbreviation": "coptic",
    "description": "The Coptic New Testament",
    "lang": "cop",
    "language": "Coptic",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. N.T. Coptic (Sahidic).",
    "distribution_version": "1.0.1",
    "distribution_version_date": "2009-11-01",
    "distribution_abbreviation": "coptic",
    "distribution_about":
        "This edition comes from the Unbound Bible, who state: The text for the Coptic New Testament was imported from resources found at this internet forum: kami.to.md which points to copticlang.bizhat.com and www.coptic-bible.co.nr and cites the source as \"Deir Anba Bishoi\".\\par See also www.coptic.org.",
    "distribution_license": "",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "Unbound Bible",
    "distribution_versification": "NRSV",
    "distribution_history": {
      "history_1.0.1": "corrected conf file",
      "history_1.0": "Initial release"
    },
    "url": "https://api.getbible.net/v2/coptic.json",
    "sha": "70de8781f1203d2603afd8314daf50f9b72c79cd"
  },
  "cornilescu": {
    "translation": "Cornilescu",
    "abbreviation": "cornilescu",
    "description": "Cornilescu Bible in Romanian language",
    "lang": "ro",
    "language": "Romanian",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Romanian",
    "distribution_version": "2.1",
    "distribution_version_date": "",
    "distribution_abbreviation": "cornilescu",
    "distribution_about":
        "Dumitru Cornilescu (4 April 1891 - 1975), a Romanian orthodox archdeacon, later a Protestant minister created this translation in 1921. It is popular particularly among protestants. Copyright of the Cornilescu Bible © 1924 belongs to British and Foreign Bible Society. Copyright © 2010, 2014 of the revised edition in Romanian language belongs to the Interconfessional Bible Society of Romania, with the approval of the British and Foreign Bible Society. Used by permission. To find out more about the ‘Cornilescu text’ translation visit www.biblesociety.org.uk/shop and the work of Bible Society visit “www.biblesociety.org.uk\"",
    "distribution_license":
        "Copyrighted. Distribution permitted to CrossWire Bible Society",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.0": "Initial release",
      "history_2.0":
          "Release of BFBS text - USFM text, revised spelling, footnotes, crossreferences, titles etc.",
      "history_2.1": "Correction of multiple conversion errors",
      "history_2.2":
          "Correction of xref and conversion errors (updated toolset)"
    },
    "url": "https://api.getbible.net/v2/cornilescu.json",
    "sha": "8043a2bd800355900abdd6f3dd79a327f86aeff5"
  },
  "croatia": {
    "translation": "Croatian",
    "abbreviation": "croatia",
    "description": "Croatian Bible",
    "lang": "hr",
    "language": "Croatian",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. Croatian.",
    "distribution_version": "1.0",
    "distribution_version_date": "2003-05-07",
    "distribution_abbreviation": "croatia",
    "distribution_about": "Croatian Bible",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "ThML",
    "distribution_source": "http://unbound.biola.edu/",
    "distribution_versification": "",
    "distribution_history": {},
    "url": "https://api.getbible.net/v2/croatia.json",
    "sha": "1e7a9b83deddb8d1321df5c5be835f0bbc1a2a81"
  },
  "cus": {
    "translation": "Union Simplified",
    "abbreviation": "cus",
    "description": "和合本 (简体字)",
    "lang": "zh-Hans",
    "language": "Chinese",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible .Chinese",
    "distribution_version": "3.0",
    "distribution_version_date": "2021-01-31",
    "distribution_abbreviation": "cus",
    "distribution_about": "和合本(简体字)是中国新教徒最早将圣经翻译成中文的版本，最早于1919年出版。",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://bible.fhl.net",
    "distribution_versification": "NRSV",
    "distribution_history": {
      "history_2.0":
          "corrections, compressed, C. Steve Tang & Beling Chang (2003-11-23)",
      "history_2.1": "converted into OSIS, Joachim Ansorg (2004-03-01)",
      "history_2.5": "updated to version of 2010-10-12 (2011-01-22)",
      "history_2.6": "moved to av11n (2011-01-22)",
      "history_3.0":
          "(2021-01-31) New source http://bible.fhl.net version: 2020-12-24 Solved issues: MOD-266"
    },
    "url": "https://api.getbible.net/v2/cus.json",
    "sha": "bf03615515270493c89fa66db18652ffc4d8db11"
  },
  "cut": {
    "translation": "Union Traditional",
    "abbreviation": "cut",
    "description": "和合本 (繁體字)",
    "lang": "zh-Hant",
    "language": "Chinese",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible .Chinese",
    "distribution_version": "3.0",
    "distribution_version_date": "2021-01-28",
    "distribution_abbreviation": "cut",
    "distribution_about": "和合本（繁體字）是中國新教徒最早將聖經翻譯成中文的版本，最早於1919年出版。",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://bible.fhl.net",
    "distribution_versification": "NRSV",
    "distribution_history": {
      "history_2.0":
          "corrections, compressed, C. Steve Tang & Beling Chang (2003-11-23)",
      "history_2.1": "converted into OSIS, Joachim Ansorg (2004-03-01)",
      "history_2.5": "updated to version of 2010-10-12 (2011-01-22)",
      "history_2.6": "moved to av11n (2011-01-22)",
      "history_3.0":
          "(2021-01-28) Rebuild from scratch from http://bible.fhl.net. Solve issues: MOD-266 MOD-365 MOD-366"
    },
    "url": "https://api.getbible.net/v2/cut.json",
    "sha": "2280c8a7ee55358756d33002828e755663eb0a8c"
  },
  "danish": {
    "translation": "Danish",
    "abbreviation": "danish",
    "description": "Danish OT1931 + NT1907 with original orthography",
    "lang": "da",
    "language": "Danish",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Danish",
    "distribution_version": "1.0.2",
    "distribution_version_date": "2017-05-22",
    "distribution_abbreviation": "danish",
    "distribution_about":
        "Danish translation of the Old Testament authorized in 1931 by the Danish King, with the New Testment being the authorized Danish version from 1907.\\parThe NT is based on an entirely new OCR-scanning of an edition with Latin typographic (not Fraktur).  The NT has subsequently been thoroughly proof-read and hand-corrected, and footnotes \\par as well as tables of contents for each chapter have been added.\\par The OT is based on an OCR-scan from the late 1980s, scanned from a typographically deficient \\par edition from 1933.  OCR-scanning done and proof-read by a Danish pioneering couple with a heart \\parfor media-missions.  It was placed on the Internet by Søren Horn in the early 1990s, from \\parwhere it was picked up by Projekt Runeberg at Linköping University. Ulrik Sandborg-Petersen picked \\par up the text in the mid-2000's, and has since then hand-corrected literally thousands of OCR-mistakes\\par and paragraphing issues.\\par Both the OT and the NT retain the original orthography.\\par\\par Errors and corrections should be sent to Ulrik Sandborg-Petersen via:\\parhttps://github.com/emg/",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "https://github.com/emg/",
    "distribution_versification": "NRSV",
    "distribution_history": {
      "history_1.0": "(2017-05-20) Initial Release",
      "history_1.0.1":
          "(2017-5-21) added obsoletion notice to conf file for older module with same text from different source",
      "history_1.0.2": "(2022-08-09) Conf file corrections",
      "history_1..01": "(2017-05-22) Conf file corrections"
    },
    "url": "https://api.getbible.net/v2/danish.json",
    "sha": "59aaba628473984dc487cbd45751a1de004cf61c"
  },
  "darby": {
    "translation": "Darby",
    "abbreviation": "darby",
    "description": "Bible J.N. Darby in French (2022)",
    "lang": "fr",
    "language": "French",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.French",
    "distribution_version": "2.0",
    "distribution_version_date": "2022-12-22",
    "distribution_abbreviation": "darby",
    "distribution_about":
        "French translation by John Nelson Darby (JND).\\par\\\nText 2022. First edition of the complete Bible in 1885, reissued in 1916.\\par\\\nVersification BHS (Biblia Hebraica Stuttgartensia) for the Old Testament.\\par\\\nPublic Domain.\\par\\\nYou can buy a printed version at:\\par\\par\\\nediteurbpc.com – Bibles et Publications Chrétiennes\\par\\\n30 rue Châteauvert – CS 40335\\par\\\n26003 VALENCE CEDEX FRANCE",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "https://editeurbpc.com/telechargements",
    "distribution_versification": "German",
    "distribution_history": {
      "history_1.0": "Initial version (2006.11.11)",
      "history_1.1": "With notes (2006.11.17)",
      "history_1.2": "Many corrections (2006.11.21)",
      "history_1.3": "Add notes (2007.04.27)",
      "history_1.4": "Add paragraph (2007.05.12)",
      "history_1.5": "Add clusters marks (2007.07.08)",
      "history_1.6": "New upstream version (2007.07.19)",
      "history_1.7": "New notes with bible references (2007.08.29)",
      "history_1.8": "Compressed Sword module (2007.09.19)",
      "history_1.9": "Corrected poetic imbrication (2007.12.29)",
      "history_1.10": "Mark references in notes (2007.12.29)",
      "history_1.11": "Various corrections for notes (2007.12.31)",
      "history_1.12": "Correct note references when in same book (2008.01.10)",
      "history_1.13":
          "Text is in public domain. Build notes in the alphabetical order (2008.01.16)",
      "history_1.14": "Correct notes generation and few typos (2008.03.30)",
      "history_1.15": "Update configuration file (2008.05.08)",
      "history_1.16": "Fixed encoding of .conf (2008.06.13)",
      "history_1.17":
          "New upstream reference (Bibliquest) and various corrections (2012.01.27)",
      "history_1.18":
          "New upstream reference (Bibliquest) and update from YD (2013.08.19)",
      "history_1.19":
          "Updated configuration file (2014.12.27) NRSV versification chosen as least misfilings of verses",
      "history_1.20": "Re-made with newest toolset",
      "history_1.22":
          "(2017-05-16) New markup for WoC, note and  paragraph corrections (2017-05-16)",
      "history_1.23":
          "(2019-05-11) Various corrections, improved notes and new, more appropriate versification",
      "history_1.24":
          "(2019-10-23) Better formatting of Psalms, and other minor fixes",
      "history_2.0":
          "(2022-12-22) New source (from BPC editor JND v1.2) with new versification (German)"
    },
    "url": "https://api.getbible.net/v2/darby.json",
    "sha": "4a2ad9b27d8d97d447ef7b47ba2e6496e252d7c4"
  },
  "douayrheims": {
    "translation": "Douay Rheims",
    "abbreviation": "douayrheims",
    "description": "Douay-Rheims Bible, Challoner Revision",
    "lang": "en",
    "language": "English",
    "direction": "LTR",
    "encoding": "",
    "distribution_lcsh": "Bible. English.",
    "distribution_version": "2.0",
    "distribution_version_date": "2009-10-24",
    "distribution_abbreviation": "douayrheims",
    "distribution_about":
        "THE HOLY BIBLE\\par TRANSLATED FROM THE LATIN VULGATE\\par DILIGENTLY COMPARED WITH THE HEBREW, GREEK, AND OTHER EDITIONS IN DIVERS LANGUAGES\\par THE OLD TESTAMENT\\par FIRST PUBLISHED BY THE ENGLISH COLLEGE AT DOUAY, A.D. 1609\\par AND\\par THE NEW TESTAMENT\\par FIRST PUBLISHED BY THE ENGLISH COLLEGE AT RHEIMS, A.D. 1582\\par WITH ANNOTATIONS, REFERENCES, AND AN HISTORICAL AND CHRONOLOGICAL INDEX\\par\\par THE WHOLE REVISED AND DILIGENTLY COMPARED WITH THE LATIN VULGATE BY BISHOP RICHARD CHALLONER, A.D.\\par 1749-1752\\par PUBLISHED WITH THE APPROBATION OF\\par HIS EMINENCE JAMES CARDINAL GIBBONS\\par ARCHBISHOP OF BALTIMORE",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "",
    "distribution_source": "http://www.sacredbible.org/",
    "distribution_versification": "Vulg",
    "distribution_history": {
      "history_2.0": "added Deuterocanonicals, used improved text source",
      "history_1.1": "compressed module"
    },
    "url": "https://api.getbible.net/v2/douayrheims.json",
    "sha": "414fe481d8c973bdb227f56de383874371676dd1"
  },
  "easternarmenian": {
    "translation": "Eastern (Genesis Exodus Gospels)",
    "abbreviation": "easternarmenian",
    "description": "Eastern Armenian Bible",
    "lang": "hy",
    "language": "Armenian",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. Armenian.",
    "distribution_version": "1.1",
    "distribution_version_date": "2008-07-14",
    "distribution_abbreviation": "easternarmenian",
    "distribution_about":
        "Eastern Armenian Bible\\par Includes Genesis, Exodus, and the Gospels",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "Slavic Bible via http://unbound.biola.edu",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.1": "Updated About and Description text"
    },
    "url": "https://api.getbible.net/v2/easternarmenian.json",
    "sha": "5c21431b0b9e8a32835ed1ec070ebba1793bd12e"
  },
  "elberfelder": {
    "translation": "Elberfelder (1871)",
    "abbreviation": "elberfelder",
    "description": "German Elberfelder (1871) (sogenannt)",
    "lang": "de",
    "language": "German",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.German",
    "distribution_version": "1.2",
    "distribution_version_date": "2020-02-06",
    "distribution_abbreviation": "Elberfelder Bibeln",
    "distribution_about": "Elberfelder Übersetzung von 1871 (sogenannt).",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "",
    "distribution_versification": "KJV",
    "distribution_history": {
      "history_1.0":
          "First version of the GerElb1871 module. Most things are working (footnotes and most of the ThML crossreferences)",
      "history_1.1":
          "(2003-06-19) Fixed unbalanced tags, encoded as UTF-8, compressed module, marked more cross-refs into scripRefs",
      "history_1.1.1":
          "(2013-07-30) Identified this as the so-called 1871 Elberfelder since we don’t actually know the date",
      "history_1.1.2": "(2013-08-20) Corrected .conf encoding",
      "history_1.2":
          "(2020-02-06) Fix https://tracker.crosswire.org/browse/MOD-299, crossref, notes..."
    },
    "url": "https://api.getbible.net/v2/elberfelder.json",
    "sha": "8fc1c3b8d53cfea13b17becb0cca333d493f2a21"
  },
  "elberfelder1905": {
    "translation": "Elberfelder (1905)",
    "abbreviation": "elberfelder1905",
    "description": "German Darby Unrevidierte Elberfelder (1905)",
    "lang": "de",
    "language": "German",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible .German",
    "distribution_version": "1.6",
    "distribution_version_date": "2021-02-08",
    "distribution_abbreviation": "elberfelder1905",
    "distribution_about":
        "German Darby Unrevidierte Elberfelder 1905,\\par Copyright by R. Bockhaus Verlag, Germany",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "Unbound Bible",
    "distribution_versification": "NRSV",
    "distribution_history": {
      "history_1.1": "enciphered module",
      "history_1.2": "set proper SourceType",
      "history_1.3":
          "deciphered module as it has passed into the public domain",
      "history_1.4":
          "fixed mixed up text parts, converted to OSIS, compressed module",
      "history_1.5":
          "corrected bad markup, text from new source (Unbound Bible)",
      "history_1.6": "(2021-02-08) Versification change"
    },
    "url": "https://api.getbible.net/v2/elberfelder1905.json",
    "sha": "a339b41e71755bacefa8c117ad489c010bc28c91"
  },
  "esperanto": {
    "translation": "Esperanto",
    "abbreviation": "esperanto",
    "description": "Esperanto Londona Biblio",
    "lang": "eo",
    "language": "Esperanto",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Esperanto",
    "distribution_version": "2.1",
    "distribution_version_date": "2020-05-21",
    "distribution_abbreviation": "esperanto",
    "distribution_about":
        "1926 Londona Biblio in Esperanto. Old Testament by Ludvic Lazarus Zamenhof (1910). Full text published in 1926 by the British & Foreign Bible Society.",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source":
        "https://archive.org/details/TheHolyBibleInEsperanto https://www.sacred-texts.com/bib/wb/esp/index.htm",
    "distribution_versification": "KJV",
    "distribution_history": {
      "history_1.0": "Initial release",
      "history_1.1": "Compressed the module",
      "history_1.5":
          "Updated to new source with paragraphing, titles, and corrected Esperanto orthography.",
      "history_1.6": "Corrected encoding, missing text in previous release",
      "history_2.0": "(2020-02-08) New TextSource, fix MOD-232 MOD-238",
      "history_2.1": "(2020-05-21) Fix Encoding Issue"
    },
    "url": "https://api.getbible.net/v2/esperanto.json",
    "sha": "e2d47b1d02292632365ac3d8acedb126c389ff77"
  },
  "estonian": {
    "translation": "Estonian",
    "abbreviation": "estonian",
    "description": "Estonian Bible",
    "lang": "et",
    "language": "Estonian",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. Estonian.",
    "distribution_version": "1.1",
    "distribution_version_date": "2008-02-01",
    "distribution_abbreviation": "estonian",
    "distribution_about":
        "Estonian Bible\\par from http://etekstid.home.dk3.com/\\par Copyright status unknown.",
    "distribution_license": "",
    "distribution_sourcetype": "",
    "distribution_source": "http://etekstid.home.dk3.com/",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.1": "corrected UTF-8 encoding, fixed errors (repeating verses)"
    },
    "url": "https://api.getbible.net/v2/estonian.json",
    "sha": "ef0e9a76a4b3072ee4ad00e76b9165178d68dace"
  },
  "finnish1776": {
    "translation": "Finnish Bible (1776)",
    "abbreviation": "finnish1776",
    "description": "Finnish Biblia (1776)",
    "lang": "fi",
    "language": "Finnish",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Finnish",
    "distribution_version": "2.1",
    "distribution_version_date": "2020-08-01",
    "distribution_abbreviation": "Pyhä Raamattu 1776",
    "distribution_about":
        "Biblia, Se on: Koko Pyhä Raamattu, Suomeksi.\\par Vuoden 1776 kirkkoraamattu.\\par\\par Finnish Bible published in 1776.\\par\\par In public domain.\\par\\par SWORD version by Tero Favorin (tero at favorin dot com)",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "https://www.finbible.fi/head/bibl.htm",
    "distribution_versification": "NRSVA",
    "distribution_history": {
      "history_1.1": "(2003-02-20) Compressed module",
      "history_1.1.1": "Encoding of conf file corrected",
      "history_2.0":
          "(2020-05-21) New module with Deuterocanonicals. Fix MOD-353",
      "history_2.1": "(2020-08-01) Minor correction in DC"
    },
    "url": "https://api.getbible.net/v2/finnish1776.json",
    "sha": "022a3ce364fc90f7aa202b2e852aa1fbebc12325"
  },
  "gaelic": {
    "translation": "Scots Gaelic (Gospel of Mark)",
    "abbreviation": "gaelic",
    "description": "Scottish Gaelic Gospel of Mark",
    "lang": "gd",
    "language": "Scottish Gaelic",
    "direction": "LTR",
    "encoding": "",
    "distribution_lcsh": "Bible. Scottish Gaelic.",
    "distribution_version": "1.2",
    "distribution_version_date": "2009-12-21",
    "distribution_abbreviation": "gaelic",
    "distribution_about":
        "Gaelic Gospel of Mark (Scottish Gaelic)\\par The Gospel of Mark in Gaelic is largely based on the Gospel of Mark in Ewen MacEachan's New Testament. The New Testament was produced in 1875 from a manuscript left by Father MacEachan. Archaic language has been replaced by modern words and idioms. We found the Gospel of Mark in Gaelic at: http://dialspace.dial.pipex.com/town/avenue/pa44/mkg1.htm",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source":
        "http://dialspace.dial.pipex.com/town/avenue/pa44/mkg1.htm",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.2":
          "corrected language name/code, changed to upstream source with chapter titles",
      "history_1.1": "compressed module"
    },
    "url": "https://api.getbible.net/v2/gaelic.json",
    "sha": "d8ff4c92ffc6c2bd38aea3c35a0f54897b178ec2"
  },
  "giovanni": {
    "translation": "Giovanni Diodati Bible (1649)",
    "abbreviation": "giovanni",
    "description": "Italian Giovanni Diodati Bibbia 1649",
    "lang": "it",
    "language": "Italian",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Italian",
    "distribution_version": "1.1",
    "distribution_version_date": "2020-02-08",
    "distribution_abbreviation": "Giovanni Diodati",
    "distribution_about": "1649 Italian Giovanni Diodati Bibbia",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://unbound.biola.edu/",
    "distribution_versification": "KJV",
    "distribution_history": {
      "history_1.0": "(2002-01-15) Initial release",
      "history_1.1":
          "(2020-02-08) Fix issue https://tracker.crosswire.org/browse/MOD-299"
    },
    "url": "https://api.getbible.net/v2/giovanni.json",
    "sha": "cee35588f101b688cec9d51b32a1b4ed99df2823"
  },
  "gothic": {
    "translation": "Gothic (Nehemiah NT Portions)",
    "abbreviation": "gothic",
    "description": "Bishop Wulfila Gothic Bible",
    "lang": "got",
    "language": "Gothic",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. Gothic.",
    "distribution_version": "1.0.1",
    "distribution_version_date": "2013-08-20",
    "distribution_abbreviation": "gothic",
    "distribution_about":
        "Bishop Wulfila Gothic Bible\\par Courtesy Project Wulfila, University of Antwerp (Belgium) http://wulfila.be\\par It goes without saying that Wilhelm Streitberg's 1919 edition should be credited as well:\\par Die gotische Bibel: Herausgegeben von Wilhelm Streitberg. (Germanische Bibliothek, 2. Abteilung, 3. Band)\\par 1. Teil: Der gotische Text und seine griechische Vorlage. Mit Einleitung, Lesarten und Quellennachweisen sowie den kleineren Denkmälern als Anhang. Heidelberg: Carl Winter, 1919.\\par 2. Teil: Gotisch-griechisch-deutsches Wörterbuch. Heidelberg: Carl Winter, 1910.",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source":
        "Project Wulfila, University of Antwerp (Belgium) http://wulfila.be",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.0.1": "Corrected .conf encoding (2013-08-20)",
      "history_1.0": "Initial release (2002-01-01)"
    },
    "url": "https://api.getbible.net/v2/gothic.json",
    "sha": "e7e6ed1d95f40b1f8f112226398bae275fefec97"
  },
  "judson": {
    "translation": "Judson (1835)",
    "abbreviation": "judson",
    "description": "1835 Judson Burmese Bible",
    "lang": "my",
    "language": "Myanmar Burmse",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. Burmese.",
    "distribution_version": "1.3",
    "distribution_version_date": "2012-02-15",
    "distribution_abbreviation": "Judson",
    "distribution_about":
        "\\qc 1835 Judson Burmese Bible\\par Myanmar Bible Society http://www.myanmarbible.com/\\par\\par Translated by the American Baptist missionary Adoniram Judson, see http://en.wikipedia.org/wiki/Adoniram_Judson\\par By default, this module requires the Padauk font, available from http://scripts.sil.org/Padauk",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://www.myanmarbible.com/",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.3": "Rebuilt module from merged XML file. (2012-02-15)",
      "history_1.2":
          "Rebuilt module from individual XML files obtained from Myanmar Bibles dated 2010-01-27.",
      "history_1.1":
          "Changed default font to Padauk (http://scripts.sil.org/Padauk) (2008-03-01)",
      "history_1.0": "Initial release"
    },
    "url": "https://api.getbible.net/v2/judson.json",
    "sha": "0e5e0b3cc044e3b7a5c54c039a877c82e7a1f182"
  },
  "karoli": {
    "translation": "Hungarian Karoli",
    "abbreviation": "karoli",
    "description": "Revideált Károli Biblia 1908",
    "lang": "hu",
    "language": "Hungarian",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Hungarian",
    "distribution_version": "2.0",
    "distribution_version_date": "2020-10-23",
    "distribution_abbreviation": "karoli",
    "distribution_about":
        "Revised version of the original translation by Károli Gáspár, first published in 1590 in Vizsoly, Hungary.",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "https://github.com/krisek/HunKar",
    "distribution_versification": "Calvin",
    "distribution_history": {
      "history_1.1": "Repaired dropped characters at beginning of some verses",
      "history_1.2": "Changed to UTF-8 text from Unbound Bible",
      "history_1.5":
          "Removed stray marks, corrected orthography, removed erroneous intro material",
      "history_1.6": "Updated About text to UTF-8, corrected LCSH",
      "history_1.7": "(2009-11-12) Corrected a misspelled word in Isa.49.6",
      "history_2.0":
          "(2020-10-23) Module rebuilt based on new source with cross-references (from http://szentiras.hu/KG) and section titles (from http://abibliamindenkie.hu/karoli). Description corrected."
    },
    "url": "https://api.getbible.net/v2/karoli.json",
    "sha": "380a33d83198abfc7cb333fbc89d7c951045274f"
  },
  "kjv": {
    "translation": "King James Version",
    "abbreviation": "kjv",
    "description":
        "King James Version (1769) with Strongs Numbers and Morphology  and CatchWords",
    "lang": "en",
    "language": "English",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.English",
    "distribution_version": "3.1",
    "distribution_version_date": "2023-07-19",
    "distribution_abbreviation": "kjv",
    "distribution_about":
        "This is the King James Version of the Holy Bible (also known as the Authorized Version) with embedded Strong's Numbers.  The rights to the base text are held by the Crown of England.\\par  The Strong's numbers in the OT were obtained from The Bible Foundation: http://www.bf.org.  The NT Strong's data was obtained from The KJV2003 Project at CrossWire: http://www.crosswire.org.  These mechanisms provide a useful means for looking up the exact original language word in a lexicon that is keyed to Strong's numbers.\\par\\par Special thanks to the volunteers at Bible Foundation for keying the Hebrew/English data and of Project KJV2003 for working toward the completion of synchronizing the English phrases to the Stephanas Textus Receptus, and to Dr. Maurice Robinson for providing the base Greek text with Strong's and Morphology.\\par  We are also appreciative of formatting markup that was provided by Michael Paul Johnson at http://www.ebible.org.  Their time and generosity to contribute such for the free use of the Body of Christ is a great blessing and this derivitive work could not have been possible without these efforts of so many individuals.\\par  Version 3.1 incorporates a more recent set of TR data from Dr. Maurice Robinson than was used in all the earlier versions. The TR data was obtained in 2016 from the Greek New Testament sources website \\par https://sites.google.com/a/wmail.fi/greeknt/home/greeknt \\par This was integrated into the OSIS source files of an intermediate version 2.9a hosted at \\par https://www.crosswire.org/~dmsmith/kjv2011/kjv2.9a/ \\par  It is in this spirit that we in turn offer the KJV2003 Project text freely for any purpose.\\par  Any copyright that might be obtained for this effort is held by CrossWire Bible Society © 2003-2023 and CrossWire Bible Society hereby grants a general public license to use this text for any purpose.\\par Inquiries and comments may be directed to:\\par\\par CrossWire Bible Society\\par modules@crosswire.org\\par http://www.crosswire.org",
    "distribution_license": "GPL",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "https://gitlab.com/crosswire-bible-society/kjv",
    "distribution_versification": "KJV",
    "distribution_history": {
      "history_1.1": "Fixed .conf file GlobalOptionFilters",
      "history_1.2": "Added Feature StrongsNumbers to configuration",
      "history_1.3": "Added Morph option",
      "history_1.4": "Fixed Psalm Titles to use correct GBF tags HT and Ht",
      "history_2.0":
          "Changed New Testament to use a snapshot of the KJV2003 Project",
      "history_2.1":
          "Changed Old Testament to use OSIS tags, removing the last of the GBF markup.  Also updated to 20030624 snapshot of KJV2003.  Compressed.",
      "history_2.2": "Updated to 20040121 snapshot of KJV2003.",
      "history_2.3": "Fixed bugs.",
      "history_2.4": "Fixed bugs.",
      "history_2.5": "Fixed bugs.",
      "history_2.6": "Fixed bugs. Added Greek from TR.",
      "history_2.6.1": "Added GlobalOptionFilter for OSISLemma",
      "history_2.7":
          "Fixed bugs preventing the display of some Strong's Numbers.",
      "history_2.8":
          "(2015-12-20) Moved Ps 119 acrostic titles before verse number. Added Feature for no paragraphs.",
      "history_2.9":
          "(2016-01-21) Added markup to notes. Improved markup of Selah.",
      "history_2.10.2":
          "(2021-04-04) Fixed errant article Strong's markup in Rom.3.26",
      "history_2.11":
          "(2023-06-27) Updated the TR data in 5888 verses. Correction of Ps.2.4: the Lord → the <divineName>Lord</divineName>.\\ MOD-448: many errors with strong as G3688, should be G3588.\\ Five locations where small caps is inappropriate, <divineName>Lord</divineName> change for <divineName>LORD</divineName> Exodus 28:36; 39:30, Deuteronomy 28:58, Jeremiah 23:6, Zechariah 14:20.\\ MOD-411: Psalm 80, Shoshannim–eduth → Shoshannim–Eduth.\\ MOD-408: italics in Nahum 1:3, (<w lemma=strong:H01870>hath) → (<transChange type=added>hath</transChange>).\\ MOD-358: Missing red letter markup in Luke 11:2, red marker moved before 'When'.\\ MOD-413 multiple text issues (italics, spelling, ...).\\ MOD-441: Missing strong number for the seventh word.\\ MOD-419: Spurious \"or\" removed; Exodus 17:15 \"Jehovah–nissi\" → \"JEHOVAH–nissi\".\\ 1 John 2:23 has \"(but)\" whereas Blayney has \"[but]\"; Correction of some morph errors in I Corinthians 3:13 A-GMS → A-GSM; I Corinthians 11:6 and 14:24 N-NAM → N-NSM; Hb 9.13, 10.4: N-GMP → N-GPM; I Cor 7:37 2 change for 12; 1Chr.27.12 Abi-ezer → abiezer; Exod.17.15: Jehovah → JEHOVAH.\\ Correction of Jer.23.6: L → LORD; MOD-376: Mk 1:10.19 have a wrong strong number: 1492. The correct number is 3708. Correction of rdg attribute type=\"alternative\" (2.9) to \"alternate\".  Misplaced </w> in Numbers 16:13. Duplicated entry in Eph. 3.20, spurious comma in Gn 1.2 and 2.9. Ezra 5:3,6; 6.6,13: morph=\"strongMorph:TH8674 changed for lemma=\"strong:H08674.",
      "history_3.1":
          "(2023-07-19) Conf version updated to 3.1 to match KJVA version."
    },
    "url": "https://api.getbible.net/v2/kjv.json",
    "sha": "91287fccb61d23727204d11d72d2543241ff4862"
  },
  "kjva": {
    "translation":
        "King James Version (1769) with Strongs Numbers and Morphology and CatchWords, including Apocrypha (without glosses)",
    "abbreviation": "kjva",
    "description":
        "King James Version (1769) with Strongs Numbers and Morphology and CatchWords, including Apocrypha (without glosses)",
    "lang": "en",
    "language": "English",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.English",
    "distribution_version": "3.1",
    "distribution_version_date": "2023-07-19",
    "distribution_abbreviation": "kjva",
    "distribution_about":
        "This is the King James Version of the Holy Bible (also known as the Authorized Version) with embedded Strong's Numbers.  The rights to the base text are held by the Crown of England.\\par  The Strong's numbers in the OT were obtained from The Bible Foundation: http://www.bf.org.  The NT Strong's data was obtained from The KJV2003 Project at CrossWire: http://www.crosswire.org.  These mechanisms provide a useful means for looking up the exact original language word in a lexicon that is keyed to Strong's numbers.\\par\\par Special thanks to the volunteers at Bible Foundation for keying the Hebrew/English data and of Project KJV2003 for working toward the completion of synchronizing the English phrases to the Stephanas Textus Receptus, and to Dr. Maurice Robinson for providing the base Greek text with Strong's and Morphology.\\par  We are also appreciative of formatting markup that was provided by Michael Paul Johnson at http://www.ebible.org.  Their time and generosity to contribute such for the free use of the Body of Christ is a great blessing and this derivitive work could not have been possible without these efforts of so many individuals.\\par  Version 3.1 incorporates a more recent set of TR data from Dr. Maurice Robinson than was used in all the earlier versions. The TR data was obtained in 2016 from the Greek New Testament sources website \\par https://sites.google.com/a/wmail.fi/greeknt/home/greeknt \\par This was integrated into the OSIS source files of an intermediate version 2.9a hosted at \\par https://www.crosswire.org/~dmsmith/kjv2011/kjv2.9a/ \\par  It is in this spirit that we in turn offer the KJV2003 Project text freely for any purpose.\\par  Any copyright that might be obtained for this effort is held by CrossWire Bible Society © 2003-2023 and CrossWire Bible Society hereby grants a general public license to use this text for any purpose.\\par Inquiries and comments may be directed to:\\par\\par CrossWire Bible Society\\par modules@crosswire.org\\par http://www.crosswire.org",
    "distribution_license": "GPL",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "https://gitlab.com/crosswire-bible-society/kjv",
    "distribution_versification": "KJVA",
    "distribution_history": {
      "history_1.1": "Fixed .conf file GlobalOptionFilters",
      "history_1.2": "Added Feature StrongsNumbers to configuration",
      "history_1.3": "Added Morph option",
      "history_1.4": "Fixed Psalm Titles to use correct GBF tags <HT><Ht>",
      "history_2.0":
          "Changed New Testament to use a snapshot of the KJV2003 Project",
      "history_2.1":
          "Changed Old Testament to use OSIS tags, removing the last of the GBF markup.  Also updated to 20030624 snapshot of KJV2003.  Compressed.",
      "history_2.2": "Updated to 20040121 snapshot of KJV2003",
      "history_2.3": "Fixed bugs",
      "history_3.0": "Added Apocrypha (2009-10-03)",
      "history_3.0.1":
          "Moved to main repository & changed Description (2014-01-15)",
      "history_3.1": "(2023-07-19) See KJV 3.1 history"
    },
    "url": "https://api.getbible.net/v2/kjva.json",
    "sha": "615f7414236a3695ec20e95c3244e08a9c018725"
  },
  "korean": {
    "translation": "Korean",
    "abbreviation": "korean",
    "description": "개역성경",
    "lang": "ko",
    "language": "Korean",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. Korean.",
    "distribution_version": "2.0.1",
    "distribution_version_date": "2019-01-07",
    "distribution_abbreviation": "korean",
    "distribution_about": "Korean Revised Version 1952/1961 from Wikisource",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "Wikisource",
    "distribution_versification": "NRSV",
    "distribution_history": {
      "history_2.0.1": "(2019-01-07) small fix in conf file",
      "history_2.0": "Switched to Wikisource source text (2013-10-14)",
      "history_1.5":
          "Updated to OSIS markup, linked merged verses, renamed to KorRV (2012-06-23)",
      "history_1.1":
          "Changed to UTF-8 source, replaced some missing verses, and compressed"
    },
    "url": "https://api.getbible.net/v2/korean.json",
    "sha": "ab33d24c8ba9180d727b83eb0570aa60b174af84"
  },
  "latvian": {
    "translation": "New Testament",
    "abbreviation": "latvian",
    "description": "Latvian New Testament",
    "lang": "lv",
    "language": "Latvian",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. Latvian.",
    "distribution_version": "1.4",
    "distribution_version_date": "2011-10-26",
    "distribution_abbreviation": "latvian",
    "distribution_about":
        "Latvian New Testament\\par The electronic edition comes from Sergej A. Fedosov's Slavic Bible for Windows",
    "distribution_license": "",
    "distribution_sourcetype": "OSIS",
    "distribution_source":
        "Slavic Bible (http://come.to/sbible) via Unbound Bible",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.4":
          "corrected reference tags (but did not parse the references)",
      "history_1.3": "minor spacing cleanup and tagging of references",
      "history_1.2": "fixed encoding, moved to OSIS source",
      "history_1.1": "compressed module"
    },
    "url": "https://api.getbible.net/v2/latvian.json",
    "sha": "5f3eac2232eaef6f724da14fe551c3f3490e9a06"
  },
  "lithuanian": {
    "translation": "Lithuanian",
    "abbreviation": "lithuanian",
    "description": "Lithuanian Bible",
    "lang": "lt",
    "language": "Lithuanian",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "bible.Lithuanian",
    "distribution_version": "1.7.2",
    "distribution_version_date": "2017-08-17",
    "distribution_abbreviation": "lithuanian",
    "distribution_about":
        "Lithuanian Bible\\par This translation is copyrighted by the Church \"Tikejimo Zodis\"\\par All Rights Reserved.",
    "distribution_license":
        "Copyrighted; Permission to distribute granted to CrossWire",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "",
    "distribution_versification": "NRSV",
    "distribution_history": {
      "history_1.0": "First public version prepared by Linas Spraunius.",
      "history_1.1": "Corrected mistake in Romans 12:1.",
      "history_1.2": "Corrected .conf",
      "history_1.5": "Converted to OSIS, corrected versification",
      "history_1.5.1": "Corrected typo in .conf",
      "history_1.6": "Solved problem with dashes and quotation marks",
      "history_1.7": "Fixed minor mistakes in the text",
      "history_1.7.1":
          "(2017-08-17) conf update and transition to rules compliant module name",
      "history_1.7.2": "(2017-08-23) minor conf update"
    },
    "url": "https://api.getbible.net/v2/lithuanian.json",
    "sha": "c860263534129c724fb27dd4a347b4a5fcfedbbb"
  },
  "ls1910": {
    "translation": "Louis Segond (1910)",
    "abbreviation": "ls1910",
    "description": "Bible Louis Segond (1910)",
    "lang": "fr",
    "language": "French",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.French",
    "distribution_version": "3.1.1",
    "distribution_version_date": "2018-11-14",
    "distribution_abbreviation": "Segond1910",
    "distribution_about":
        "En 1874, suite à une commande de la Compagnie des Pasteurs de Genève, parait la traduction de l’Ancien Testament par Louis Segond, pasteur et théologien (1810-1885). \\par\\parUne traduction précise dans un français toujours très correct, une grande clarté dans l’expression expliquent le succès de son travail. Louis Segond traduit ensuite le Nouveau Testament et la Bible complète parait en 1880.  \\par\\parRévisée plusieurs fois depuis, elle est devenue la Bible la plus largement répandue dans les milieux protestants de langue française. \\par\\parSource: http://richardlemay.com, avec lʼautorisation de Richard Lemay.",
    "distribution_license":
        "Copyrighted; Permission to distribute granted to CrossWire",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://www.richardlemay.com",
    "distribution_versification": "Segond",
    "distribution_history": {
      "history_1.1": "Added Strongs",
      "history_1.2": "Added Morph option",
      "history_1.3": "Compressed the module",
      "history_1.5":
          "Updated to new TextSource, converted to Unicode & OSIS, renamed",
      "history_1.6": "Expanded About text",
      "history_2.0":
          "added Deuterocanonicals, switched to VulSearch version (2009-10-24)",
      "history_2.0.1": "Corrected to Vulg versification (2011-07-09)",
      "history_3.0":
          "(2016-03-20) New TextSource, KJV v11n, removal of Deuterocanonicals",
      "history_3.1": "(2018-11-14) Switch to Segond versification",
      "history_3.1.1": "(2022-08-05) Fix typos in configuration file"
    },
    "url": "https://api.getbible.net/v2/ls1910.json",
    "sha": "c65769ae935835951f0405bff74baf7ac06e67bb"
  },
  "luther1545": {
    "translation": "Luther (1545)",
    "abbreviation": "luther1545",
    "description":
        "German Luther Übersetzung von 1545 (moderne Rechtschreibung)",
    "lang": "de",
    "language": "German",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. German.",
    "distribution_version": "2.0.1",
    "distribution_version_date": "2014-02-25",
    "distribution_abbreviation": "luther1545",
    "distribution_about":
        "1545 Luther Bibelübersetzung\\par License: Public Domain -- copy freely\\par\\par Made available in electronic format by Michael Bolsinger (Michael.Bolsinger@t-online.de) at http://www.luther-bibel-1545.de.",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://www.luther-bibel-1545.de/",
    "distribution_versification": "NRSV",
    "distribution_history": {
      "history_2.0.1":
          "Description updated to reflect orthographic updates (2014-02-25)",
      "history_2.0":
          "Rebuilt from source, with corrections based on other online sources; undid vandalism indicated by 1.1; corrected versification errors; added book of Judges (2013-10-11)",
      "history_1.2.1": "Corrected .conf format & encoding (2011-07-24)",
      "history_1.2":
          "Encoded all characters as UTF-8, the german umlauts work now in Sword for Windows. (2002-11-07)",
      "history_1.1":
          "Re-added psalms greater than 100, replaced GOtt* by Gott*, JEsu* by Jesu* and HErr* by HERR* (2002-06-09)",
      "history_1.0": "Use updated text, compressed module (2002-05-26)",
      "history_0.92":
          "Changed module name from \"GerLut 1545\" to \"GerLut1545\" for SWORD compatibility. (2000-09-17)",
      "history_0.91": "some spelling errors corrected (2000-09-09)",
      "history_0.90": "First official version (2000-08-30)"
    },
    "url": "https://api.getbible.net/v2/luther1545.json",
    "sha": "0599a6aef29d2ff341d16168e42a0c71dc20b628"
  },
  "mal1910": {
    "translation": "Sathyavedapusthakam (Malayalam Bible) published in 1910",
    "abbreviation": "mal1910",
    "description": "Sathyavedapusthakam (Malayalam Bible) published in 1910",
    "lang": "mlf",
    "language": "",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Mal",
    "distribution_version": "2.0",
    "distribution_version_date": "2023-01-07",
    "distribution_abbreviation": "mal1910",
    "distribution_about":
        "Sathyavedapusthakam (Malayalam Bible) published in 1910",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "https://github.com/tfbf/sathyavedapusthakam",
    "distribution_versification": "NRSV",
    "distribution_history": {
      "history_1.1": "Some further encoding corrections",
      "history_1.1.1": "Some conf corrections",
      "history_1.1.3": "(2022-08-14) Fix repeated LCSH in conf",
      "history_2.0": "(2023-01-07) Updated source to latest Git"
    },
    "url": "https://api.getbible.net/v2/mal1910.json",
    "sha": "e4d3028c9dbc99dd7382aa944c0739c7428fbace"
  },
  "manxgaelic": {
    "translation": "Manx Gaelic (Esther Jonah 4 Gospels)",
    "abbreviation": "manxgaelic",
    "description": "Manx Gaelic Scripture Portions",
    "lang": "gv",
    "language": "Manx Gaelic",
    "direction": "LTR",
    "encoding": "",
    "distribution_lcsh": "Bible. Manx Gaelic.",
    "distribution_version": "1.1",
    "distribution_version_date": "2003-05-08",
    "distribution_abbreviation": "manxgaelic",
    "distribution_about":
        "Gaelic Scripture Portions (Manx Gaelic)\\par The Manx Gaelic Scripture portions were found at: http://www.smo.uhi.ac.uk/~kelly/menu.html#BIB.\\par They include Esther, Jonah, Matthew, Luke, and John. This looks like it has been scanned in, so there are probably a few spelling errors. Manx was spoken on the Isle of Man in Great Britain. The Ethnologue lists Manx as having no native speakers.\\par Courtesy the Unbound Bible (http://unbound.biola.edu/)",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "",
    "distribution_source": "http://unbound.biola.edu/",
    "distribution_versification": "",
    "distribution_history": {"history_1.1": "compressed module"},
    "url": "https://api.getbible.net/v2/manxgaelic.json",
    "sha": "c4edfa6615444834362be2100958c438d45524b5"
  },
  "maori": {
    "translation": "Maori",
    "abbreviation": "maori",
    "description": "Maori Bible",
    "lang": "mi",
    "language": "Maori",
    "direction": "LTR",
    "encoding": "",
    "distribution_lcsh": "Bible. Maori.",
    "distribution_version": "1.1",
    "distribution_version_date": "2006-10-25",
    "distribution_abbreviation": "maori",
    "distribution_about":
        "Maori Bible prepared by Timothy Mora.\\par Text reproduced by Dr. Cleve Barlow.",
    "distribution_license": "",
    "distribution_sourcetype": "GBF",
    "distribution_source": "",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.1": "Compressed the module",
      "history_1.0": "initial release"
    },
    "url": "https://api.getbible.net/v2/maori.json",
    "sha": "fe9ea9346faa91e2f292c68b69365acb2f8292c3"
  },
  "martin": {
    "translation": "Martin (1744)",
    "abbreviation": "martin",
    "description": "French Bible Martin (1744)",
    "lang": "fr",
    "language": "French",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. French.",
    "distribution_version": "1.2",
    "distribution_version_date": "2008-07-20",
    "distribution_abbreviation": "martin",
    "distribution_about":
        "La Sainte Bible, Version David Martin 1744: Cette Bible est basée sur le Textus Receptus et est très fidèle. C'est une Bible d'étude idéal, bien qu'elle contienne quelques vieux mots français. Pour plus d'infos, aller sur le site: www.biblemartin.com.",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://www.biblemartin.com/",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.2": "Re-made module from new text source",
      "history_1.1": "Updated text source",
      "history_1.0": "First version"
    },
    "url": "https://api.getbible.net/v2/martin.json",
    "sha": "bfed92322117de41d6558d374ec546ae10143962"
  },
  "moderngreek": {
    "translation": "Greek Modern",
    "abbreviation": "moderngreek",
    "description":
        "Neophytos Vamvas's translation of the Holy Bible into modern Greek (1850)",
    "lang": "el",
    "language": "Greek Modern",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. Greek (Modern Greek).",
    "distribution_version": "1.0.3",
    "distribution_version_date": "2012-07-12",
    "distribution_abbreviation": "moderngreek",
    "distribution_about":
        "This translation started in 1831 and was published in 1850 by the Orthodox Archimandrite and professor of the National University of Athens, Neophytos Vamvas with the help of other researchers. Considering that the Greek Orthodox Church wouldn't support him, he collaborated with the British and Foreign Bible Society to publish this translation.\\par The text is written in \"kathareuousa\", a form of greek that is not spoken today in Greece. It is closer to spoken greek though, than the Septuagint (also known \"translation of the seventy\").",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "www.theword.gr",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.0": "Initial release (2008-07-23)",
      "history_1.0.1": "Added trailing '/' in .conf (2012-07-12)",
      "history_1.0.2":
          "Added entries re license and obsoletion  to conf file (2014-12-27)",
      "history_1.0.3":
          "(2022-08-05) Fix repeated DistributionLicense in conf file"
    },
    "url": "https://api.getbible.net/v2/moderngreek.json",
    "sha": "c275300400c4cf0f931f0b533ee54ff57cd8ca28"
  },
  "modernhebrew": {
    "translation": "Hebrew Modern",
    "abbreviation": "modernhebrew",
    "description": "Modern Hebrew Bible",
    "lang": "he",
    "language": "Hebrew",
    "direction": "RTL",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Hebrew",
    "distribution_version": "1.2",
    "distribution_version_date": "2020-02-07",
    "distribution_abbreviation": "modernhebrew",
    "distribution_about":
        "Modern Hebrew Bible\\par Electronic text courtesy the Unbound Bible (http://unbound.biola.edu/)",
    "distribution_license": "",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://unbound.biola.edu/",
    "distribution_versification": "KJV",
    "distribution_history": {
      "history_1.1":
          "(2001-11-27) changed periods to sof pasuq and removed linefeeds",
      "history_1.2":
          "(2020-02-07) Fix issue https://tracker.crosswire.org/browse/MOD-299"
    },
    "url": "https://api.getbible.net/v2/modernhebrew.json",
    "sha": "26d85b11e406f7cae1992ee7579e745d2f0fab64"
  },
  "peshitta": {
    "translation": "Peshitta NT",
    "abbreviation": "peshitta",
    "description": "Syriac Peshitta",
    "lang": "syr",
    "language": "Syriac",
    "direction": "RTL",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Syriac",
    "distribution_version": "2.0",
    "distribution_version_date": "2020-02-08",
    "distribution_abbreviation": "peshitta",
    "distribution_about":
        "The Peshitta (Classical Syriac: ܦܫܺܝܛܬܳܐ‎ or ܦܫܝܼܛܬܵܐ pšīṭtā) is the standard version of the Bible for churches in the Syriac tradition. The text is that published by the British and Foreign Bible Society in 1905\\par Public Domain\\par Courtesy John Richards.",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source":
        "http://www.tertullian.org/rpearse/thesyriaclibrary/new_testament.htm or http://madenkha.net/holy_bible/",
    "distribution_versification": "KJV",
    "distribution_history": {
      "history_1.1": "(2002-01-01) tagged as right to left",
      "history_2.0": "(2020-02-08) New TextSource, fix emptyvss issues"
    },
    "url": "https://api.getbible.net/v2/peshitta.json",
    "sha": "6596ad5b332a426d3b968b15db706d17ffc9961e"
  },
  "potawatomi": {
    "translation": "Potawatomi (Matthew Acts) (Lykins 1844)",
    "abbreviation": "potawatomi",
    "description": "1833 Potawatomi Matthew and Acts",
    "lang": "pot",
    "language": "Potawatomi",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. N.T. Potowatomi.",
    "distribution_version": "1.0",
    "distribution_version_date": "2007-04-26",
    "distribution_abbreviation": "potawatomi",
    "distribution_about":
        "1833 Potawatomi Matthew and Acts, Lykins translation",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://unbound.bible.edu/",
    "distribution_versification": "",
    "distribution_history": {"history_1.0": "Initial release"},
    "url": "https://api.getbible.net/v2/potawatomi.json",
    "sha": "2ec95277e315ca215bb43430920933b7a476f113"
  },
  "pyharaamattu1933": {
    "translation": "Pyha Raamattu (1933 1938)",
    "abbreviation": "pyharaamattu1933",
    "description": "Finnish Pyhä Raamattu (1933/1938)",
    "lang": "fi",
    "language": "Finnish",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Finnish",
    "distribution_version": "2.0",
    "distribution_version_date": "2023-01-26",
    "distribution_abbreviation": "Pyhä Raamattu",
    "distribution_about":
        "Vanha Testamentti XI yleisen Kirkolliskokouksen vuonna 1933 käytäntöön ottama suomennos.\\par Uusi Testamentti XII yleisen Kirkolliskokouksen vuonna 1938 käytäntöön ottama suomennos.\\par\\par Abou_en=Finnish Bible authorized by Evangelical Lutheran Church of Finland in 1933 (OT) and 1938 (NT).\\par\\par In public domain.\\par\\par SWORD version by St. Publishare Netherlands 17/11/93\\par\\par Version 1.1 by Tero Favorin (tero at favorin dot com)",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://www.finbible.fi/head/raam.htm",
    "distribution_versification": "NRSVA",
    "distribution_history": {
      "history_1.1":
          "Fixed several missing Ä-letters from beginning of verses.",
      "history_1.2": "Compressed module (2003-02-20)",
      "history_1.3":
          "Changed encoding to UTF-8. Rebuilt module with braces {} instead of lt/gt for av11n refs (2013-01-21)",
      "history_2.0":
          "(2023-01-26) Switch to OSIS format. Fix encoding issues on Ezra. Added deuterocanonical books."
    },
    "url": "https://api.getbible.net/v2/pyharaamattu1933.json",
    "sha": "01498618aec6c5166796ffab15385f4130c68c30"
  },
  "pyharaamattu1992": {
    "translation": "Pyha Raamattu (1992)",
    "abbreviation": "pyharaamattu1992",
    "description": "Finnish Pyhä Raamattu (1992)",
    "lang": "fi",
    "language": "Finnish",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Finnish",
    "distribution_version": "1.2",
    "distribution_version_date": "2023-05-17",
    "distribution_abbreviation": "Pyhä Raamattu 1992",
    "distribution_about":
        "Suomen evankelis-luterilaisen kirkon kirkolliskokouksen vuonna 1992 käyttöön ottama suomennos.\\par\\par Tämä raamatunkäännös on Kirkon keskusrahaston omistama.  Teksti on tarkoitettu tutkimus-, opetus-, ja opiskelukäyttöön.  Tekstin saa hakea itselle, mutta kopioiminen ja edelleen levittäminen on ehdottomasti kielletty.  Muuta kuin henkilökohtaista tutkimuskäyttöä varten tarvitaan erillinen lupa kirkon keskusrahastolta.\\par\\par Finnish Bible authorized by Evangelical Lutheran Church of Finland in 1992.\\par\\par This translation of The Holy Bible is copyrighted by Kirkon keskusrahasto.  The text is intended to research and studying purposes.  The text may be retrieved to your personal workstation but copying and re-distributing is strictly forbidden.  For other usages than personal research, teaching and studying a separate license by Kirkon keskusrahasto is required.\\par Kirkon keskusrahasto\\par Satamakatu 11 A\\par 00160 HELSINKI\\par FINLAND\\par\\par tel. +358-0-18021\\par\\par SWORD version by Tero Favorin (tero at favorin dot com)",
    "distribution_license":
        "Copyrighted; Permission to distribute granted to CrossWire",
    "distribution_sourcetype": "OSIS",
    "distribution_source":
        "https://raamattu.fi/raamattu/KR92/GEN.1/1.-Mooseksen-kirja-1",
    "distribution_versification": "German",
    "distribution_history": {
      "history_1.1": "Added two missing words in Luke 24:53 (2003-05-07)",
      "history_1.1.1": "Fixed encoding of .conf (2012-12-28)",
      "history_1.1.2":
          "Rebuilt module with braces {} instead of lt/gt (2013-01-03) ; Supplied missing \"}\" in 1Ch 12:11. Also replaced every instance of multiple whitespace by a single space. See http://www.crosswire.org/tracker/browse/MOD-230",
      "history_1.2":
          "(2023-05-17) Converted from imp to OSIS and correction of the braces (MOD-230)"
    },
    "url": "https://api.getbible.net/v2/pyharaamattu1992.json",
    "sha": "5252f6923601e91beeca0f1d019ea3095469bed9"
  },
  "riveduta": {
    "translation": "Riveduta Bible (1927)",
    "abbreviation": "riveduta",
    "description": "Italian Riveduta Bibbia (1927)",
    "lang": "it",
    "language": "Italian",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Italian",
    "distribution_version": "1.1",
    "distribution_version_date": "2020-02-08",
    "distribution_abbreviation": "riveduta",
    "distribution_about":
        "1927 Italian Riveduta Bibbia: Versione riveduta in testo originale dal Dott. GIOVANNI LUZZI già Prof. alla Facoltà Teologica Valdese di Roma.",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source":
        "http://lasacrabibbiaelaconcordanza.lanuovavia.org/bibbiapdf3.pdf",
    "distribution_versification": "KJV",
    "distribution_history": {
      "history_1.0": "(2002-01-15) Initial release",
      "history_1.1":
          "(2020-02-08) Fix issue https://tracker.crosswire.org/browse/MOD-299"
    },
    "url": "https://api.getbible.net/v2/riveduta.json",
    "sha": "47807384fa5f27222e2f7d953b5373ee5a1bc61f"
  },
  "rv1858": {
    "translation": "Reina Valera NT (1858)",
    "abbreviation": "rv1858",
    "description": "La Santa Biblia Reina-Valera (1909)",
    "lang": "es",
    "language": "Spanish",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Spanish Castilian",
    "distribution_version": "2.0",
    "distribution_version_date": "2021-10-19",
    "distribution_abbreviation": "rv1858",
    "distribution_about":
        "La Santa Biblia\\par antiguo y nuevo testamento\\par Antigua versión de casiodoro de reina (1569)\\par Revisada por cipriano de valera (1602)\\par Y cotejada posteriormente con diversas traducciones, y con los textos Hebreo y Griego",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source":
        "https://es.wikisource.org/wiki/Biblia_Reina-Valera_1909",
    "distribution_versification": "KJV",
    "distribution_history": {
      "history_1.0": "Initial release",
      "history_1.1": "Compressed the module",
      "history_1.5":
          "Converted to OSIS markup, corrected typos & versification errors",
      "history_1.6":
          "Corrected typos & missing accents, added divineName markup, reimported text (2011-03-27)",
      "history_2.0": "(2021-10-19) New source text from wikisource"
    },
    "url": "https://api.getbible.net/v2/rv1858.json",
    "sha": "46ecba128dc37aec35ff5aa685ca66a5208cfd39"
  },
  "sahidic": {
    "translation": "Sahidic NT",
    "abbreviation": "sahidic",
    "description": "Sahidic Coptic New Testament, ed. by G. W. Horner",
    "lang": "cop",
    "language": "Coptic",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. N.T. Coptic (Sahidic).",
    "distribution_version": "1.5",
    "distribution_version_date": "2009-11-01",
    "distribution_abbreviation": "sahidic",
    "distribution_about":
        "The Coptic version of the New Testament in the Southern dialect, otherwise called Sahidic and Thebaic, published in 1911, edited by George William Horner (1849-1930).",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "Slavic Bible for Windows",
    "distribution_versification": "NRSV",
    "distribution_history": {
      "history_1.5":
          "Updated to Unicode 5.0 and OSIS encoding, corrected a number of misnumbered verses",
      "history_1.0": "Initial release"
    },
    "url": "https://api.getbible.net/v2/sahidic.json",
    "sha": "0975d5d1e694e7f98cb21e18920c68efcf5aa505"
  },
  "schlachter": {
    "translation": "Schlachter (1951)",
    "abbreviation": "schlachter",
    "description": "Schlachter Bibel (1951)",
    "lang": "de",
    "language": "German",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.German",
    "distribution_version": "2.0.1",
    "distribution_version_date": "2023-04-24",
    "distribution_abbreviation": "Schlachter",
    "distribution_about":
        "SCHLACHTER BIBEL 1951\\par\\par Die Heilige Schrift des Alten und Neuen Testaments nach dem Urtext üersetzt von F.E. SCHLACHTER Neue Uberarbeitung 1951\\par Genfer Bibelgesellschaft\\par\\par Copyright (c) 1951 Genfer Bibelgeschellschaft.",
    "distribution_license": "Copyrighted; Free non-commercial distribution",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "Genfer Bibelgeschellschaft. Geneva Bible Society",
    "distribution_versification": "German",
    "distribution_history": {
      "history_1.1": "Compressed the module (2006-10-25)",
      "history_1.1.1": "Corrected module encoding (2013-08-20)",
      "history_2.0": "(2022-06-23) Solves MOD-412 and MOD-427",
      "history_2.0.1":
          "(2023-04-24) Small correction in the conf file: Fix description (MOD-451)"
    },
    "url": "https://api.getbible.net/v2/schlachter.json",
    "sha": "d1b18f7f602fe8134f3f18e6ae10ed9b377cd270"
  },
  "sse": {
    "translation": "Sagradas Escrituras (1569)",
    "abbreviation": "sse",
    "description":
        "La Santa Biblia Reina-Valera (1865) con arreglos ortográficos",
    "lang": "es",
    "language": "Spanish",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Spanish",
    "distribution_version": "1.1",
    "distribution_version_date": "2019-01-07",
    "distribution_abbreviation": "RV1865",
    "distribution_about":
        "La Santa Biblia\\par Que contiene el Antiguo y el Nuevo Testamento.\\par Versión de Cipriano de Valera (1602)\\par Revisada y corregida (1865)\\par Con arreglos ortográficos (2018). \\par\\par Las reglas ortográficas han cambiado desde la edición original, principalmente las reglas que afectan la acentuación de las palabras. La actualización consistió en borrar los acentos en palabras que dejaron de acentuarse ortográficamente. El resultado es un texto igual al original pero válido de acuerdo con la normativa vigente.",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "https://github.com/MC1171611/valera1865",
    "distribution_versification": "KJV",
    "distribution_history": {
      "history_1.0": "(2018-06-08) Initial Release",
      "history_1.1":
          "(2019-01-07) Minor textual errors corrected to match the final text sent to printer"
    },
    "url": "https://api.getbible.net/v2/sse.json",
    "sha": "3633d4adaa117df39e5c39172a06a101a8b4526b"
  },
  "statenvertaling": {
    "translation": "Dutch Staten Vertaling",
    "abbreviation": "statenvertaling",
    "description": "Dutch Statenvertaling Bijbel",
    "lang": "nl",
    "language": "Dutch",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Dutch",
    "distribution_version": "2.1.1",
    "distribution_version_date": "2020-08-01",
    "distribution_abbreviation": "Statenvertaling Bijbel",
    "distribution_about":
        "\\qc BIJBEL\\par\\par DAT IS\\par DE GANSE HEILIGE SCHRIFT\\par\\par BEVATTENDE AL DE KANONIEKE BOEKEN\\par VAN HET\\par\\par OUDE EN NIEUWE TESTAMENT\\par\\par DOOR LAST VAN DE HOOG-MOGENDE HEREN STATEN-GENERAAL DER VERENIGDE NEDERLANDEN EN VOLGENS HET BESLUIT VAN DE SYNODE NATIONAAL GEHOUDEN TE DORDRECHT IN DE JAREN 1618 EN 1619 UIT DE OORSPRONKELIJKE TALEN IN ONZE NEDERLANDSE TAAL GETROUWELIJK OVERGEZET\\par\\par Based on electronic edition from Statenvertaling online",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "https://bijbel.coas.nl/bijbel/",
    "distribution_versification": "KJVA",
    "distribution_history": {
      "history_1.1": "enciphered module",
      "history_1.2": "added Morph option",
      "history_1.3":
          "switched to public domain textbase, unenciphered, compressed",
      "history_1.4": "rebuilt from OSIS source, added Haggai",
      "history_1.5": "fixed book/chapter title display (2008-12-16)",
      "history_2.0": "(2020-02-08) Rebuilt from source",
      "history_2.1": "(2020-08-01) Fix unwanted text addition in Re 22:21",
      "history_2.1.1": "(2022-08-02) Fix typo in configuration file"
    },
    "url": "https://api.getbible.net/v2/statenvertaling.json",
    "sha": "2bc74e4ec96e15373eda773a975d4a796edeeb8c"
  },
  "swahili": {
    "translation": "Swahili",
    "abbreviation": "swahili",
    "description": "Swahili New Testament",
    "lang": "sw",
    "language": "Swahili",
    "direction": "LTR",
    "encoding": "",
    "distribution_lcsh": "Bible. N.T. Swahili.",
    "distribution_version": "1.1",
    "distribution_version_date": "2006-10-25",
    "distribution_abbreviation": "swahili",
    "distribution_about":
        "Public Domain\\par Swahili New Testament\\par\\par PLEASE MAKE COPIES FOR YOUR FRIENDS, NO ROYALTY DUE.",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "GBF",
    "distribution_source": "",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.1": "Compressed the module",
      "history_1.0": "Initial release"
    },
    "url": "https://api.getbible.net/v2/swahili.json",
    "sha": "84e944b21c24e94ed332f452ff514703e4409d69"
  },
  "swedish": {
    "translation": "Swedish (1917)",
    "abbreviation": "swedish",
    "description": "Swedish Bible (1917)",
    "lang": "sv",
    "language": "Swedish",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Swedish",
    "distribution_version": "2.0.1",
    "distribution_version_date": "2019-05-12",
    "distribution_abbreviation": "swedish",
    "distribution_about":
        "BIBELN eller DEN HELIGA SKRIFT\\par innehållande\\par NYA TESTAMENTETS KANONISKA BÖCKER\\par i överensstämmelse med den av\\par KONUNGEN ÅR 1917\\par gillade och stadfästa översättningen\\par This is release 3.7 from Projekt Runeberg (http://www.lysator.liu.se/runeberg/) of the Bible. That release was made 1999-04-09. It contains the full text of the Bible, and all of it has been spell-checked.",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source":
        "http://runeberg.org/download.pl?mode=work&work=bibeln/efs1927",
    "distribution_versification": "NRSVA",
    "distribution_history": {
      "history_1.5": "Updated (2001-11-25)",
      "history_1.5.1": "Corrected .conf encoding (2013-08-20)",
      "history_2.0": "(2019-05-11) minor correction and Deutero addition",
      "history_2.0.1": "(2022-08-06) Fix typo in TextSource"
    },
    "url": "https://api.getbible.net/v2/swedish.json",
    "sha": "9147b40a873543028e824ae5759a86e0b464a976"
  },
  "synodal": {
    "translation": "Synodal Translation (1876)",
    "abbreviation": "synodal",
    "description": "Синодального Перевода Библии",
    "lang": "ru",
    "language": "Russian",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Russian",
    "distribution_version": "1.9.1",
    "distribution_version_date": "2020-12-21",
    "distribution_abbreviation": "Synodal",
    "distribution_about":
        "Синодальный перевод. История русской Библии восходит к 1816 году, когда по повелению императора Александра I Российское Библейское Общество приступило к переводу Нового Завета на русский язык.",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source":
        "http://www.rbo.ru/reading/articles/show/?4&start=0 or http://www.patriarchia.ru/bible/mf",
    "distribution_versification": "Synodal",
    "distribution_history": {
      "history_1.0":
          "Regenerated from cleaner source, including deuterocanonicals",
      "history_1.5": "Changed to bibles.org.uk's source",
      "history_1.8": "Updated to reflect new versification (2010-11-06)",
      "history_1.8.1": "Corrected MinimumVersion (2011-08-17)",
      "history_1.9":
          "(2020-12-30) New source. Fix tracker issues: MOD-275, MOD-203, MOD-160",
      "history_1.9.1": "(2022-08-06) Fix typo in conf file"
    },
    "url": "https://api.getbible.net/v2/synodal.json",
    "sha": "b43a3151c1b8a2d3080a1688dd80dad4894a6b30"
  },
  "tagalog": {
    "translation": "Ang Dating Biblia (1905)",
    "abbreviation": "tagalog",
    "description": "Philippine Bible Society (1905)",
    "lang": "tl",
    "language": "Tagalog",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. Tagalog.",
    "distribution_version": "1.2",
    "distribution_version_date": "2008-07-19",
    "distribution_abbreviation": "tagalog",
    "distribution_about":
        "Philippine Bible Society (1905)\\par in Tagalog (national language of the Philippines)\\par Bible is reconized by its title (Ang Biblia) or (Ang Dating Biblia)\\par This Bible is now Public Domain.",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "",
    "distribution_source":
        "Typed from the Ang Biblia Tagalog by Richard & Dolores Long.",
    "distribution_versification": "",
    "distribution_history": {"history_1.2": "Minor updates to .conf text"},
    "url": "https://api.getbible.net/v2/tagalog.json",
    "sha": "fe1bd9651dc4db39be3315b80e80f6eb250bbca6"
  },
  "textusreceptus": {
    "translation": "NT Textus Receptus (1550 1894) Parsed",
    "abbreviation": "textusreceptus",
    "description": "Textus Receptus (1550/1894)",
    "lang": "grc",
    "language": "Greek",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Ancient Greek (to 1453)",
    "distribution_version": "3.1",
    "distribution_version_date": "2023-03-25",
    "distribution_abbreviation": "Textus Receptus",
    "distribution_about":
        "The Textus Receptus with complete parsing information for all Greek words; base text is Stephens 1550, with variants of Scrivener 1894.",
    "distribution_license": "Creative Commons: BY-NC-SA 4.0",
    "distribution_sourcetype": "OSIS",
    "distribution_source":
        "https://sites.google.com/a/wmail.fi/greeknt/home/greeknt",
    "distribution_versification": "KJV",
    "distribution_history": {
      "history_1.1": "corrected Strong's numbers & variants",
      "history_1.2": "Changed TextSource",
      "history_2.0":
          "Created new OSIS edition from July 17, 2007 edition (2009-11-01)",
      "history_2.1": "Updated to March 15, 2011 edition (2011-03-28)",
      "history_2.2": "Updated to February 3, 2013 edition (2014-01-16)",
      "history_2.2.1": "Added NoParagraphs feature (2014-01-18)",
      "history_2.3":
          "Corrected spacing errors, morphology encoding (2014-02-22)",
      "history_2.4": "Corrected theta and psi encoding (2014-04-13)",
      "history_3.0":
          "(2021-10-28) Correct issues with the Strong numbers reported in the bug tracker https://tracker.crosswire.org/browse/MOD-349",
      "history_3.1": "(2023-03-25) Correction of spurious strong numbers."
    },
    "url": "https://api.getbible.net/v2/textusreceptus.json",
    "sha": "e5e78447d0966dc55e2acb44be0ac14f05fb1ee0"
  },
  "thai": {
    "translation": "Thai from kjv",
    "abbreviation": "thai",
    "description": "Thai King James Version",
    "lang": "th",
    "language": "Thai",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. Thai.",
    "distribution_version": "2.0",
    "distribution_version_date": "2012-02-15",
    "distribution_abbreviation": "thai",
    "distribution_about":
        "Thai translation of the King James Version\\par from http://thaipope.org/webbible/index.html\\par Permission granted to the CrossWire Bible Society to use and distribute the Thai KJV with the SWORD Project by Philip Pope.",
    "distribution_license":
        "Copyrighted; Permission to distribute granted to CrossWire",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://thaipope.org/webbible/",
    "distribution_versification": "",
    "distribution_history": {
      "history_2.0":
          "Module rebuilt from updated source text supplied by translator (2012-02-15)",
      "history_1.5": "(2003-09-24)"
    },
    "url": "https://api.getbible.net/v2/thai.json",
    "sha": "593411293c2408d7e1ba791b0949a95c2c4278a3"
  },
  "tischendorf": {
    "translation": "NT Tischendorf 8th Ed",
    "abbreviation": "tischendorf",
    "description": "Tischendorf's 8th edition GNT",
    "lang": "grc",
    "language": "Greek",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. N.T. Greek.",
    "distribution_version": "2.5.1",
    "distribution_version_date": "2009-01-10",
    "distribution_abbreviation": "tischendorf",
    "distribution_about":
        "Tischendorf's 8th edition Greek New Testament with morphological tags\\par Based on G. Clint Yale's Tischendorf text and on Dr. Maurice A. Robinson's Public Domain Westcott-Hort text\\par Edited by Ulrik Sandborg-Petersen\\par This text and its analysis are in the Public Domain. Copy freely.",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://morphgnt.org",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.1": "repaired final sigmas",
      "history_1.2": "converted to UTF-8 and compressed",
      "history_1.3": "fixed some incorrect character mappings",
      "history_1.5":
          "switched to Ulrik Sandbord-Petersen's polytonic, morphologically tagged and lemmatized text",
      "history_1.6": "small adjustments to markup; NFC normalized",
      "history_1.7": "updated encoding of lemmas",
      "history_1.8": "corrected encoding of variant (Qere) readings",
      "history_2.5":
          "updated to version 2.5 text, which includes paragraphing and numerous corrections; version sync with source",
      "history_2.5.1": "(2022-08-06) Fix typo in History"
    },
    "url": "https://api.getbible.net/v2/tischendorf.json",
    "sha": "ebd74f7a1188864dcabafc49854b8180a39aba27"
  },
  "turkish": {
    "translation": "Turkish",
    "abbreviation": "turkish",
    "description": "Kutsal Kitap (New Turkish Bible)",
    "lang": "tr",
    "language": "Turkish",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Turkish",
    "distribution_version": "2.1.1",
    "distribution_version_date": "2019-01-07",
    "distribution_abbreviation": "turkish",
    "distribution_about":
        "KUTSAL KİTAP. ESKİ ve YENİ ANTLAŞMA. (Tevrat, Zebur, İncil). © Kitab-ı Mukaddes Şti. ve Yeni Yaşam Yayınları Tic. Ltd. Şti. Nisan 2009. © The Bible Society in Turkey and New Life Publications Ltd. İstanbul Aprıl 2009. \\par Bütün hakları saklıdır. Telif hakkı sahiplerinin yazılı izni olmadan bu yayının herhangi bir biçimde basılıp çoğaltılması (fotokopi yoluyla çoğaltılması, bilgisayar ortamında kullanılması, kaset veya CD'ye kaydedilmesi dahil) yasaktır. Kitabın metnini yukarıda anılan herhangi bir biçimde kullanmak isteyenler, telif hakkı sahiplerinin yazılı izni için yayıncıya başvurmalıdır. Kaynağını açık şekilde belirtmek koşuluyla 100 (yüz) ayeti geçmeyen, Eski ya da Yeni Antlaşma kitaplarından herhangi birinin tamamını içermeyen alıntılar için, telif hakkı sahiplerinden yazılı izin alma zorunluluğu yoktur. Bu kitabın tüm yayın hakları Kitabı Mukaddes Şirketi ile Yeni Yaşam Yayınları'na aittir.",
    "distribution_license":
        "Copyrighted; Permission to distribute granted to CrossWire",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "",
    "distribution_versification": "NRSV",
    "distribution_history": {
      "history_1.0": "Initial release",
      "history_1.1": "Updated copyright info, renamed (2007-08-21)",
      "history_2.0":
          "New text obtained directly from publishers in USFM format (2011-12-30)",
      "history_2.1":
          "(2019-01-07) Further textual updates submitted to CrossWire in 2013",
      "history_2.1.1": "(2019-05-02) Conf file correction"
    },
    "url": "https://api.getbible.net/v2/turkish.json",
    "sha": "bf816a4d212cb92735461afe89f4308bd25887fd"
  },
  "tyndale": {
    "translation": "William Tyndale Bible (1525/1530)",
    "abbreviation": "tyndale",
    "description": "William Tyndale Bible (1525/1530)",
    "lang": "en",
    "language": "English",
    "direction": "LTR",
    "encoding": "",
    "distribution_lcsh": "Bible. English.",
    "distribution_version": "1.0",
    "distribution_version_date": "2002-09-05",
    "distribution_abbreviation": "tyndale",
    "distribution_about":
        "William Tyndale's 1525 New Testament and 1530 Pentateuch.\\par\\par This electronic edition contains only Genesis, the Gospels, Acts, Romans, 1st Corinthians, Hebrews, and Revelation from Tyndale's Bible.  Thanks to Sergej Fedosov of the Slavic Bible (http://sbible.boom.ru) for providing this excellent work.",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "",
    "distribution_source": "Slavic Bible",
    "distribution_versification": "",
    "distribution_history": {},
    "url": "https://api.getbible.net/v2/tyndale.json",
    "sha": "61a19a34845b9430180481e3a7c4b7036f798b06"
  },
  "ukranian": {
    "translation": "NT (P Kulish 1871)",
    "abbreviation": "ukranian",
    "description": "Новий Завіт. Переклад П. Куліша (1871)",
    "lang": "uk",
    "language": "Ukrainian",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. NT. Ukrainian.",
    "distribution_version": "1.1",
    "distribution_version_date": "2010-11-11",
    "distribution_abbreviation": "ukranian",
    "distribution_about":
        "Ukrainian New Testament Translated by P. Kulish. Published in 1871.\\par Courtesy the Unbound Bible (http://unbound.biola.edu/)",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://unbound.biola.edu/",
    "distribution_versification": "",
    "distribution_history": {"history_1.1": "Initial release"},
    "url": "https://api.getbible.net/v2/ukranian.json",
    "sha": "dd4e8470b9726797de50f649d2cf7f7d043aaad3"
  },
  "uma": {
    "translation": "Uma NT",
    "abbreviation": "uma",
    "description": "Uma New Testament",
    "lang": "ppk",
    "language": "Uma",
    "direction": "LTR",
    "encoding": "",
    "distribution_lcsh": "Bible. Uma.",
    "distribution_version": "1.2",
    "distribution_version_date": "2006-10-25",
    "distribution_abbreviation": "uma",
    "distribution_about":
        "The New Testament in Uma\\par Central Sulawesi, Indonesia\\par Copyright (c) 1996\\par Wycliffe Bible Translators\\par Released for non-profit scholarly and personal use.\\par Not to be sold for profit.",
    "distribution_license": "Copyrighted; Free non-commercial distribution",
    "distribution_sourcetype": "GBF",
    "distribution_source": "",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.2": "Changed Lang in conf",
      "history_1.1": "Compressed the module",
      "history_1.0": "Initial release"
    },
    "url": "https://api.getbible.net/v2/uma.json",
    "sha": "b352290d99f6597661949b72cd9d5f70d850c973"
  },
  "valera": {
    "translation": "Reina Valera (1909)",
    "abbreviation": "valera",
    "description": "Reina-Valera 1909 con números de Strong",
    "lang": "es",
    "language": "Spanish",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. Spanish.",
    "distribution_version": "1.0.1",
    "distribution_version_date": "2012-07-19",
    "distribution_abbreviation": "valera",
    "distribution_about":
        "Biblia Reina-Valera 1909 con números de Strong v 1.0\\par\\par La Santa Biblia\\par Antiguo y Nuevo Testamento\\par\\par Antigua versión de Casiodoro de Reina (1569), revisada por Cipriano de Valera (1602) y cotejada posteriormente con diversas traducciones, y con los textos hebreo y griego.\\par\\par Sociedad Bíblica Americana\\par Sociedad Bíblica Británica y Extranjera\\par\\par El texto de la Reina-Valera 1909 es de dominio público.\\par Las etiquetas con los números de Strong han sido editadas por Rubén Gómez.\\par\\par Los números de Strong se actualizarán periódicamente. Por favor, informe de cualquier error u omisión al editor de la obra:\\par rubeng{at}infotelecom{dot}es",
    "distribution_license":
        "Copyrighted; Permission to distribute granted to CrossWire",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://www.BSReview.org",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.0.1": "Updated About text in .conf (2012-07-19)",
      "history_1.0": "Initial release (2012-07-10)"
    },
    "url": "https://api.getbible.net/v2/valera.json",
    "sha": "11405596a825b2947c7bd35d67e5eea8576a58cf"
  },
  "vietnamese": {
    "translation": "Vietnamese (1934)",
    "abbreviation": "vietnamese",
    "description": "Kinh Thánh Tiếng Việt (1934)",
    "lang": "vi",
    "language": "Vietnamese",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. Vietnamese.",
    "distribution_version": "1.4.1",
    "distribution_version_date": "2013-08-20",
    "distribution_abbreviation": "vietnamese",
    "distribution_about":
        "Kinh Thánh Tiếng Việt\\par The 1934 Vietnamese Bible\\par Published without a copyright statement.\\par The Bible Text is PUBLIC DOMAIN\\par\\par Text supplied by Mr. Phien Nguyen of Hollywood, Florida",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "",
    "distribution_source": "http://unbound.biola.edu/",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.4.1": "Corrected .conf encoding (2013-08-20)",
      "history_1.4": "Fixed display problems with some characters (2002-01-01)",
      "history_1.3": "Compressed module",
      "history_1.2": "Changed to UTF-8 text source",
      "history_1.1": "Repaired dropped characters at beginning of some verses"
    },
    "url": "https://api.getbible.net/v2/vietnamese.json",
    "sha": "49730016e85f5ad13fa712a25248ecffd49ad55b"
  },
  "vulgate": {
    "translation": "Vulgata Clementina",
    "abbreviation": "vulgate",
    "description": "Clementine Vulgate",
    "lang": "la",
    "language": "Latin",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Latin",
    "distribution_version": "2.0.1",
    "distribution_version_date": "2017-10-28",
    "distribution_abbreviation": "vulgate",
    "distribution_about":
        "Clementine Vulgate from La Editorial Católica, Madrid, 1946, based on the edition of M. Tweedale of the Clementine Vulgate Project",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source":
        "The Clementine Vulgate Project \\ This module version implements the following features as OSIS markup: \\ book titles, paragraphs, poetry lines, acrostics, speakers, introductions. \\ Simple markup for these features is documented in the project repository. \\ https://bitbucket.org/clementinetextproject/vulsearch4 \\ It was a relatively straightforward task to map that markup to USFM.",
    "distribution_versification": "Vulg",
    "distribution_history": {
      "history_1.0": "Initial release (2009-10-24)",
      "history_1.0.1": "Corrected to Vulg versification (2011-07-09)",
      "history_1.0.2": "Corrected .conf encoding (2013-08-21)",
      "history_2.0": "(2017-10-25) Rebuilt with added features",
      "history_2.0.1": "(2017-10-28) corrected conf file",
      "history_2.0.2": "(2019-01-07) corrected conf file"
    },
    "url": "https://api.getbible.net/v2/vulgate.json",
    "sha": "159c9d0fe1038b37b94fd6065a31fd444325c0bf"
  },
  "wb": {
    "translation": "Webster's Bible",
    "abbreviation": "wb",
    "description": "Webster Bible",
    "lang": "en",
    "language": "English",
    "direction": "LTR",
    "encoding": "",
    "distribution_lcsh": "Bible. English.",
    "distribution_version": "1.2",
    "distribution_version_date": "2003-05-08",
    "distribution_abbreviation": "wb",
    "distribution_about":
        "THE HOLY BIBLE,\\par CONTAINING THE OLD AND NEW TESTAMENTS,\\par IN THE COMMON VERSION.\\par WITH AMENDMENTS OF THE LANGUAGE,\\par BY NOAH WEBSTER, LL. D.\\par\\par -------------\\par NEW HAVEN:\\par PUBLISHED BY DURRIE & PECK.\\par Sold by HEZEKIAH HOWE & CO., and A. H. MALTBY, New Haven;\\par and by N.&J. WHITE, New York.\\par\\par ------\\par 1833\\par\\par Webster Bible Electronic Format.\\par PUBLIC DOMAIN\\par\\par February 1992\\par\\par Beginning in July of 1991 the task of placing the Webster Bible text in electronic format began.  The original purpose was to provide Larry Pierce, who produces the On-Line Bible program, with a more modern *public domain* text, similar in content and style to the AV but with a grammar that would provide better comprehension in todays English.\\par\\par I plan on maintaining an accurate copy of the Webster text.  Anyone finding an error should contact me; Anyone desiring to obtain the latest, most correct text, can find it on the Bible Foundation BBS, or can contact me in the following methods:\\par \tInternet\t\t\tacus10@waccvm.corp.mot.com\\par \tHome phone\t\t602-829-8542\\par  Address\t\tMark Fuller\\par \t\t\t\t1129 East Loyola Drive\\par \t\t\t\tTempe Arizona, 85282\\par \tBible Foundation\thttp://www.bf.org\\par\\par I would like to thank the Bible Foundation not only for scanning nearly the entire Webster Bible but for encouraging me to undertake this monumental work; particularly around page 20 when I realized what I had gotten myself into.  Special thanks to Jerry Kingery of the Bible Foundation for scanning, and Jerry Hastings for doing some preliminary scan cleaning and making the texts available on the BBS.",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "",
    "distribution_source": "http://www.bf.org/",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.2": "compressed module",
      "history_1.1": "Fixed two small errors (noted in revision.txt)"
    },
    "url": "https://api.getbible.net/v2/wb.json",
    "sha": "07f9fd4e6b897c775cfb9afbb27f7ddd3e8e7a1e"
  },
  "web": {
    "translation": "World English Bible",
    "abbreviation": "web",
    "description": "World English Bible",
    "lang": "en",
    "language": "English",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. English.",
    "distribution_version": "3.1",
    "distribution_version_date": "2012-01-25",
    "distribution_abbreviation": "web",
    "distribution_about":
        "World English Bible (WEB)\\par\\par Public Domain\\par\\par\tThe World English Bible is a 1997 revision of the American Standard Version of the Holy Bible, first published in 1901. It is in the Public Domain. Please feel free to copy and distribute it freely.\\par\\par Thank you to Michael Paul Johnson for making this work available. For the latest information, to report corrections, or for other correspondence visit http://www.ebible.org",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "http://ebible.org/web/",
    "distribution_versification": "",
    "distribution_history": {
      "history_3.1": "Corrected mis-converted tags (2012-01-25)",
      "history_3.0": "Updated to text as of 2012-01-11 (2012-01-18)",
      "history_1.8": "Updated to text as of 2007-08-26 (2008-04-21)",
      "history_1.7": "Updated to text as of 2007-04-20",
      "history_1.6": "Move to OSIS, updated to text as of 2006-01-05",
      "history_1.5": "Compressed the module",
      "history_1.4": "Replaces some more missing verses",
      "history_1.3": "Added some missing verses & fixed words in red",
      "history_1.2": "Fixed footnotes",
      "history_1.1": "Updated as of 04-13-2001"
    },
    "url": "https://api.getbible.net/v2/web.json",
    "sha": "b02e1d3e38cc6ccba30e2c1760df9f479afaa408"
  },
  "westcotthort": {
    "translation": "NT Westcott Hort UBS4 variants Parsed",
    "abbreviation": "westcotthort",
    "description": "Westcott and Hort with NA27/UBS4 variants",
    "lang": "grc",
    "language": "Greek",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. N.T. Greek.",
    "distribution_version": "2.4.1",
    "distribution_version_date": "2014-04-13",
    "distribution_abbreviation": "westcotthort",
    "distribution_about":
        "The Westcott and Hort edition of 1881 with complete parsing information for all Greek words. Readings of Nestle-Aland 27th/UBS4 shown, also with complete parsing information attached.",
    "distribution_license": "Creative Commons: BY-NC-SA 4.0",
    "distribution_sourcetype": "OSIS",
    "distribution_source":
        "https://sites.google.com/a/wmail.fi/greeknt/home/greeknt",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.5": "repaired final sigma and chi/xi swapped",
      "history_1.6": "repaired final sigmas and chi/xi swapping (again)",
      "history_1.7": "converted to UTF-8 and compressed",
      "history_1.8": "added Strong's numbers & Robinson morph tags",
      "history_1.9": "corrected Strong's numbers & variants",
      "history_1.10": "Changed TextSource",
      "history_2.0":
          "Created new OSIS edition from July 17, 2007 edition (2009-11-01)",
      "history_2.1": "Updated to March 15, 2011 edition (2011-03-28)",
      "history_2.2": "Updated to February 3, 2013 edition (2014-01-16)",
      "history_2.2.1": "Added NoParagraphs feature (2014-01-18)",
      "history_2.3":
          "Corrected spacing errors, morphology encoding (2014-02-22)",
      "history_2.4": "Corrected theta and psi encoding (2014-04-13)",
      "history_2.4.1": "(2022-08-06) Fix typo in DistributionLicense"
    },
    "url": "https://api.getbible.net/v2/westcotthort.json",
    "sha": "e8d014f49625f4ee9d542b599155adc468a3138d"
  },
  "westernarmenian": {
    "translation": "Western NT",
    "abbreviation": "westernarmenian",
    "description": "1853 Western Armenian NT",
    "lang": "hy",
    "language": "Armenian",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. N.T. Armenian.",
    "distribution_version": "1.1",
    "distribution_version_date": "2008-07-14",
    "distribution_abbreviation": "westernarmenian",
    "distribution_about": "1853 Western Armenian NT",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "Slavic Bible via http://unbound.biola.edu",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.1": "Updated About and Description text, LCSH value"
    },
    "url": "https://api.getbible.net/v2/westernarmenian.json",
    "sha": "bf570de5d793b90f9fe78f57113bfa22498b7f15"
  },
  "weymouth": {
    "translation": "Weymouth NT",
    "abbreviation": "weymouth",
    "description": "Weymouth NT (1912)",
    "lang": "en",
    "language": "English",
    "direction": "LTR",
    "encoding": "",
    "distribution_lcsh": "Bible. N. T. English.",
    "distribution_version": "1.1",
    "distribution_version_date": "2006-10-25",
    "distribution_abbreviation": "weymouth",
    "distribution_about":
        "WEYMOUTH NEW TESTAMENT\\par NEW TESTAMENT IN MODERN SPEECH by Richard F. Weymouth, 3rd Edition (1912)--Revised & edited E. Hampden-Cooke\\par\\par ...........  PUBLIC DOMAIN .. COPY FREELY  ..........\\par Reprint available Kregel Publications.  Grand Rapids MI",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "GBF",
    "distribution_source": "",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.1": "Compressed the module",
      "history_1.0": "Initial release"
    },
    "url": "https://api.getbible.net/v2/weymouth.json",
    "sha": "fedcb6c882a7e6b4a53a4ae5b76578108fa4542c"
  },
  "wycliffe": {
    "translation": "John Wycliffe Bible (c.1395)",
    "abbreviation": "wycliffe",
    "description": "John Wycliffe Bible (c.1395)",
    "lang": "enm",
    "language": "English",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible.Old English (1100-1500)",
    "distribution_version": "2.4.1",
    "distribution_version_date": "2020-08-01",
    "distribution_abbreviation": "wycliffe",
    "distribution_about":
        "The Holy Bible, containing the Old and New Testaments, with the Apocryphal books, in the earliest English versions made from the Latin Vulgate by John Wycliffe and his followers, c.1395 \\par\\par Source text https://en.wikisource.org/wiki/Bible_(Wycliffe) \\par\\par John Wycliffe organized the first complete translation of the Bible into Middle English in the 1380s. \\par\\par The translation from the Vulgate was a collaborative effort, and it is not clear which portions are actually Wycliffe's work. \\par\\par Church authorities officially condemned the translators of the Bible into vernacular languages and called these heretics Lollards. \\par\\par Despite their prohibition, revised versions of Wycliffite Bibles remained in use for about 100 years. \\par\\par Wikisource attributes its source as the Wesley Center Online. \\par\\par That in turn was derived from the Fedosov transcription on the Slavic Bibles site http://www.sbible.ru \\par\\par The source text makes no use of archaic letters that were part of Middle English orthography.\\par The Latin letter Yogh [ȝ] was evidently replaced by the letter [y] in the Fedosov transcription. \\par\\par The text is available under the Creative Commons Attribution-ShareAlike License. \\par\\par Verse numbers were not used in either the earlier or later version of the Wycliffe Bible in the fourteenth century. Each chapter consisted of one unbroken block of text. There were not even any paragraphs. Hence whatever verse numbers we now have in modern editions have been added retrospectively by comparison with other English Bibles and the Latin Vulgate. \\par\\par Two books found in the Vulgate, II Esdras and Psalm 151, were never part of the Wycliffe Bible. \\par\\par Module build notes: \\par 1. The Prayer of Manasseh has been separated from 2 Chronicles in order to avoid a critical versification issue. \\par   cf. In Wikisource it was assigned as 2 Paralipomenon chapter 37. \\par 2. The Letter of Jeremiah has been joined to Baruch as chapter 6 thereof. \\par 3. The book order of Wycliffe's Bible differs from that of the Vulg versification used in this module. \\par 4. There are now 313 notes in the Wikisource document. \\par 5. The Wikisource text substantially matches that of the nine books in module version 1.0\\par 6. Each of these five verses not in the Vulg versification was appended to the previous verse: Deut.27.27 Esth.5.15 Ps.38.15 Ps.147.10 Luke.10.43 \\par 7. There are also several verses without any text. Use Sword utility emptyvss to list these.",
    "distribution_license": "Creative Commons: BY-SA 4.0",
    "distribution_sourcetype": "OSIS",
    "distribution_source": "https://en.wikisource.org/wiki/Bible_(Wycliffe)",
    "distribution_versification": "Vulg",
    "distribution_history": {
      "history_1.0":
          "(2002-09-05) Initial incomplete edition based on the Slavic Bible source text for the Pentateuch and the Gospels only.",
      "history_2.0":
          "(2017-03-27) Rebuilt from complete Bible text at Wikisource.",
      "history_2.1":
          "(2017-03-28) Minor improvement: Versified Prayer of Manasseh on Wikisource.",
      "history_2.1.1":
          "(2017-03-29) Added GlobalOptionFilter=OSISFootnotes (the module already had 14 notes in 2 Samuel, Job and Tobit).",
      "history_2.2":
          "(2017-04-03) Rebuilt after 299 notes were added to Pentateuch & Gospels in Wikisource. Minor change to markup of added words.",
      "history_2.3": "(2019-01-07) Updated toolchain",
      "history_2.4":
          "(2020-08-01) title misplacement is fixed for the *Prayer of Jeremiah* in Baruch 6",
      "history_2.4.1": "(2022-08-06) Fix typo in DistributionLicense"
    },
    "url": "https://api.getbible.net/v2/wycliffe.json",
    "sha": "127d045982b6d064c869f4922ccf5134b7ce4f71"
  },
  "ylt": {
    "translation": "Young's Literal Translation",
    "abbreviation": "ylt",
    "description": "Young's Literal Translation (1898)",
    "lang": "en",
    "language": "English",
    "direction": "LTR",
    "encoding": "",
    "distribution_lcsh": "Bible. English.",
    "distribution_version": "1.1",
    "distribution_version_date": "2006-10-25",
    "distribution_abbreviation": "ylt",
    "distribution_about":
        "Young's Literal Translation\\par of the Holy Bible\\par by Robert Young, 1862, 1898\\par (Author of the Young's Analytical Concordance)\\par\\par Printed copy available from Baker Publishing\\par Grand Rapids, Mi. 49516",
    "distribution_license": "Public Domain",
    "distribution_sourcetype": "GBF",
    "distribution_source": "",
    "distribution_versification": "",
    "distribution_history": {
      "history_1.1": "Compressed the module.",
      "history_1.0": "Initial release."
    },
    "url": "https://api.getbible.net/v2/ylt.json",
    "sha": "cf2ce18648bff8413a5b52d9d923aba0f68ab3fe"
  },
  "zhuromsky": {
    "translation": "Victor Zhuromsky NT",
    "abbreviation": "zhuromsky",
    "description":
        "Russian New Testament with Strong's Numbers under edition of Victor R. Zhuromsky.",
    "lang": "ru",
    "language": "Russian",
    "direction": "LTR",
    "encoding": "UTF-8",
    "distribution_lcsh": "Bible. N.T. Russian.",
    "distribution_version": "1.0",
    "distribution_version_date": "2003-03-21",
    "distribution_abbreviation": "zhuromsky",
    "distribution_about":
        "Originally titled as New Testament with Indexing of Each Greek Word According to Strong's Numbers under edition of Victor R. Zhuromsky. This edition contains 143,457 Strong's numbers and is most complete Strong's New Testament edition ever published in hard and electronic copy.  This edition is based on Russian Synodal Translation of 1876 year, and is provided by Victor R. Zhuromsky strictly for use in the SWORD Project.",
    "distribution_license":
        "Copyrighted; Permission to distribute granted to CrossWire",
    "distribution_sourcetype": "GBF",
    "distribution_source":
        "Christian Information Portal at http://christ4you.org",
    "distribution_versification": "",
    "distribution_history": {},
    "url": "https://api.getbible.net/v2/zhuromsky.json",
    "sha": "19b23c1a01af4a4694a56b6678794a70eeb6fbc9"
  }
};

var res = [
  {
    "name": "American King James Version",
    "url": "https://api.getbible.net/v2/akjv.json",
    "encoding": "",
    "abbreviation": "akjv"
  },
  {
    "name": "American Standard Version",
    "url": "https://api.getbible.net/v2/asv.json",
    "encoding": "UTF-8",
    "abbreviation": "asv"
  },
  {
    "name": "Basic English Bible",
    "url": "https://api.getbible.net/v2/basicenglish.json",
    "encoding": "",
    "abbreviation": "basicenglish"
  },
  {
    "name": "Douay Rheims",
    "url": "https://api.getbible.net/v2/douayrheims.json",
    "encoding": "",
    "abbreviation": "douayrheims"
  },
  {
    "name": "King James Version",
    "url": "https://api.getbible.net/v2/kjv.json",
    "encoding": "UTF-8",
    "abbreviation": "kjv"
  },
  {
    "name":
        "King James Version (1769) with Strongs Numbers and Morphology and CatchWords, including Apocrypha (without glosses)",
    "url": "https://api.getbible.net/v2/kjva.json",
    "encoding": "UTF-8",
    "abbreviation": "kjva"
  },
  {
    "name": "William Tyndale Bible (1525/1530)",
    "url": "https://api.getbible.net/v2/tyndale.json",
    "encoding": "",
    "abbreviation": "tyndale"
  },
  {
    "name": "Webster's Bible",
    "url": "https://api.getbible.net/v2/wb.json",
    "encoding": "",
    "abbreviation": "wb"
  },
  {
    "name": "World English Bible",
    "url": "https://api.getbible.net/v2/web.json",
    "encoding": "UTF-8",
    "abbreviation": "web"
  },
  {
    "name": "Weymouth NT",
    "url": "https://api.getbible.net/v2/weymouth.json",
    "encoding": "",
    "abbreviation": "weymouth"
  },
  {
    "name": "Young's Literal Translation",
    "url": "https://api.getbible.net/v2/ylt.json",
    "encoding": "",
    "abbreviation": "ylt"
  }
];
