import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  final List<Member> members = [
    Member(
      imageUrl: 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t1.15752-9/429474254_1357823914884389_4748251150503399841_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeHEDV2nms2yh2rxLjBkYIuAvzTlvo6uDAq_NOW-jq4MCt1oOL6XOOexnjPPhnFPVG2Qg8YrjwwD1QiDiqwLmmrn&_nc_ohc=ZLbEx6dk7-YQ7kNvgHnFVaR&_nc_ht=scontent.fmnl4-4.fna&oh=03_Q7cD1QH3yr8HqMQniaYVZDIRVmQvB-ujRhycAF_Zg_ljrkrCNg&oe=667508DD', // Placeholder image URL for member 1
      name: 'Kim Ignatius',
      role: 'Backend/Frontend Developer',
    ),
    Member(
      imageUrl: 'https://scontent.xx.fbcdn.net/v/t1.15752-9/439804822_960205209070285_1225793391959728150_n.jpg?stp=dst-jpg_s403x403&_nc_cat=109&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeFXprGILwB_a47GJZ46ArfYxbj_BgBXlErFuP8GAFeUSnEsHIw5HfahmSqOriZukg6X7wt2yyf2HAQz0eTds_QC&_nc_ohc=yS-KAuvozOUQ7kNvgEMXV7k&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=03_Q7cD1QGlkoG1C68PDVDYqm6_I6E_xEa7gkXTYFD0bieh-wQ1nw&oe=667516E6', 
      name: 'Elther John',
      role: 'Backend/Frontend Developer',
    ),
    Member(
      imageUrl: 'https://scontent.xx.fbcdn.net/v/t1.15752-9/367378592_639135128223938_5523222871630804568_n.jpg?stp=dst-jpg_p180x540&_nc_cat=106&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeEEfEcse5hHIMBfTtnIaNVxhicDbbHmnFWGJwNtseacVbiGVgLplf-mQIPJZkMU0Ca8YdNkhywkOP18KvJjLVBj&_nc_ohc=hiLhvVsl42UQ7kNvgEYrP5k&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=03_Q7cD1QFJRZ8Sy5GSQt6Qz_xTLh2Uaj73uT0x5_G9wVNVtlJgew&oe=6674F419', 
      name: 'Cybille Jean',
      role: 'UI/UX Designer',
    ),
    Member(
      imageUrl: 'https://scontent.fmnl4-1.fna.fbcdn.net/v/t1.15752-9/440756948_768333948770545_1905171951066768843_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeEGrxWAQHRKqDDRj0zMBQeTUZoSww_S4ppRmhLDD9LimvdpeshB6lv6HiNGvyWXHw0BU8vl9MqA29C4eNy3EdoY&_nc_ohc=fgoLb3F8iswQ7kNvgFu7ybu&_nc_oc=AdjGHl12RmwBHx5G0blYaJFXqU5EpwtMAKh5xpbbkUPNXpy9XuPvBaRe-_LzlroYAEw&_nc_ht=scontent.fmnl4-1.fna&oh=03_Q7cD1QHNhivFUSknOPVi16GYNWIUVraU_01nChiyGUBiAG2UPQ&oe=66753627', 
      name: 'Joebert',
      role: 'Project Manager',
    ),
    Member(
      imageUrl: 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t1.15752-9/438102064_1905606339894846_7832626600938168740_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeFRq8SeSSPhr-V6Zp1KD_LQzimvUYU7QNjOKa9RhTtA2HiVyEufZwt4Zer_hgHjA0DG9nfT48THUDZrFE1PDYyS&_nc_ohc=zNntvDBZ3_oQ7kNvgGsj59V&_nc_ht=scontent.fmnl4-4.fna&oh=03_Q7cD1QFDDSxPGwFWrdPxCW2oL5NLXpq3ldnDYb5OFqxbY-WUQQ&oe=66750DCB', 
      name: 'Jose',
      role: 'Quality Assurance',
    ),
    Member(
      imageUrl: 'https://scontent.fmnl4-5.fna.fbcdn.net/v/t1.15752-9/441012058_463175069538051_4809623848877554738_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeH2CfzazACdsTFswXwo5lWcLplUiyt6mM0umVSLK3qYzfKipfDUDWwMKsaiTf95aT0VvFfXjr_uLiOnH5NOULXT&_nc_ohc=j-BjRfxKXx8Q7kNvgFah5K-&_nc_ht=scontent.fmnl4-5.fna&oh=03_Q7cD1QHLmrNeHR4KwpyZV45LsEQp1t_K1bj4qsdDDJe0GKFAJA&oe=66751F86', 
      name: 'Alexander',
      role: 'Backend/Frontend Developer',
    ),
  ];

  final String visionStatement =
      "To empower everyday users with easy access to reliable global news and facilitate healthy, manageable online discussions through a user-friendly and efficient platform.";
  final String missionStatement =
      "To be the leading mobile app for staying informed and engaging in meaningful conversations, fostering a well-informed and connected community.";

  AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("About Us"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              SectionTitle(title: "Vision"),
              const SizedBox(height: 10),
              SectionContent(content: visionStatement),
              const SizedBox(height: 20),
              SectionTitle(title: "Mission"),
              const SizedBox(height: 10),
              SectionContent(content: missionStatement),
              const SizedBox(height: 20),
              SectionTitle(title: "Our Team"),
              const SizedBox(height: 10),
              TeamGrid(members: members),
              const SizedBox(height: 20),
              SectionTitle(title: "Contact Us"),
              const SizedBox(height: 10),
              ContactUsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class SectionContent extends StatelessWidget {
  final String content;

  SectionContent({required this.content});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 16,
        color: Theme.of(context).textTheme.bodyMedium!.color,
        height: 1.5,
      ),
    );
  }
}

class TeamGrid extends StatelessWidget {
  final List<Member> members;

  TeamGrid({required this.members});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        members.length,
        (index) => TeamMemberCard(member: members[index]),
      ),
    );
  }
}

class TeamMemberCard extends StatelessWidget {
  final Member member;

  TeamMemberCard({required this.member});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                member.imageUrl,
                fit: BoxFit.cover,
                height: 100,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 10),
          EditableText(
            controller: TextEditingController(text: member.name),
            focusNode: FocusNode(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
            cursorColor: Theme.of(context).colorScheme.primary,
            backgroundCursorColor: Colors.transparent,
          ),
          EditableText(
            controller: TextEditingController(text: member.role),
            focusNode: FocusNode(),
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
            cursorColor: Theme.of(context).colorScheme.primary,
            backgroundCursorColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}

class ContactUsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email: elthercurry@gmail.com",
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "Phone: +63987654321",
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "Address: N. Bacalso Avenue, Cebu City, Philippines",
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
        ),
      ],
    );
  }
}

class Member {
  final String imageUrl;
  String name;
  String role;

  Member({required this.imageUrl, required this.name, required this.role});
}
