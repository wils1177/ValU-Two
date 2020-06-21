//
//  SwiftUITestView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/9/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI


struct BudgetCardView: View {
    
    let budget : Budget
    var viewModel : BudgetsViewModel?
    
    var title: String
    var spent : String
    var remaining: String
    var percentage: Float
    var available : String
    var daysLeft : String?
    
    var good = ["🥳", "😎", "🙌", "💪", "🤩"]
    
    var bad = ["🙃", "💩", "👹", "😳"]
    
    var savingsGoal : String
    
    init(budget : Budget, viewModel: BudgetsViewModel? = nil){
        self.budget = budget
        self.title = CommonUtils.getMonthFromDate(date: self.budget.startDate!)
        self.spent = "$" + String(Int(self.budget.getAmountSpent()))
        self.remaining = CommonUtils.makeMoneyString(number: (Int(self.budget.getAmountAvailable() - self.budget.spent)))
        self.percentage = 1.0 - (self.budget.spent / self.budget.amount)
        self.available = "$" + String(Int(self.budget.getAmountAvailable()))
        self.savingsGoal = "$" + String(Int(self.budget.amount * self.budget.savingsPercent))
        self.daysLeft = getDaysLeftInMonth(date: Date())
        self.viewModel = viewModel
    }
    

    
    func getIcon() -> String{
        switch self.percentage{
        case 0.9..<1.0:
            return "😎"
        case 0.8..<0.9:
            return "🙌"
        case 0.7..<0.8:
            return "💪"
        case 0.6..<0.7:
            return "🤩"
        case 0.5..<0.6:
            return "🥳"
        case 0.4..<0.5:
            return "🙌"
        case 0.3..<0.4:
            return "🙃"
        case 0.2..<0.3:
            return "👹"
        case 0.1..<0.2:
            return "🙃"
        case 0.0..<0.1:
            return "💩"
        default:
            return "😎"
        }
    
    }
    
    func getDaysLeftInMonth(date: Date) -> String{
        let endOfMonth = date.endOfMonth!
        let diffInDays = Calendar.current.dateComponents([.day], from: date, to: endOfMonth).day
        
        return String(diffInDays!) + " Days Left"
        
    }
    
    func getPercentage() -> Float{
        if self.percentage >= 1.0{
            return  1.0
        }
        else if self.percentage == 0.0 {
            return  0.05
        }
        else{
            return self.percentage
        }
    }


    
    var textColor = Color(.black)
    
    var remainingText : some View{
        
        VStack(alignment: .center){
            Text("Remaining").foregroundColor(Color(.lightText)).bold()
            if remaining.count > 6{
                Text(self.remaining).font(.headline).foregroundColor(Color(.white)).bold()
            }
            else{
                Text(self.remaining).font(.title).foregroundColor(Color(.white)).bold()
            }
            //Text("of $5,0000").foregroundColor(Color(.lightText)).font(.caption).bold()
            
            
        }
        
    }
    

 
    var smallerCircle : some View {
        ZStack{
            remainingText
            Circle().fill(Color.clear).frame(width:140, height: 140)
                .overlay(Circle()
                        .rotation(Angle(degrees: -90))
                    .trim(from: CGFloat(0.0), to: CGFloat(1.0))
                    .stroke(style: StrokeStyle(lineWidth: CGFloat(11.0), lineCap: .round, lineJoin: .round))
                    .fill(Color(.lightText))
                        
                )
                .overlay(Circle()
                    .rotation(Angle(degrees: -90))
                    .trim(from: CGFloat(0.0), to: CGFloat(self.getPercentage()))
                    .stroke(style: StrokeStyle(lineWidth: CGFloat(11.0), lineCap: .round, lineJoin: .round))
                    .fill(Color(.white))
                
                    
            )

            
        }
    }
    
    
    
    

    

    var regular: some View{
        
        HStack{
            Spacer()
            VStack{
                VStack(alignment: .leading){
                    Text(self.title).font(.title).foregroundColor(Color(.white)).bold()
                    Text(self.daysLeft!).bold().foregroundColor(Color(.lightText))
                    Spacer()

                    Text("Total").foregroundColor(Color(.white)).bold()
                    Text(self.available).bold().foregroundColor(Color(.lightText))
                }.padding(.vertical, 3)
            }
            Spacer()
            smallerCircle
            Spacer()
        }.padding(.vertical, 30)
    }
    
    var new: some View{
        HStack{
            VStack(alignment: .leading){
                Text("Left to Spend").font(.system(size: 22)).foregroundColor(Color(.lightText)).bold().padding(.bottom, 4)
                HStack(alignment: .bottom, spacing: 0){
                    Text(self.remaining).font(.title).foregroundColor(Color(.white)).bold()
                    Text(" / " + self.available).font(.headline).foregroundColor(Color(.lightText)).padding(.bottom, 2)
                }
                
            }.padding(.leading, 20).padding(.vertical).padding(.vertical, 10)
            Spacer()
            VStack{
                
                Text(getIcon()).font(.system(size: 53)).padding(.trailing).padding(.trailing)
            }
            
        }
    }
    
    var partialCircle : some View{
        VStack{
            HStack{
                Spacer()
                Image(systemName: "ellipsis.circle.fill").font(.system(size: 26)).foregroundColor(Color(.white))
            }.padding(.horizontal, 5).padding(.top, 15).offset(y: 30)
            
            
            HStack{
                Spacer()
                ZStack{
                    
                    
                    
                    Circle().fill(Color.clear).frame(width:180, height: 180)
                        .overlay(Circle()
                                .rotation(Angle(degrees: -90))
                            .trim(from: CGFloat(0.0), to: CGFloat(1.0))
                            .stroke(style: StrokeStyle(lineWidth: CGFloat(11.0), lineCap: .round, lineJoin: .round))
                            .fill(Color(.clear))
                                
                        )
                        .overlay(Circle()
                            .rotation(Angle(degrees: 152))
                            .trim(from: CGFloat(0.0), to: 0.65)
                            .stroke(style: StrokeStyle(lineWidth: CGFloat(11.0), lineCap: .round, lineJoin: .round))
                            .fill(Color(.white))
                        
                            
                    )
                    
                    VStack(alignment: .center){
                        
                        if remaining.count > 6{
                            Text("$500").font(.system(size: 34)).foregroundColor(Color(.white)).bold()
                        }
                        else{
                            Text(self.remaining).font(.title).foregroundColor(Color(.white)).bold()
                        }
                        Text("Left To Spend").foregroundColor(Color(.lightText)).bold().offset(y: 40)
                        //Text("of $5,0000").foregroundColor(Color(.lightText)).font(.caption).bold()
                        
                        
                    }
                    
                }.offset(y: 10).padding(.bottom, 20)
                
                Spacer()
            }
            
        }
        
        

        
    }
    

    
    var body: some View {
        
        //detailedView
           //coolCircle
        //option2
        
        //megaCircle.padding(.bottom)
            
        new
        //regular
        //partialCircle.padding().frame(height: 200).clipped()
        //textOnly
        //TextAndBar.padding()
        
    }
}

/*
#if DEBUG
struct BudgetCardView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetCardView(viewData: BudgetCardViewData(remaining: "500", spent: "500", percentage: CGFloat(0.5)))
    }
}
#endif
*/


