//
//  SwiftUITestView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/9/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI
//import SwiftUICharts


struct BudgetCardView: View {
    
    var budget : Budget
    var viewModel : BudgetsViewModel
    
    var title: String

    var percentage: Float
    var available : String
    var daysLeft : String?
    
    
    
    @State var isLarge = false
    
    @State var testPicker = 0
    
    init(budget : Budget, viewModel: BudgetsViewModel){
        print("BudgetCard view created")
        self.budget = budget
        self.viewModel = viewModel
        self.title = CommonUtils.getMonthFromDate(date: budget.startDate!)
        
        self.percentage = 1.0 - (budget.spent / budget.amount)
        self.available = CommonUtils.makeMoneyString(number:(Int(self.viewModel.budgetTransactionsService.getLeftInBudget())))
        print(available)
        print("poop1234")
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
    
    func getDaysLeftIn() -> String{
        
        let date = Date()
        let endDate = self.budget.endDate!
        
        let diffInDays = Calendar.current.dateComponents([.day], from: date, to: endDate).day
        
        return String(diffInDays!) + " Days Left"
        
    }
    
    


    



    
    

    
    
    
    var graphView: some View{
        
        VStack(alignment: .center){
            
            HStack{
                Spacer()
                VStack(alignment: .center){
                    Text("Remaining").foregroundColor(Color(.gray)).font(.system(size: 20, weight: .bold, design: .rounded))
                    Text("\(self.available)").foregroundColor(globalAppTheme.themeColorPrimary).font(.system(size: 38, weight: .heavy, design: .rounded)).fontWeight(.bold)
                }
                Spacer()
            }.padding().padding(.top).padding(.vertical)
            
            
            
            
            
            
            
                  .padding(15)
                  .background(Color(.systemBlue).opacity(0.05))
                  .cornerRadius(25)
                  
                  .padding(.top, 25)
            }
            
            
              
              
          
    }
    
    var body: some View {
        
        
            
            VStack(spacing: 0.0){
                HStack(alignment: .top){
                    
                    VStack(alignment: .leading){
                        
                        
                        Text("\(self.available)").font(.system(size: 30, weight: .heavy, design: .rounded)).foregroundColor(globalAppTheme.themeColorPrimary)
                        Text("Left in budget").foregroundColor(Color(.gray)).font(.system(size: 17, weight: .bold, design: .rounded))
                        
                        
                        
                        
                        
                    }
                    Spacer()
                    
                    
                    Menu() {
                        
                        
                        Picker(selection: $testPicker, label: Text("Budget Section")) {
                            
                            Label("Spending", systemImage: "chart.bar.doc.horizontal").tag(0)
                            Label("Recurring", systemImage: "chart.line.uptrend.xyaxis.circle").tag(1)
                            //  Label("All Spending", systemImage: "chart.line.uptrend.xyaxis.circle").tag(2)
                            Label("Income", systemImage: "chart.line.uptrend.xyaxis").tag(3)
                            
                            
                            
                        }
                        
                    }
                    label: {
                        
                        HStack(spacing: 3){
                            
                                Text("Spending").font(.system(size: 17, weight: .bold, design: .rounded))
                                Image(systemName: "chevron.down").font(.system(size: 17, weight: .bold, design: .rounded))
                            
                            
                        }.padding(.horizontal, 12).padding(.vertical, 6).background(Color(.tertiarySystemGroupedBackground)).clipShape(Capsule())
                        
                    }
                    
                   
                }
                    
                    
                
            }
            

    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
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


