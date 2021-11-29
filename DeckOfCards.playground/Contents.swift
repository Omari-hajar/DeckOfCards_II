import UIKit
import CoreGraphics

//I have no clue what I am doing or if I done it correctly. And advice or directions you might have would be greatly appreciated.

// Card Struct
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
/// Deck Class
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


//var cards = Deck()
//
//for i in 0..<cards.cards.count{
//    print(cards.cards[i])
//}
//
//print("=============================Remove===============================")
//let remove = cards.removeTopMost()
//print(remove)
//
//
//print("=============================Shuffle===============================")
//
//let shuffle = cards.shuffleCards()
//for i in 0..<shuffle.count{
//    print(shuffle[i])
//}

///create a player class
class Player{
    var playerName: String
    var playerHand: [Card]
    var playerCoins: Int

    
    init(name: String){
        self.playerName = name
        playerHand = [Card]()
        playerCoins = 0
    }
    
    func getHand(deck: Deck) -> Card{
        let index: Int = Int.random(in: 0..<deck.cards.count)
        let card = deck.cards[index]
        //deck.cards.remove(at: index)
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


//var player = Player(name: "Jane")
//
//
//for _ in 0...20{
//    player.getHand(deck: Deck())
//}
//
//var playerHand = player.playerHand
//
//
//print("=============================Player Hand===============================")
//for i in 0..<playerHand.count{
//    print(playerHand[i])
//}
//
//var match = player.matchingCards(card: "Red", roll: 4)
//
//print("=============================Cards Count===============================")
//print("Cards count = \(match)")


// create a Game class

class Game{
    //A property called "players" of type [Player]
    //A property called "deck" of type Deck
    //A property called "turnIdx" of type Int
    
    var players: [Player] = [Player]()
    var deck: Deck
    var turnIdx: Int
    
    init(){
        //When initializing the Game, it should add 4 players named "Mike", "Sydney", "Blake", & "Tiffany" to the game and shuffle the deck
        
        players.append(Player(name: "Mike"))
        players.append(Player(name: "Sydney"))
        players.append(Player(name: "Blake"))
        players.append(Player(name: "Tiffany"))
        
        deck = Deck()
        deck.shuffleCards()
        
        turnIdx = 0
        
        for player in players{
            for _ in 1...3{
                player.getHand(deck: deck)
            }
        }
        
    }
    
    func playGame(){
        //Give the Game a playGame method that continues to call a TakeTurn method for each Player, until the deck is exhausted. From there is should call the AnnounceWinner Method
        if deck.checkIsEmpty(){
            announceWinner()
        } else{
            for player in players{
                takeTurn(currentPlayer: player)
                print("====== current Player is \(player.playerName) and coins = \(player.playerCoins) ========")
            }
        }
    }
    
    //The TakeTurn method is of type (Player) and will perform 5 operations
    func takeTurn(currentPlayer: Player){
        //The current player should roll the dice
        let diceRoll = currentPlayer.rollDice()
        
        print("Dice = \(diceRoll)")
        
        if diceRoll == 1 || diceRoll == 2{
            //All players that have a matching blue card then gain 1 coin per match
            for player in players{
                for card in player.playerHand{
                    if card.color == "Blue"{
                        player.playerCoins += 1
//                        print("\(player.playerName) coins = \(player.playerCoins)")
                    }
                }
            }
        } else if diceRoll == 3 || diceRoll == 4 {
            //Going in order the player, pays each player that has a matching red card, 1 coin per card red card, until all players have been dealt with, or the current player is out of coins
            for player in players {
                for card in player.playerHand{
                    if card.color == "Red"{
                        
                        if player.playerName != currentPlayer.playerName {
                            if currentPlayer.playerCoins > 0{
                            player.playerCoins += 1
                            currentPlayer.playerCoins -= 1
//                            print("\(player.playerName) coins = \(player.playerCoins)")
//                                print("\(currentPlayer.playerName) coins = \(currentPlayer.playerCoins)")
                                
                            } else{
                                print("\(currentPlayer.playerName) ran out of coins")
                            }
                        }
                    }
                }
            }
        } else if  diceRoll == 5 || diceRoll == 6  {
            //The player who rolled the dice will gain 2 coins per matching green card they have
            for card in currentPlayer.playerHand{
                if card.color == "Green"{
                    currentPlayer.playerCoins += 2
//                    print("\(currentPlayer.playerName) coins = \(currentPlayer.playerCoins)")
                }
            }
        }
       
        //Finally the current player draws a card from the deck
        
        currentPlayer.getHand(deck: deck)
        
        
    }
    
    func announceWinner(){
        //The AnnounceWinner() method will find the player with the most coins and print that player's name out as the winner
        var currentHighest: Int = 0
        var currentPlayer: String = ""
        for player in players{
            if currentHighest < player.playerCoins{
            currentHighest = player.playerCoins
            currentPlayer = player.playerName
            }
        }
        
        print("The Winner is \(currentPlayer):: Coins = \(currentHighest)")
    }
}



var game = Game()

for _ in 0...game.deck.cards.count{
    game.playGame()
}














