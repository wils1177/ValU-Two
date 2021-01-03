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
        self.spent = CommonUtils.makeMoneyString(number: Int(self.viewModel.budgetTransactionsService.getBudgetExpenses()))
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

    
    var new: some View{
        VStack(spacing: 2){
            HStack{
                //.padding(.vertical, 3).padding(.horizontal).background(AppTheme().themeColorPrimary).cornerRadius(20)
 
                Spacer()
            }.padding(.horizontal, 20)//.background(AppTheme().themeColorSecondary)
            
            
        
            HStack{
                    
                    HStack(alignment: .bottom, spacing: 0){
                        Text(self.spent).font(.system(size: 35)).foregroundColor(Color(.black)).bold()
                        
                        Spacer()
                        HStack(spacing: 4){
                            Image(systemName: "checkmark.circle.fill").foregroundColor(AppTheme().themeColorPrimary).font(Font.system(size: 14, weight: .semibold))
                            //Text("of " + self.available).font(.system(size: 15)).bold().foregroundColor(AppTheme().themeColorPrimary)
                            Text(self.remaining + " Remaining").font(.system(size: 15)).foregroundColor(AppTheme().themeColorPrimary)
                        }.padding(4).padding(.horizontal, 10)
                        
                    }

                
                Spacer()
            }.padding(.leading)
            
            BudgetStatusBarView(viewData: self.viewModel.getBudgetStatusBarViewData()).padding(.top, 7)
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


