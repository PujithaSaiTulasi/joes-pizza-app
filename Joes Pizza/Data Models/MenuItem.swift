import Foundation

struct MenuItem {
    var id: Int!
    var name: String!
    var basePrice: Double!
    var category: String!
    var description: String!
    var availability: Bool!
    var image: String!
    var pricePerTopping: [Int]?
    var maxToppings: Int?
    
    init(id: Int, name: String, basePrice: Double, category: String, description: String, availability: Bool, image: String, pricePerTopping: [Int]? = nil, maxToppings: Int? = nil) {
        self.id = id
        self.name = name
        self.basePrice = basePrice
        self.category = category
        self.description = description
        self.availability = availability
        self.image = image
        self.pricePerTopping = pricePerTopping
        self.maxToppings = maxToppings
    }
}

