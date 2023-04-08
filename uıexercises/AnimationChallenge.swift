//
//  AnimationChallenge.swift
//  uıexercises
//
//  Created by Kübra Cennet Yavaşoğlu on 8.04.2023.
//

import SwiftUI

struct AnimationChallenge: View {

    
    var body: some View {
        Home()
    }
}

struct AnimationChallenge_Previews: PreviewProvider {
    static var previews: some View {
        AnimationChallenge()
    }
}

struct Home: View {
    
    @State var offset: CGSize = .zero
    
    @State var showHome = false
    
    var body: some View {
        
       ZStack{
           
          Color("fk")
        
            .overlay(
            
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("For You")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Text("Running away from any problem only increases the distance from the solution. The easiest way to escape from the problem is to solve.")
                        .font(.caption)
                        .fontWeight(.bold)
                })
                .foregroundColor(.white)
                .padding(.horizontal, 30)
                .offset(x: -15)
                
                )
            .clipShape(LiquidSwipe(offset: offset))
            .ignoresSafeArea()
            .overlay(
                
              Image(systemName: "chevron.left")
                .font(.largeTitle)
                .frame(width: 50, height: 50)
                .contentShape(Rectangle())
                .gesture(DragGesture().onChanged({ (value) in
                    
                    withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)){
                        offset = value.translation
                  }
                }).onEnded({ (value) in
                    let screen = UIScreen.main.bounds
                    
                    withAnimation(.spring()){
                        
                        if -offset.width > screen.width / 2{
                            offset.width = -screen.height
                            showHome.toggle()
                        }
                        else{
                            offset = .zero
                    }
                }
            }))
                .offset(x: 15,y: 58)
                .opacity(offset == .zero ? 1 : 0)
              
              ,alignment: .topTrailing
            )
           
            .padding(.trailing)
               
           if showHome{
            //.background(.green)
            Text("Just do it!")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.purple)
                
                .onTapGesture {
                    withAnimation(.spring()) {
                        offset = .zero
                        showHome.toggle()
                    }
                }
            }
        }
    }
}
//Custon Shape
struct LiquidSwipe : Shape {
    
    var offset: CGSize
    
    var animatableData: CGSize.AnimatableData{
        get{return offset.animatableData}
        set{offset.animatableData = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            
            let width = rect.width + (-offset.width > 0 ? offset.width : 0)
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))

            let from = 80 + (offset.width)
            path.move(to: CGPoint(x: rect.width, y: from > 80 ? 80 : from))
            
            var to = 180 + (offset.height) + (-offset.width)
            to = to < 180 ? 180 : to
            
            let mid : CGFloat = 80 + ((to - 80) / 2)
            path.addCurve(to: CGPoint(x: rect.width, y: to), control1: CGPoint(x: width - 50, y: mid), control2: CGPoint(x: width - 50, y: mid))
        }
    }
}
