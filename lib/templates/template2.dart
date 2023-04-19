import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_pixel_pioneers/services/database.dart';
import 'package:the_pixel_pioneers/templates/template.dart';

class Template2 extends Template{

  @override
  Future<String> getHtml() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> education = await Database.getEducation();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> experience = await Database.getExperience();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> skills = await Database.getSkills();
    DocumentSnapshot<Map<String, dynamic>>? profile = await Database.getProfile();

    if (profile == null)  throw Exception("User not found!");

    List<String> skillList = skills[0].data()['description'].toString().split(", ");

    var htmlContent =
    """
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
  <html>
  <head>
  
    <title>${profile.data()!['name']} | ${profile.data()!['profession']}</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  
    <meta name="keywords" content="" />
    <meta name="description" content="" />
  
    <style>
      * {
        box-sizing: border-box;
        transition: 0.35s ease;
      }
      .rela-block {
        display: block;
        position: relative;
        margin: auto;
        top: ;
        left: ;
        right: ;
        bottom: ;
      }
      .rela-inline {
        display: inline-block;
        position: relative;
        margin: auto;
        top: ;
        left: ;
        right: ;
        bottom: ;
      }
      .floated {
        display: inline-block;
        position: relative;
        margin: false;
        top: ;
        left: ;
        right: ;
        bottom: ;
        float: left;
      }
      .abs-center {
        display: false;
        position: absolute;
        margin: false;
        top: 50%;
        left: 50%;
        right: false;
        bottom: false;
        transform: translate(-50%, -50%);
        text-align: center;
        width: 88%;
      }
      body {
        font-family: 'Open Sans';
        font-size: 18px;
        letter-spacing: 0px;
        font-weight: 400;
        line-height: 28px;
        background: url("http://kingofwallpapers.com/leaves/leaves-016.jpg") right no-repeat;
        background-size: cover;
      }
      body:before {
        content: "";
        display: false;
        position: fixed;
        margin: 0;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: rgba(255,255,255,0.92);
      }
      .caps {
        text-transform: uppercase;
      }
      .justified {
        text-align: justify;
      }
      p.light {
        color: #777;
      }
      h2 {
        font-family: 'Open Sans';
        font-size: 30px;
        letter-spacing: 5px;
        font-weight: 600;
        line-height: 40px;
        color: #000;
      }
      h3 {
        font-family: 'Open Sans';
        font-size: 21px;
        letter-spacing: 1px;
        font-weight: 600;
        line-height: 28px;
        color: #000;
      }
      .page {
        width: 90%;
        max-width: 1200px;
        margin: 80px auto;
        background-color: #fff;
        box-shadow: 6px 10px 28px 0px rgba(0,0,0,0.4);
      }
      .top-bar {
        height: 220px;
        background-color: #848484;
        color: #fff;
      }
      .name {
        display: false;
        position: absolute;
        margin: false;
        top: false;
        left: calc(350px + 5%);
        right: 0;
        bottom: 0;
        height: 120px;
        text-align: center;
        font-family: 'Raleway';
        font-size: 58px;
        letter-spacing: 8px;
        font-weight: 100;
        line-height: 60px;
      }
      .name div {
        width: 94%;
      }
      .side-bar {
        display: false;
        position: absolute;
        margin: false;
        top: 60px;
        left: 5%;
        right: false;
        bottom: 0;
        width: 350px;
        background-color: #f7e0c1;
        padding: 320px 30px 50px;
      }
      .mugshot {
        display: false;
        position: absolute;
        margin: false;
        top: 50px;
        left: 70px;
        right: false;
        bottom: false;
        height: 210px;
        width: 210px;
      }
      .mugshot .logo {
        margin: -23px;
      }
      .logo {
        display: false;
        position: absolute;
        margin: false;
        top: 0;
        left: 0;
        right: false;
        bottom: false;
        z-index: 100;
        margin: 0;
        color: #000;
        height: 250px;
        width: 250px;
      }
      .logo .logo-svg {
        height: 100%;
        width: 100%;
        stroke: #000;
        cursor: pointer;
      }
      .logo .logo-text {
        display: false;
        position: absolute;
        margin: false;
        top: 58%;
        left: ;
        right: 16%;
        bottom: ;
        cursor: pointer;
        font-family: "Montserrat";
        font-size: 55px;
        letter-spacing: 0px;
        font-weight: 400;
        line-height: 58.333333333333336px;
      }
      .social {
        padding-left: 60px;
        margin-bottom: 20px;
        cursor: pointer;
      }
      .social:before {
        content: "";
        display: false;
        position: absolute;
        margin: false;
        top: -4px;
        left: 10px;
        right: false;
        bottom: false;
        height: 35px;
        width: 35px;
        background-size: cover !important;
      }
      .social.twitter:before {
        background: url("https://cdn3.iconfinder.com/data/icons/social-media-2026/60/Socialmedia_icons_Twitter-07-128.png") center no-repeat;
      }
      .social.pinterest:before {
        background: url("https://cdn3.iconfinder.com/data/icons/social-media-2026/60/Socialmedia_icons_Pinterest-23-128.png") center no-repeat;
      }
      .social.linked-in:before {
        background: url("https://cdn3.iconfinder.com/data/icons/social-media-2026/60/Socialmedia_icons_LinkedIn-128.png") center no-repeat;
      }
      .side-header {
        font-family: 'Open Sans';
        font-size: 18px;
        letter-spacing: 4px;
        font-weight: 600;
        line-height: 28px;
        margin: 60px auto 10px;
        padding-bottom: 5px;
        border-bottom: 1px solid #888;
      }
      .list-thing {
        padding-left: 25px;
        margin-bottom: 10px;
      }
      .content-container {
        margin-right: 0;
        width: calc(95% - 350px);
        padding: 25px 40px 50px;
      }
      .content-container > * {
        margin: 0 auto 25px;
      }
      .content-container > h3 {
        margin: 0 auto 5px;
      }
      .content-container > p.long-margin {
        margin: 0 auto 50px;
      }
      .title {
        width: 80%;
        text-align: center;
      }
      .separator {
        width: 240px;
        height: 2px;
        background-color: #999;
      }
      .greyed {
        background-color: #ddd;
        width: 100%;
        max-width: 580px;
        text-align: center;
        font-family: 'Open Sans';
        font-size: 18px;
        letter-spacing: 6px;
        font-weight: 600;
        line-height: 28px;
      }
      @media screen and (max-width: 1150px) {
        .name {
          color: #fff;
          font-family: 'Raleway';
          font-size: 38px;
          letter-spacing: 6px;
          font-weight: 100;
          line-height: 48px;
        }
      }
      </style>
  
  </head>
  <body>
  
  <div class="rela-block page">
    <div class="rela-block top-bar">
        <div class="caps name"><div class="abs-center">${profile.data()!['name']}</div></div>
    </div>
    <div class="side-bar">
        <div class="mugshot">
            <div class="logo">
                <svg viewbox="0 0 80 80" class="rela-block logo-svg">
                    <path d="M 10 10 L 52 10 L 72 30 L 72 70 L 30 70 L 10 50 Z" stroke-width="2.5" fill="none"/>
                </svg>
            </div>
        </div>
        <p>${profile.data()!['mobile']}</p>
        <p class="rela-block caps side-header">Expertise</p>
        <p class="rela-block list-thing">${skillList[0]}</p>
        <p class="rela-block list-thing">${skillList[1]}</p>
        <p class="rela-block caps side-header">Education</p>
        <p class="rela-block list-thing">${education[0].data()['Institution']}<b/>${education[0].data()['Degree']}</p>
    </div>
    <div class="rela-block content-container">
        <h2 class="rela-block caps title">${profile.data()!['profession']}</h2>
        <div class="rela-block separator"></div>
        <div class="rela-block caps greyed">Profile</div>
        <p class="long-margin">${profile.data()!['experience']}</p>
        <div class="rela-block caps greyed">Experience</div>

        <h3>${experience[0].data()['organization_name']}</h3>
        <p class="light">${experience[0].data()['position']}</p>
        <p class="justified">${experience[0].data()['summary']}</p>
    </div>
  </div>
  </body>
  </html>
  """;

    return htmlContent;
  }

}