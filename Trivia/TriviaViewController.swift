//
//  ViewController.swift
//  Trivia
//
//  Created by Mari Batilando on 4/6/23.
//

import UIKit

extension String {
    var htmlDecoded: String {
        let encodedData = self.data(using: .utf8)!
        let attributedOptions: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        if let attributedString = try? NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil) {
            return attributedString.string
        } else {
            return self
        }
    }
}

class TriviaViewController: UIViewController {
  
  @IBOutlet weak var currentQuestionNumberLabel: UILabel!
  @IBOutlet weak var questionContainerView: UIView!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var answerButton0: UIButton!
  @IBOutlet weak var answerButton1: UIButton!
  @IBOutlet weak var answerButton2: UIButton!
  @IBOutlet weak var answerButton3: UIButton!
  
  private var allQuestions = [TriviaQuestionService.TriviaQuestion]()
  private var questions = [TriviaQuestionService.TriviaQuestion]()
  private var currQuestionIndex = 0
  private var numCorrectQuestions = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addGradient()
    questionContainerView.layer.cornerRadius = 8.0
    // TODO: FETCH TRIVIA QUESTIONS HERE
    let jsonQuestions = """
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
    
    
      // Convert the JSON string to data
              if let jsonData = jsonQuestions.data(using: .utf8) {
                  do {
                      let triviaResponse = try JSONDecoder().decode(TriviaQuestionService.TriviaResponse.self, from: jsonData)
                      allQuestions = triviaResponse.results
                      restartGame()
                      self.questions = questions.map { question in
                          // Decode HTML entities in the question and answers
                          let decodedQuestion = question.question.htmlDecoded
                          let decodedCorrectAnswer = question.correct_answer.htmlDecoded
                          let decodedIncorrectAnswers = question.incorrect_answers.map { $0.htmlDecoded }
                          return TriviaQuestionService.TriviaQuestion(
                              category: question.category,
                              type: question.type,
                              difficulty: question.difficulty,
                              question: decodedQuestion,
                              correct_answer: decodedCorrectAnswer,
                              incorrect_answers: decodedIncorrectAnswers
                          )
                      }
                      
                      self.updateQuestion(withQuestionIndex: self.currQuestionIndex)
                  } catch {
                      // Handle the error
                      print("Error decoding JSON: \(error)")
                  }
              }
          }
    private func decodeQuestionsAndAnswers() {
        questions = allQuestions.shuffled().prefix(10).map { question in
            let decodedQuestion = question.question.htmlDecoded
            let decodedCorrectAnswer = question.correct_answer.htmlDecoded
            let decodedIncorrectAnswers = question.incorrect_answers.map { $0.htmlDecoded }
            return TriviaQuestionService.TriviaQuestion(
                category: question.category,
                type: question.type,
                difficulty: question.difficulty,
                question: decodedQuestion,
                correct_answer: decodedCorrectAnswer,
                incorrect_answers: decodedIncorrectAnswers
            )
        }
        currQuestionIndex = 0
        numCorrectQuestions = 0
        updateQuestion(withQuestionIndex: currQuestionIndex)
    }
    
    
  private func updateQuestion(withQuestionIndex questionIndex: Int) {
    currentQuestionNumberLabel.text = "Question: \(questionIndex + 1)/\(questions.count)"
    let question = questions[questionIndex]
    questionLabel.text = question.question
    categoryLabel.text = question.category
      
      
      // Check the type of the question and show/hide buttons accordingly
          if question.type == "boolean" {
              answerButton0.setTitle("True", for: .normal)
              answerButton1.setTitle("False", for: .normal)
              answerButton2.isHidden = true
              answerButton3.isHidden = true
          } else {
              let answers = ([question.correct_answer] + question.incorrect_answers).shuffled()
              if answers.count > 0 {
                  answerButton0.setTitle(answers[0], for: .normal)
              }
              if answers.count > 1 {
                  answerButton1.setTitle(answers[1], for: .normal)
                  answerButton1.isHidden = false
              }
              if answers.count > 2 {
                  answerButton2.setTitle(answers[2], for: .normal)
                  answerButton2.isHidden = false
              }
              if answers.count > 3 {
                  answerButton3.setTitle(answers[3], for: .normal)
                  answerButton3.isHidden = false
              }
          }
    
    
    
    // Access the correctAnswer and incorrectAnswers within the question object
    let answers = ([question.correct_answer] + question.incorrect_answers).shuffled()

    if answers.count > 0 {
      answerButton0.setTitle(answers[0], for: .normal)
    }
    if answers.count > 1 {
      answerButton1.setTitle(answers[1], for: .normal)
      answerButton1.isHidden = false
    }
    if answers.count > 2 {
      answerButton2.setTitle(answers[2], for: .normal)
      answerButton2.isHidden = false
    }
    if answers.count > 3 {
      answerButton3.setTitle(answers[3], for: .normal)
      answerButton3.isHidden = false
    }
  }
  

    
  private func updateToNextQuestion(answer: String) {
    if isCorrectAnswer(answer) {
      numCorrectQuestions += 1
    }
    currQuestionIndex += 1
    guard currQuestionIndex < questions.count else {
      showFinalScore()
      return
    }
    updateQuestion(withQuestionIndex: currQuestionIndex)
  }
  
  private func isCorrectAnswer(_ answer: String) -> Bool {
    return answer == questions[currQuestionIndex].correct_answer
  }
  
    private func resetGame() {
        decodeQuestionsAndAnswers()
    }

    private func showFinalScore() {
        let alertController = UIAlertController(title: "Game over!",
                                                message: "Final score: \(numCorrectQuestions)/\(questions.count)",
                                                preferredStyle: .alert)
        let resetAction = UIAlertAction(title: "Restart", style: .default) { [unowned self] _ in
            resetGame()
        }
        alertController.addAction(resetAction)
        present(alertController, animated: true, completion: nil)
    }
  
    private func restartGame() {
       // Shuffle and limit the questions to 5
       questions = allQuestions.shuffled().prefix(10).map { $0 }
       currQuestionIndex = 0
       numCorrectQuestions = 0
       updateQuestion(withQuestionIndex: currQuestionIndex)
     }
    
  
  private func addGradient() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.bounds
    gradientLayer.colors = [UIColor(red: 0.54, green: 0.88, blue: 0.99, alpha: 1.00).cgColor,
                            UIColor(red: 0.51, green: 0.81, blue: 0.97, alpha: 1.00).cgColor]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    view.layer.insertSublayer(gradientLayer, at: 0)
  }
  
  @IBAction func didTapAnswerButton0(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton1(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton2(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton3(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
}
