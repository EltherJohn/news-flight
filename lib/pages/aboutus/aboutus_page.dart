import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  // Define a list of image URLs for each member
  final List<String> memberImages = [
    'https://pngimg.com/uploads/spongebob/spongebob_PNG60.png', // Placeholder image URL for member 1
    'https://yt3.ggpht.com/-bUK9vYlsYTc/AAAAAAAAAAI/AAAAAAAAAAA/_Qa3GRv2kUU/s900-c-k-no-mo-rj-c0xffffff/photo.jpg', // Placeholder image URL for member 2
    'https://via.placeholder.com/150', // Placeholder image URL for member 3
    'https://via.placeholder.com/150', // Placeholder image URL for member 4
    'https://via.placeholder.com/150', // Placeholder image URL for member 5
    'https://via.placeholder.com/150', // Placeholder image URL for member 6
  ];

  // Generic vision statement
  final String visionStatement =
      "To be a leading provider of innovative solutions in our industry.";

  // Generic mission statement
  final String missionStatement =
      "Our mission is to provide the best user experience for our customers.";

   AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("About Us"),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Vision:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.displayLarge!.color,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                visionStatement,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Mission:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.displayLarge!.color,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                missionStatement,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Our Team:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.displayLarge!.color,
                ),
              ),
              const SizedBox(height: 10),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  6,
                  (index) => Padding(
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
                              memberImages[index], // Use the image URL corresponding to the member index
                              fit: BoxFit.cover,
                              height: 100,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Member Name", // Placeholder for member name
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ),
                        Text(
                          "Role", // Placeholder for member role
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
