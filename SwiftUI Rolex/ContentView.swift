//
//  ContentView.swift
//  SwiftUI Rolex
//
//  Created by John James Retina on 5/7/20.
//  Copyright © 2020 John James. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State var currentDate = Date()
  @State var hour = 0.0
  @State var minute = 0.0
  @State var second = 0.0
  @State var components = Calendar.current.dateComponents([.hour, .minute, .second], from: Date())
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
   
  var body: some View {
    GeometryReader { geometry in
      VStack{
        HStack{
          Text("Hrs \(Int(self.hour))")
          Text("Mins \(Int(self.minute))")
          Text("Secs \(Int(self.second))")
        }
        .padding([.bottom])
        ZStack{
          Image("WatchBody")
            .resizable()
            .scaleEffect(1.6)
          Image("SubMarinerFace")
            .resizable()
          Image("HourHand")
            .resizable()
            .rotationEffect(.radians(hourAngle(hrs: self.hour  ,
                                               mins: self.minute,
                                               secs: self.second )))
          Image("MinuteHand")
            .resizable()
            .rotationEffect(.radians(minuteAngle(mins: self.minute, secs: self.second)))
          Image("SecondHand")
            .resizable()
            .rotationEffect(.radians(Double(self.second) / 60 * .pi * 2 ))

        }
          .padding(50)
        .frame(width: min(geometry.size.width, geometry.size.height), height: min(geometry.size.width, geometry.size.height), alignment: .center)
      }
      .onReceive(self.timer) { input in
        self.currentDate = input
        self.setTime()
      }
      .onAppear{
        self.setTime()
      }
    }
  }
  func setTime()  {
    self.components = Calendar.current.dateComponents([.hour, .minute, .second], from: Date())
    self.hour = Double(self.components.hour ?? Int(0.0))
    self.minute = Double(self.components.minute ?? Int(0.0))
    self.second = Double(self.components.second ?? Int(0.0))
  }
}

func hourAngle(hrs: Double, mins : Double, secs : Double) -> Double {
  let hourDecimal = hrs + (mins / 60) + (secs / 3600)
  return hourDecimal / 12 * .pi * 2
}

func minuteAngle(mins : Double, secs : Double) -> Double {
  let minDecimal = mins + (secs / 60)
  return minDecimal / 60 * .pi * 2
}
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
