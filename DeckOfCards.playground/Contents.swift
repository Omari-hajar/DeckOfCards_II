import UIKit
import CoreGraphics

struct Card{
    var color: String
    var roll: Int
    
    init(color: String){
        self.color = color
       
        if color == "Blue"{
            self.roll = Int.random(in: 1...2)
        } else if color == "Red"{
            self.roll = Int.random(in: 3...4)
        }else{
            self.roll = Int.random(in: 4...6)
        }
    }
    
    
}


class Deck{
    var cards : [Card]
    
    init(){
        cards = [Card]()
        for _ in 1...10{
            self.cards.append(Card(color: "Blue"))
        }
        for _ in 1...10{
            self.cards.append(Card(color: "Red"))
        }
        for _ in 1...10{
            self.cards.append(Card(color: "Green"))
        }
    }
    
    func removeTopMost() -> Card{
        let removed = cards.removeLast()
        return removed
    }
    
    func checkIsEmpty() -> Bool{
        let check = cards.isEmpty
        
        return check
    }
    
    func shuffleCards() -> [Card]{
        let shuffled = cards.shuffled()
        return shuffled
    }

}




var cards = Deck()

for i in 0..<cards.cards.count{
    print(cards.cards[i])
}

print("=============================Remove===============================")
let remove = cards.removeTopMost()
print(remove)


print("=============================Shuffle===============================")

let shuffle = cards.shuffleCards()
for i in 0..<shuffle.count{
    print(shuffle[i])
}



///create a person class


class Person{
    var playerName: String
    var playerHand: [Card]

    
    init(name: String){
        self.playerName = name
        playerHand = [Card]()
    }
    
    func getHand(deck: Deck) -> Card{
        let index: Int = Int.random(in: 0..<deck.cards.count)
        let card = deck.cards[index]
        playerHand.append(card)
        return card
    }
    
    func rollDice() -> Int{
        let roll: Int = Int.random(in: 1...6)
        return roll
    }
    
    func matchingCards(card: String, roll: Int) -> Int{
        var count: Int = 0
        
        for i in 0..<playerHand.count{
            
            if playerHand[i].color == card && playerHand[i].roll == roll{
                count += 1
            }
        }
        return count
    }
}


var person = Person(name: "Jane")


for _ in 0...20{
    person.getHand(deck: Deck())
}

var playerHand = person.playerHand


print("=============================Player Hand===============================")
for i in 0..<playerHand.count{
    print(playerHand[i])
}

var match = person.matchingCards(card: "Red", roll: 4)

print("=============================Cards Count===============================")
print("Cards count = \(match)")

