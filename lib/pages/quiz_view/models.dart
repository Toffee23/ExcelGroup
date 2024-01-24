import 'package:course_view/core/constants/images.dart';
import 'package:flutter/material.dart';

class Program {
  final String name;
  final Image image;
  final String title;
  final int courseLength;
  final int levelLength;
  final Color color;

  Program({
    required this.name,
    required this.image,
    required this.title,
    required this.courseLength,
    required this.levelLength,
    required this.color,
  });
}

final programs = <Program>[
  Program(
    name: 'ICAN',
    image: AssetImages.ican,
    title: 'Institute Chartered Accountants of Nigeria',
    courseLength: 23,
    levelLength: 6,
    color: Colors.indigo,
  ),
  Program(
    name: 'ACCA',
    image: AssetImages.acca,
    title: 'Association of Chartered Certified Accountants',
    courseLength: 23,
    levelLength: 6,
    color: Colors.deepOrange,
  ),
  Program(
    name: 'CITN',
    image: AssetImages.citn,
    title: 'Chartered Institute of Taxation of Nigeria',
    courseLength: 23,
    levelLength: 6,
    color: Colors.teal,
  ),
  Program(
    name: 'CIMA',
    image: AssetImages.cima,
    title: 'Chartered Institute of Management Accountants (CIMA)',
    courseLength: 23,
    levelLength: 6,
    color: Colors.purple,
  ),
  Program(
    name: 'CIS',
    image: AssetImages.cis,
    title: 'Chartered Institute of Stockbrokers of Nigeria',
    courseLength: 23,
    levelLength: 6,
    color: Colors.orange,
  ),
  Program(
    name: 'ANAN',
    image: AssetImages.anan,
    title: 'Association of National Accountants of Nigeria ',
    courseLength: 23,
    levelLength: 6,
    color: Colors.indigo,
  ),
  Program(
    name: 'CIBN',
    image: AssetImages.cibn,
    title: 'Chartered Institute of Banking of Nigeria',
    courseLength: 23,
    levelLength: 6,
    color: Colors.green,
  ),
  Program(
    name: 'CFA',
    image: AssetImages.cfa,
    title: 'Chartered Financial Analyst(CFA)',
    courseLength: 23,
    levelLength: 6,
    color: Colors.purple,
  ),
  Program(
    name: 'CPA',
    image: AssetImages.cpa,
    title: 'Certified Public Accountant (CPA)',
    courseLength: 23,
    levelLength: 6,
    color: Colors.orange,
  ),
  Program(
    name: 'CIPM',
    image: AssetImages.cipm,
    title: 'Chartered Institute of Personnel Management of Nigeria',
    courseLength: 23,
    levelLength: 6,
    color: Colors.indigo,
  ),
];
