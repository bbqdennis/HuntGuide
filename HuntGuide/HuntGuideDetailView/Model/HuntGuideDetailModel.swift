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
            // load from Bundle
            guard let url = Bundle.main.url(forResource: "huntguide", withExtension: "json") else {
                print("Could not find huntguide.json in bundle.")
                return nil
            }
            
            do {
                // loading data
                let data = try Data(contentsOf: url)
                // use JSONDecoder decode
                let decoder = JSONDecoder()
                let models = try decoder.decode([HuntGuideDetailModel].self, from: data)
                return models
            } catch {
                print("Failed to decode JSON: \(error)")
                return nil
            }
        }
}
