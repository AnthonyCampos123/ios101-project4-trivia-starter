//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Anthony Campos on 10/12/23.
//

import Foundation

class TriviaQuestionService {
    static let shared = TriviaQuestionService()
    
    struct TriviaResponse: Codable {
        let response_code: Int
        let results: [TriviaQuestion]
    }
    
    struct TriviaQuestion: Codable {
        let category: String
        let type: String
        let difficulty: String
        let question: String
        let correct_answer: String
        let incorrect_answers: [String]
    }
    
    private init() { }
    
    func fetchTriviaQuestions(completion: @escaping ([TriviaQuestion]?, Error?) -> Void) {
        if let jsonData = """
            {
                "response_code": 0,
                "results": [
                    {
                        "category": "Entertainment: Music",
                        "type": "boolean",
                        "difficulty": "medium",
                        "question": "Arcade Fire&#039;s &#039;The Suburbs&#039; won the Album of the Year award in the 2011 Grammys.",
                        "correct_answer": "True",
                        "incorrect_answers": [
                            "False"
                        ]
                    },
                    {
                        "category": "Entertainment: Film",
                        "type": "boolean",
                        "difficulty": "easy",
                        "question": "The 2010 film &quot;The Social Network&quot; is a biographical drama film about MySpace founder Tom Anderson.",
                        "correct_answer": "False",
                        "incorrect_answers": [
                            "True"
                        ]
                    },
                    {
                        "category": "History",
                        "type": "multiple",
                        "difficulty": "easy",
                        "question": "Which of the following ancient peoples was NOT classified as Hellenic (Greek)?",
                        "correct_answer": "Illyrians",
                        "incorrect_answers": [
                            "Dorians",
                            "Achaeans",
                            "Ionians"
                        ]
                    },
                    {
                        "category": "Art",
                        "type": "multiple",
                        "difficulty": "hard",
                        "question": "Albrecht D&uuml;rer&#039;s birthplace and place of death were in...",
                        "correct_answer": "N&uuml;rnberg",
                        "incorrect_answers": [
                            "Augsburg",
                            "Bamberg",
                            "Berlin"
                        ]
                    },
                    {
                        "category": "Entertainment: Video Games",
                        "type": "boolean",
                        "difficulty": "medium",
                        "question": "Metal Gear Solid V: The Phantom Pain runs on the Fox Engine.",
                        "correct_answer": "True",
                        "incorrect_answers": [
                            "False"
                        ]
                    },
                    {
                        "category": "Entertainment: Video Games",
                        "type": "multiple",
                        "difficulty": "easy",
                        "question": "When was the game &#039;Portal 2&#039; released?",
                        "correct_answer": "2011",
                        "incorrect_answers": [
                            "2014",
                            "2009",
                            "2007"
                        ]
                    },
                    {
                        "category": "Entertainment: Film",
                        "type": "multiple",
                        "difficulty": "medium",
                        "question": "Which movie of film director Stanley Kubrick is known to be an adaptation of a Stephen King novel?",
                        "correct_answer": "The Shining",
                        "incorrect_answers": [
                            "2001: A Space Odyssey",
                            " Dr. Strangelove ",
                            "Eyes Wide Shut"
                        ]
                    },
                    {
                        "category": "Entertainment: Comics",
                        "type": "boolean",
                        "difficulty": "medium",
                        "question": "In the webcomic Homestuck, the first character introduced is Dave Strider.",
                        "correct_answer": "False",
                        "incorrect_answers": [
                            "True"
                        ]
                    },
                    {
                        "category": "History",
                        "type": "multiple",
                        "difficulty": "medium",
                        "question": "In which year was Constantinople conquered by the Turks?",
                        "correct_answer": "1453",
                        "incorrect_answers": [
                            "1435",
                            "1454",
                            "1440"
                        ]
                    },
                    {
                        "category": "Entertainment: Japanese Anime & Manga",
                        "type": "multiple",
                        "difficulty": "hard",
                        "question": "Which animation studio produced &quot;Log Horizon&quot;?",
                        "correct_answer": "Satelite",
                        "incorrect_answers": [
                            "Sunrise",
                            "Xebec",
                            "Production I.G"
                        ]
                    },
                    {
                        "category": "Geography",
                        "type": "multiple",
                        "difficulty": "medium",
                        "question": "Frankenmuth, a US city nicknamed &quot;Little Bavaria&quot;, is located in what state?",
                        "correct_answer": "Michigan",
                        "incorrect_answers": [
                            "Pennsylvania",
                            "Kentucky",
                            "Virginia"
                        ]
                    },
                    {
                        "category": "Entertainment: Video Games",
                        "type": "multiple",
                        "difficulty": "hard",
                        "question": "Which occupation did John Tanner, the main protagonist for Driver and Driver 2, had before turning into an undercover cop?",
                        "correct_answer": "Racing Driver",
                        "incorrect_answers": [
                            "Taxi Driver",
                            "Delivery Driver",
                            "Getaway Driver"
                        ]
                    },
                    {
                        "category": "Sports",
                        "type": "multiple",
                        "difficulty": "medium",
                        "question": "What is Tiger Woods&#039; all-time best career golf-score?",
                        "correct_answer": "61",
                        "incorrect_answers": [
                            "65",
                            "63",
                            "67"
                        ]
                    },
                    {
                        "category": "Science: Computers",
                        "type": "multiple",
                        "difficulty": "hard",
                        "question": "Which of the following computer components can be built using only NAND gates?",
                        "correct_answer": "ALU",
                        "incorrect_answers": [
                            "CPU",
                            "RAM",
                            "Register"
                        ]
                    },
                    {
                        "category": "Entertainment: Film",
                        "type": "multiple",
                        "difficulty": "medium",
                        "question": "What is the name of the foley artist who designed the famous sounds of Star Wars, including Chewbacca&#039;s roar and R2-D2&#039;s beeps and whistles?",
                        "correct_answer": "Ben Burtt",
                        "incorrect_answers": [
                            "Ken Burns",
                            "Ralph McQuarrie",
                            "Miranda Keyes"
                        ]
                    }
                ]
            }
            """
            .data(using: .utf8) {
            do {
                let triviaResponse = try JSONDecoder().decode(TriviaResponse.self, from: jsonData)
                var questions = triviaResponse.results
                
                // Shuffle the questions
                questions.shuffle()
                
                // Limit to 5 random questions
                if questions.count > 5 {
                    questions = Array(questions.prefix(5))
                }
                
                completion(questions, nil)
            } catch {
                completion(nil, error)
            }
        } else {
            // Handle data encoding error
            completion(nil, NSError(domain: "TriviaErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data encoding error"]))
        }
    }
}
