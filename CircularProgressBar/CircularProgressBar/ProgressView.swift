//
//  Progress.swift
//  CircularProgressBar
//
//  Created by Jonathan Ramirez on 05.04.20.
//  Copyright © 2020 Jonathan Ramirez. All rights reserved.
//

import SwiftUI


// Code from
//https://www.hackingwithswift.com/books/ios-swiftui/animating-simple-shapes-with-animatabledata


struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    //Set this propertie for our shape becaouse we want to animate.
    var animatableData: Angle.AnimatableData {
        get { endAngle.degrees }
        set { endAngle.degrees = newValue }
    }

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
}

struct ProgressView: View {
    @State var value: Double = 10.0
    var body: some View {
        ZStack {
            //set Color
            Color.blue
            // Set full Background Color
            .edgesIgnoringSafeArea(.all)
            
            //First full Circle
            Arc(startAngle: .degrees(0),
                endAngle: .degrees(360),
                clockwise: true)
                .stroke(Color.white, lineWidth: 5)
                .frame(width: 85, height: 85)
                .opacity(0.2)
                .animation(.easeInOut)
            //Second Circle w
            Arc(startAngle: .degrees(0),
                endAngle: .degrees( percentage() ),
                clockwise: true)
                .stroke(Color.white, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                
                .frame(width: 85, height: 85)
                .animation(.easeInOut)
            
            Button(action: {
              self.value +=  10
            }) {
              Text("+")
              .foregroundColor(.white)
              .font(.title)
            }
        }
    }
    
    func percentage() -> Double {
         return (360 / 100) * self.value
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
