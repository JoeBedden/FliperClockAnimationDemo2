//
//  ContentView.swift
//  FlipClockAnimationDemo 2
//
//  Created by 雷子康 on 2023/7/13.
//

import SwiftUI


struct ContentView: View {
    @State var start = false
    @State var end = false
    @State var num = 9
    @State var num2 = 9
    @State var num3 = 9
    @State var num4 = 9
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
            ZStack{
            Color.black
          
                //
                ZStack{
                    RoundedRec()
                    number(num: num)
                    
                    //=============================================================================
                    ZStack{
                        RoundedRec( )
                        number(num: num2)
                    }
                    .mask { //设置遮罩
                        RoundedRec(height: 120)
                            .offset(y: -60)
                    }
                    //定义翻转动画
                    .rotation3DEffect(.degrees(start ? 90 : 0), axis: (x: -1, y: 0, z: 0), anchor: .center, anchorZ: 0, perspective: 0.5)
                    
                    //==============================================================================
                    
                    ZStack{
                        RoundedRec( )
                        number(num: num3)
                    }
                    .mask { //设置遮罩
                        RoundedRec(height: 120)
                            .offset(y: 60)
                    }
                    
                    //===============================================================================
                    
                    ZStack{
                        RoundedRec( )
                        number(num: num4)
                    }
                    .mask { //设置遮罩
                        RoundedRec(height: 120)
                            .offset(y: 60)
                    }
                    //定义翻转动画
                    .rotation3DEffect(.degrees(end ? 0 : 90), axis: (x: 1, y: 0, z: 0), anchor: .center, anchorZ: 0, perspective: 0.5)
                }
                .overlay(content: {
                    Rectangle().frame(height: 3)
                        .offset(y: 1.5)
                })
                //==============================================================================================
                
                .onReceive(timer) { _ in
                    if num > 0{
                        num -= 1
                        //=====================================================
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9){
                            num3 -= 1
                        }
                        withAnimation(.spring().speed(3)){
                            start.toggle()
                        }
                        //=====================================================
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
                            start = false
                        }
                        //=====================================================
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            num2 -= 1
                        }
                        //=====================================================
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                            num4 -= 1
                        }
                        //=====================================================
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                            withAnimation(.spring().speed(3)){
                                end = true
                            }
                        }
                        //=====================================================
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            end = false
                        }
                    }
                }
            }
            .ignoresSafeArea()
            }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//控制圆角矩形内部的函数
struct RoundedRec: View {
    var width:CGFloat = 160
    var height:CGFloat = 180
    var body: some View {
        RoundedRectangle(cornerRadius: 10, style: .continuous)
            .frame(width: width, height: height)
//            .foregroundColor(Color("fc"))
            .foregroundColor(Color("fc"))
    }
    
}

//显示的数字
struct number: View {
    var num = 0
    var body: some View {
        Text("\(num)").font(.system(size: 180))
            .foregroundColor(.white)
    }
}
