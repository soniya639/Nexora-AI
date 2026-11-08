import 'package:flutter/material.dart';

class DiseasePredictionScreen extends StatefulWidget {
  const DiseasePredictionScreen({super.key});

  @override
  State<DiseasePredictionScreen> createState() => _DiseasePredictionScreenState();
}

class _DiseasePredictionScreenState extends State<DiseasePredictionScreen> {
  // All Symptoms in English
  final List<String> allSymptoms = [
    "Back Pain",
    "Belly Pain",
    "Blackheads",
    "Bladder Discomfort",
    "Blurred Vision",
    "Body Pain",
    "Breathlessness",
    "Burning Sensation",
    "Chest Pain",
    "Chills",
    "Cold",
    "Constipation",
    "Cough",
    "Dizziness",
    "Dry Skin",
    "Fatigue",
    "Fever",
    "Headache",
    "High Fever",
    "Itching",
    "Joint Pain",
    "Loss of Appetite",
    "Muscle Pain",
    "Nausea",
    "Neck Pain",
    "Nose Bleed",
    "Rashes",
    "Runny Nose",
    "Skin Peeling",
    "Sneezing",
    "Sore Throat",
    "Stomach Pain",
    "Sweating",
    "Swelling",
    "Vomiting",
    "Weakness",
    "Weight Loss",
    "Yellow Skin",
  ];

  Set<String> selectedSymptoms = {};
  String predictedDisease = "";
  String aboutDisease = "";
  String precautions = "";

  // Disease Info - 100% English
  final Map<String, Map<String, String>> diseaseInfo = {
    "GERD": {
      "about": "GERD is Acid Reflux Disease. Acid from the stomach comes up into the food pipe and causes heartburn and chest discomfort.",
      "precautions": "1. Avoid spicy and oily food\n2. Do not lie down immediately after eating\n3. Eat small meals on time\n4. Avoid tea, coffee and soft drinks\n5. Consult a doctor if pain continues"
    },
    "Common Cold": {
      "about": "Common Cold is a viral infection of the nose and throat. It causes sneezing, runny nose, sore throat and mild fever.",
      "precautions": "1. Take proper rest\n2. Drink warm water\n3. Avoid cold drinks and ice cream\n4. Use steam inhalation\n5. Consult a doctor if fever continues for more than 3 days"
    },
    "Fever": {
      "about": "Fever is an increase in body temperature. It is usually a sign that the body is fighting an infection.",
      "precautions": "1. Take rest\n2. Drink plenty of water and fluids\n3. Use cold wet cloth on forehead\n4. Do not take medicine without doctor advice\n5. Consult a doctor if fever is above 102F"
    },
    "Migraine": {
      "about": "Migraine is a severe headache, usually on one side of the head. It can cause nausea, vomiting and sensitivity to light.",
      "precautions": "1. Take rest in a dark and quiet room\n2. Avoid loud noise and bright light\n3. Drink enough water\n4. Avoid skipping meals\n5. Consult a doctor if headache is frequent"
    },
    "Food Poisoning": {
      "about": "Food Poisoning happens due to eating contaminated or spoiled food. It causes stomach pain, vomiting and loose motions.",
      "precautions": "1. Drink ORS and plenty of water\n2. Eat light food like rice and curd\n3. Avoid outside and oily food\n4. Maintain hygiene\n5. Consult a doctor if vomiting continues"
    },
    "Allergy": {
      "about": "Allergy is a reaction of the body to dust, pollen, food or medicine. It causes itching, rashes, sneezing and red eyes.",
      "precautions": "1. Avoid dust and allergens\n2. Keep your surroundings clean\n3. Do not scratch the skin\n4. Drink plenty of water\n5. Consult a doctor if rashes increase"
    },
    "Typhoid": {
      "about": "Typhoid is a bacterial infection caused by contaminated food and water. It causes high fever, weakness and stomach pain.",
      "precautions": "1. Drink only clean boiled water\n2. Eat home cooked food only\n3. Take complete rest\n4. Do not self-medicate\n5. Consult a doctor immediately"
    },
    "Dengue": {
      "about": "Dengue is a mosquito-borne viral fever. It causes high fever, severe body pain, headache and low platelet count.",
      "precautions": "1. Drink plenty of water and papaya leaf juice\n2. Take complete rest\n3. Avoid mosquito bites\n4. Do not take aspirin without doctor advice\n5. Consult a doctor and do a blood test"
    },
    "Diabetes Symptoms": {
      "about": "These symptoms may indicate high blood sugar. It causes frequent urination, more thirst, fatigue and slow healing of wounds.",
      "precautions": "1. Check blood sugar level\n2. Avoid sugar and sweets\n3. Eat healthy and on time\n4. Do regular walking\n5. Consult a doctor for blood test"
    },
    "Hypertension": {
      "about": "Hypertension means High Blood Pressure. It can cause headache, dizziness and chest discomfort. It needs regular monitoring.",
      "precautions": "1. Reduce salt intake\n2. Avoid stress\n3. Do daily walking\n4. Avoid smoking and alcohol\n5. Consult a doctor and check BP regularly"
    },
    "Jaundice": {
      "about": "Jaundice causes yellow skin and yellow eyes. It happens due to liver infection and high bilirubin in the blood.",
      "precautions": "1. Take complete rest\n2. Drink glucose water and sugarcane juice\n3. Eat light and oil-free food\n4. Avoid alcohol\n5. Consult a doctor immediately"
    },
    "Skin Infection": {
      "about": "Skin Infection causes itching, rashes and redness on the skin. It can be due to bacteria, fungus or allergy.",
      "precautions": "1. Keep skin clean and dry\n2. Do not scratch\n3. Wear clean cotton clothes\n4. Avoid sharing towels\n5. Consult a dermatologist"
    },
    "General Illness": {
      "about": "Your symptoms indicate a general illness. It may be due to weakness, infection or change in weather. Proper rest and care is needed.",
      "precautions": "1. Take proper rest\n2. Drink plenty of water\n3. Eat healthy home food\n4. Avoid outside food\n5. Consult a doctor if symptoms continue for more than 3 days"
    },
  };

  void predictDisease() {
    if (selectedSymptoms.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select at least one symptom")),
      );
      return;
    }

    String result = "General Illness";

    // Simple Prediction Logic - All English
    if (selectedSymptoms.contains("Belly Pain") ||
        selectedSymptoms.contains("Stomach Pain") ||
        selectedSymptoms.contains("Chest Pain") ||
        selectedSymptoms.contains("Burning Sensation")) {
      result = "GERD";
    } else if (selectedSymptoms.contains("High Fever") &&
        selectedSymptoms.contains("Body Pain")) {
      result = "Dengue";
    } else if (selectedSymptoms.contains("High Fever") &&
        selectedSymptoms.contains("Stomach Pain")) {
      result = "Typhoid";
    } else if (selectedSymptoms.contains("Yellow Skin")) {
      result = "Jaundice";
    } else if (selectedSymptoms.contains("Sneezing") ||
        selectedSymptoms.contains("Runny Nose") ||
        selectedSymptoms.contains("Sore Throat") ||
        selectedSymptoms.contains("Cold")) {
      result = "Common Cold";
    } else if (selectedSymptoms.contains("Headache") &&
        selectedSymptoms.contains("Nausea")) {
      result = "Migraine";
    } else if (selectedSymptoms.contains("Vomiting") &&
        selectedSymptoms.contains("Stomach Pain")) {
      result = "Food Poisoning";
    } else if (selectedSymptoms.contains("Itching") ||
        selectedSymptoms.contains("Rashes") ||
        selectedSymptoms.contains("Blackheads")) {
      result = "Skin Infection";
    } else if (selectedSymptoms.contains("Fever") ||
        selectedSymptoms.contains("Cough")) {
      result = "Fever";
    } else if (selectedSymptoms.contains("Fatigue") &&
        selectedSymptoms.contains("Weight Loss")) {
      result = "Diabetes Symptoms";
    } else if (selectedSymptoms.contains("Headache") &&
        selectedSymptoms.contains("Dizziness")) {
      result = "Hypertension";
    } else if (selectedSymptoms.contains("Itching") ||
        selectedSymptoms.contains("Sneezing")) {
      result = "Allergy";
    }

    setState(() {
      predictedDisease = result;
      aboutDisease = diseaseInfo[result]!["about"]!;
      precautions = diseaseInfo[result]!["precautions"]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B6B4F),
        title: const Text("Disease Prediction",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Your Symptoms",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text("Select all symptoms you are feeling",
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            // Symptoms List
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: allSymptoms.map((symptom) {
                  bool isSelected = selectedSymptoms.contains(symptom);
                  return CheckboxListTile(
                    title: Text(symptom),
                    value: isSelected,
                    activeColor: const Color(0xFF0B6B4F),
                    onChanged: (val) {
                      setState(() {
                        if (val == true) {
                          selectedSymptoms.add(symptom);
                        } else {
                          selectedSymptoms.remove(symptom);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: predictDisease,
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B6B4F),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: const Text("Predict Disease",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 20),
            // Result Card
            if (predictedDisease.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 4))
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Predicted: $predictedDisease",
                        style: const TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    const Text("About Disease:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(aboutDisease, style: const TextStyle(fontSize: 15)),
                    const SizedBox(height: 14),
                    const Text("Precautions:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(precautions, style: const TextStyle(fontSize: 15)),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                          "Note: This is only a prediction. Please consult a doctor for correct diagnosis.",
                          style: TextStyle(
                              fontSize: 13, color: Colors.orange)),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}