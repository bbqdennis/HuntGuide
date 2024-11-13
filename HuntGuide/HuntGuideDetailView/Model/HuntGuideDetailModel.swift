//
//  HuntGuideDetailModel.swift
//  HuntGuide
//
//  Created by Dennis Cheng on 12/11/2024.
//

import Foundation

struct HuntGuideDetailModel {
    let subject: String
    let topic: String
    let description: String
    let image: String

    static func loadFromJSON(_ json: String) -> [HuntGuideDetailModel]? {
        let data = json.data(using: .utf8)!
        do {
            let decoder = JSONDecoder()
            let models = try decoder.decode([HuntGuideDetailModel].self, from: data)
            return models
        } catch {
            print("Failed to decode JSON: \(error)")
            return nil
        }
    }
}

extension HuntGuideDetailModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case subject, topic, description, image
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.subject = try container.decode(String.self, forKey: .subject)
        self.topic = try container.decode(String.self, forKey: .topic)
        self.description = try container.decode(String.self, forKey: .description)
        self.image = try container.decode(String.self, forKey: .image)
    }
    
    static func loadFromBundle() -> [HuntGuideDetailModel]? {
        // Retrieve the device's current language code
        let languageCode = Locale.current.languageCode ?? "en"
        NSLog("Locale.current.languageCode \(Locale.current.languageCode)")
        
        // Attempt to load the language-specific JSON file, e.g., "huntguide_en.json"
        let filename = "huntguide_\(languageCode)"
        
        // Attempt to find the localized JSON file first
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                // Load and decode data from the localized JSON file
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let models = try decoder.decode([HuntGuideDetailModel].self, from: data)
                return models
            } catch {
                print("Failed to decode localized JSON (\(filename).json): \(error)")
            }
        }

        // Fallback to default "huntguide.json" if localized version is unavailable
        if let url = Bundle.main.url(forResource: "huntguide", withExtension: "json") {
            do {
                // Load and decode data from the default JSON file
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let models = try decoder.decode([HuntGuideDetailModel].self, from: data)
                return models
            } catch {
                print("Failed to decode default JSON (huntguide.json): \(error)")
            }
        }

        // Return nil if both attempts failed
        print("Could not find or decode any JSON file.")
        return nil
    }
}

