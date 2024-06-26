//
//  QuizModelData.swift
//  Cendekiawan
//
//  Created by Roland Ramadan on 23/06/24.
//

import Foundation

@Observable
class QuizModelData {
    var idePokokKelas4: [QuizMultiChoice] = load("PilganIdePokok4.json")
    var idePokokKelas5: [QuizMultiChoice] = load("PilganIdePokok5.json")
    var idePokokKelas6: [QuizMultiChoice] = load("PilganIdePokok6.json")
    
    var implisitKelas4: [QuizMultiChoice] = load("PilganImplisit4.json")
    var implisitKelas5: [QuizMultiChoice] = load("PilganImplisit5.json")
    var implisitKelas6: [QuizMultiChoice] = load("PilganImplisit6.json")
    
    var rumpang4: [QuizFillBlank] = load("Rumpang4.json")
    var rumpang5: [QuizFillBlank] = load("Rumpang5.json")
    var rumpang6: [QuizFillBlank] = load("Rumpang6.json")
    
    var sambung4: [QuizConnect] = load("SambungKata4.json")
    var sambung5: [QuizConnect] = load("SambungKata5.json")
    var sambung6: [QuizConnect] = load("SambungKata6.json")
    
    var wordle4: [QuizWordBlank] = load("Wordle4.json")
    var wordle5: [QuizWordBlank] = load("Wordle5.json")
    var wordle6: [QuizWordBlank] = load("Wordle6.json")
    
    func getIdePokok(difficulty: Int) -> [QuizMultiChoice]?{
        switch difficulty{
        case 4:
            return idePokokKelas4
        case 5:
            return idePokokKelas5
        case 6:
            return idePokokKelas6
        default:
            return nil
        }
    }
    
    func getimplisit(difficulty: Int) -> [QuizMultiChoice]?{
        switch difficulty{
        case 4:
            return implisitKelas4
        case 5:
            return implisitKelas5
        case 6:
            return implisitKelas6
        default:
            return nil
        }
    }
    
    func getRumpang(difficulty: Int) -> [QuizFillBlank]?{
        switch difficulty{
        case 4:
            return rumpang4
        case 5:
            return rumpang5
        case 6:
            return rumpang6
        default:
            return nil
        }
    }
    
    func getSambung(difficulty: Int) -> [QuizConnect]?{
        switch difficulty{
        case 4:
            return sambung4
        case 5:
            return sambung5
        case 6:
            return sambung6
        default:
            return nil
        }
    }
    
    func getWordle(difficulty: Int) -> [QuizWordBlank]?{
        switch difficulty{
        case 4:
            return load("Wordle4.json")
        case 5:
            return load("Wordle5.json")
        case 6:
            return load("Wordle6.json")
        default:
            return nil
        }
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func getRandomizedProficiency(_ proficiency: ProficiencyLevelStorage) -> (String, String) {
    let weightedValues = [
        (value: "idePokok", weight: 20 - proficiency.idePokok),
        (value: "kosakata", weight: 20 - proficiency.kosakata),
        (value: "implisit", weight: 20 - proficiency.implisit)
    ]
    
    let totalWeight = weightedValues.reduce(0) { $0 + $1.weight }
    let randomValue = Int.random(in: 0..<totalWeight)
    
    var cumulativeWeight = 0
    for weightedValue in weightedValues {
        cumulativeWeight += weightedValue.weight
        if randomValue < cumulativeWeight {
            return weightedValue.value == "kosakata" ? (getRandomizeKosakataQuestion(), weightedValue.value) : ("MultiChoice", weightedValue.value)
        }
    }
    
    return ("idePokok", weightedValues[0].value)
}

func getRandomizeKosakataQuestion() -> String {
    let options = ["FillBlank", "Connect", "WordBlank"]
    
    return options.randomElement()!
}
