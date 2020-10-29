//
//  SubscriptionModel.swift
//  PeliculasApp
//
//  Created by michcode on 10/28/20.
//

import Foundation

struct SubscriptionModel: Decodable {
    let subscriptionName: String
    let subscriptionId: String
    let isSubscriptionActive: Bool
    
    enum CodingKeys: String, CodingKey {
        case subscriptionName = "subscription_name"
        case subscriptionId = "subscription_id"
        case isSubscriptionActive = "is_active"
    }
}
