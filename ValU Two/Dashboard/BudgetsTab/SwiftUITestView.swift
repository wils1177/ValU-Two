//
//  SwiftUITestView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/9/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI


struct BudgetCardView: View {
    
    @ObservedObject var budget : Budget
    var viewModel : BudgetsViewModel
    
    var title: String
    var spent : String
    var percentage: Float
    var available : String
    var daysLeft : String?
    
    var savingsGoal : String
    
    @State var isLarge = false
    
    init(budget : Budget, viewModel: BudgetsViewModel){
        print("BudgetCard view created")
        self.budget = budget
        self.viewModel = viewModel
        self.title = CommonUtils.getMonthFromDate(date: budget.startDate!)
        self.spent = CommonUtils.makeMoneyString(number: Int(viewModel.budgetTransactionsService.getBudgetExpenses()))
        self.percentage = 1.0 - (budget.spent / budget.amount)
        self.available = CommonUtils.makeMoneyString(number:(Int(budget.getAmountAvailable())))
        self.savingsGoal = "$" + String(Int(budget.amount * budget.savingsPercent))
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

    
    var large: some View{
        VStack(spacing: 2){
            
            Button(action: {
                // What to perform
                withAnimation{
                    self.isLarge.toggle()
                }
            }) {
                // How the button looks like
                HStack{
                    SectionHeader(title: "Spending", image: "arrow.down.circle")
                    Spacer()
                    
                    
                    if !isLarge{
                        
                        Text(self.spent).font(.system(size: 22, design: .rounded)).bold().lineLimit(1).padding(.trailing)
                    }
                    
                    Image(systemName: "chevron.right").font(.system(size: 20)).foregroundColor(AppTheme().themeColorPrimary).rotationEffect(.degrees(isLarge ? 90 : 0))
                        
                    
                    
                    
                    
                }.padding(.horizontal, 10)
            }.buttonStyle(PlainButtonStyle())

            
        
            
            
            if isLarge{
                HStack{
                        
                        HStack(alignment: .bottom, spacing: 0){
                            Text(self.spent).font(.system(size: 35, design: .rounded)).bold()
                            
                            Spacer()
                            
                            //Remaining Budget Indicator
                            RemainingBudgetIndicatorView(viewModel: self.viewModel, budget: self.budget)
                        }

                    
                    Spacer()
                }.padding(.leading).padding(.top, 15)
                
                BudgetStatusBarView(viewData: self.viewModel.getBudgetStatusBarViewData()).padding(.top, 7)
            }
            
        }
    }
    
    
    
    
    
    

    
    var body: some View {
        
        large

        
       
        
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


