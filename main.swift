//
//  ContentView.swift
//  tic tac toe
//
//  Created by chanda Rohit on 16/06/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            
            NavigationView{
                Home()
                    .navigationTitle("TIC TAC TOE")
                    .preferredColorScheme(.dark)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}
struct Home : View {
    //moves
    @State var moves :[String] = Array(repeating: "", count: 9)
    //which player is playing
    @State var isPlaying = true
    @State var gameOver = false
    @State var msg = ""
    var body : some View{
        
        VStack{
            
            LazyVGrid(columns: Array(repeating: GridItem(. flexible(), spacing: 15),count: 3), spacing: 15){
                
                ForEach(0..<9,id: \.self){index in
                    
                    
                    ZStack{
                        
                        // flip animation
                        Color.blue
                        
                    
                    Color.white
                        
                        .opacity(moves[index] == "" ? 1 : 0)
                    Text(moves[index])
                            .font(.system(size: 55))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .opacity(moves[index] != "" ? 1 : 0)
                }
                    .frame(width: getWidth() , height: getWidth())
                    .cornerRadius(15)
                    .rotation3DEffect(
                        .init(degrees: moves[index] != "" ? 180 : 0),
                        axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/,
                        anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
                        anchorZ: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/,
                        perspective: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/
                    )
                    // whenever tapped adding move
                    .onTapGesture (perform:  {
                        withAnimation(Animation.easeIn(duration: 0.3)){
                            if moves[index] == "" {
                            moves[index] = isPlaying ? "X" : "0"
                            //updating player
                            isPlaying.toggle()
                            }
                        }
                    })
                         
                    
                 }
             }
            .padding(15)
         }
        .onChange(of: moves, perform: { value in
            
            checkWinner()
        })
        .alert(isPresented: $gameOver, content: {
            
        
            Alert(title: Text("Winner"), message: Text(msg), dismissButton: .destructive(Text("PlayAgain"), action: {
                //resetting all the data
                withAnimation(Animation.easeIn(duration: 0.3)){
                    
                    moves.removeAll()
                    moves = Array(repeating: "", count: 9)
                    isPlaying = true
                }
            }) )
        })
    }
    func getWidth()->CGFloat{
        
        let width = UIScreen.main.bounds.width - (30 + 30)
        
        return width / 3
    }
    func checkWinner(){
                if checkMoves(player: "X"){
                    //promote alert moves..
                    msg = " PLAYER X WON !!! "
                    gameOver.toggle()
                    
                }
               else if checkMoves(player: "0"){
                    msg = " PLAYER 0 WON !!! "
                    gameOver.toggle()
                    
                }
         
               else{
                //checking for no moves
                
                let status = moves.contains { (value) -> Bool in
                    
                    return value == ""
                }
                if !status{
                    msg = "Game Over Tied !!!"
                    gameOver.toggle()
                }
            }
        }
    
    
    
    
    
    
    //horizontal moves
    
            func checkMoves(player: String)->Bool{
                //horizontal moves
                for i in  stride(from: 0, to: 9, by: 3){
                    if moves[i] == player && moves[i + 1] == player && moves[i + 2] == player{
                    return true
                }
            }
                
                
    //vertical moves
                
                
                for i in 0...2{
                    if moves[i] == player && moves[i + 3] == player && moves[i + 6] == player{
                    return true
                }
            }
                
    // checking diagonal
                
                
            if moves[0] == player && moves[4] == player && moves[8] == player{
                    return true
                
            }
                
            if moves[2] == player && moves[4] == player && moves[6 ] == player{
                        return true
                    
                }
             
                
                
                return false
            }
}
