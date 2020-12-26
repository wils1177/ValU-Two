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
    var viewModel : BudgetsViewModel
    
    var title: String
    var spent : String
    var remaining: String
    var percentage: Float
    var available : String
    var daysLeft : String?
    
    
    var savingsGoal : String
    
    init(budget : Budget, viewModel: BudgetsViewModel){
        self.budget = budget
        self.viewModel = viewModel
        self.title = CommonUtils.getMonthFromDate(date: self.budget.startDate!)
        self.spent = CommonUtils.makeMoneyString(number: Int(self.budget.getAmountSpent()))
        self.remaining = CommonUtils.makeMoneyString(number:  self.viewModel.getRemaining())
        self.percentage = 1.0 - (self.budget.spent / self.budget.amount)
        self.available = CommonUtils.makeMoneyString(number:(Int(self.budget.getAmountAvailable())))
        self.savingsGoal = "$" + String(Int(self.budget.amount * self.budget.savingsPercent))
        self.daysLeft = getDaysLeftInMonth(date: Date())
        
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
        VStack(spacing: 8){
            HStack{
                

                HStack{
                    Image(systemName: "calendar").foregroundColor(Color(.black))
                    Text("17 Days Left in Budget").foregroundColor(Color(.black)).font(.system(size: 16)).bold()
                }
                Spacer()
            }.padding(.horizontal, 20)//.background(AppTheme().themeColorSecondary)
            HStack{
                    
                    HStack(alignment: .bottom, spacing: 0){
                        Text(self.spent).font(.system(size: 44, design: .rounded)).foregroundColor(Color(.black)).bold()
                        Text("  of " + self.available).font(.system(size: 24, design: .rounded)).foregroundColor(Color(.gray)).padding(.bottom, 4)
                    }

                
                Spacer()
            }.padding(.leading, 20)
            
            BudgetStatusBarView(viewData: self.viewModel.getBudgetStatusBarViewData()).padding(.bottom)//.padding(.top, 5)
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


