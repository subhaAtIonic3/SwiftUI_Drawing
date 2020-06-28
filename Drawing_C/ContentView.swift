//
//  ContentView.swift
//  Drawing_C
//
//  Created by Subhrajyoti Chakraborty on 28/06/20.
//  Copyright © 2020 Subhrajyoti Chakraborty. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var amount: CGFloat = 100.0
    @State private var thickness: CGFloat = 10.0
    @State private var hue = 0.6
    
    var body: some View {
        VStack {
            Arrow(distance: amount)
                .stroke(Color(hue: hue, saturation: 1, brightness: 1), style: StrokeStyle(lineWidth: thickness, lineCap: .round, lineJoin: .round))
                .onTapGesture {
                    withAnimation{
                        self.amount = CGFloat.random(in: 0.0...150.0)
                    }
                }
            .frame(width: 300, height: 400)
            .padding([.bottom])
            
            
            Group {
                Text("Thickness: \(thickness, specifier: "%.2f")")
                Slider(value: $thickness, in: 5...60, step: 1)
                
                Text("Colour")
                Slider(value: $hue)
            }
            .padding([.top, .horizontal])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Arrow: Shape {
    
    var distance: CGFloat
    
    var animatableData: CGFloat {
        get {distance}
        set {self.distance = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - distance, y: rect.midY))
        
        path.addLine(to: CGPoint(x: rect.maxX - distance, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - (distance / 2), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - (distance / 2), y: rect.midY))
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        
        
        return path
    }
}
