//
//  SwiftUITestView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/9/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI
import SwiftUICharts


struct BudgetCardView: View {
    
    var budget : Budget
    var viewModel : BudgetsViewModel
    
    var title: String
    var spent : String
    var percentage: Float
    var available : String
    var daysLeft : String?
    var earned : String
    
    @State private var selection = 0
    
    @State var isLarge = false
    
    init(budget : Budget, viewModel: BudgetsViewModel){
        print("BudgetCard view created")
        self.budget = budget
        self.viewModel = viewModel
        self.title = CommonUtils.getMonthFromDate(date: budget.startDate!)
        var spentNumber = Float(viewModel.budgetTransactionsService.getBudgetExpenses())
        self.spent = CommonUtils.makeMoneyString(number: Int(spentNumber))
        self.earned = CommonUtils.makeMoneyString(number: Int(viewModel.budgetTransactionsService.getBudgetIncome() * -1))
        
        self.percentage = 1.0 - (budget.spent / budget.amount)
        self.available = CommonUtils.makeMoneyString(number:(Int(budget.getAmountAvailable() - spentNumber)))
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
    
    


    
    var textColor = Color(.black)

    
    var large: some View{
        VStack(spacing: 0){
            
            Button(action: {
                withAnimation{
                    self.isLarge.toggle()
                }
                    
                
            }) {
                // How the button looks like
                
            }.buttonStyle(PlainButtonStyle())

            
            HStack{
                SectionHeader(title: "Spending", image: "arrow.down.circle")
                Spacer()
                
                
                if !isLarge{
                    
                    Text(self.spent).font(.system(size: 22, design: .rounded)).bold().lineLimit(1).padding(.trailing)
                }
                
                
                
                Image(systemName: "chevron.right").font(.system(size: 20)).foregroundColor(AppTheme().themeColorPrimary).rotationEffect(.degrees(isLarge ? 90 : 0))
                    
                
                
                
                
            }.onTapGesture {
                withAnimation{self.isLarge.toggle()}
            }
            
            
            if isLarge{
                VStack(spacing: 0){
                    HStack{
                            
                            HStack(alignment: .bottom, spacing: 0){
                                Text(self.spent).font(.system(size: 35, design: .rounded)).bold()
                                
                                Spacer()
                                
                                //Remaining Budget Indicator
                                RemainingBudgetIndicatorView(viewModel: self.viewModel, budget: self.budget)
                            }

                        
                        Spacer()
                    }.padding(.top, 15)
                    
                    BudgetStatusBarView(viewData: self.viewModel.getBudgetStatusBarViewData()).padding(.top, 7)
                }
                
                
            }
            
        }
    }
    
    
    var bubble : some View{
        VStack(spacing: 10){
            
            VStack(spacing: 0){
            
                
                HStack{
                    
                    ZStack(alignment: .center)
                    {
                        Circle().frame(width: 40, height: 40).foregroundColor(Color(.systemGreen))
                        Image(systemName: "arrow.up.heart").foregroundColor(Color(.white)).font(.system(size: 25, design: .rounded))
                    }.padding(.trailing, 5)
                    
                    
                    Text("\(self.earned)\(Text("  Earned").foregroundColor(Color(.gray)).font(.system(size: 20, design: .rounded)))").font(.system(size: 25, design: .rounded)).foregroundColor(Color(.systemGreen)).fontWeight(.bold)
                    Spacer()
                }
                
                
            }.padding(.horizontal, 10).padding(.vertical,  10).background(Color(.systemBackground)).cornerRadius(30)

            VStack(spacing: 0){
                
                /*
                HStack{
                    Image(systemName: "arrow.down.heart").font(.system(size: 17, design: .rounded)).foregroundColor(Color(.systemRed))
                    Text("Spending").font(.system(size: 17, design: .rounded)).fontWeight(.semibold).foregroundColor(Color(.systemRed))
                    Spacer()
                    
                    //Image(systemName: "chevron.right").font(.system(size: 17, design: .rounded)).foregroundColor(Color(.systemRed)).rotationEffect(.degrees(isLarge ? 90 : 0))
                    
                    
            
                }.padding(.bottom, 7)
                */
                
                /*
                HStack{
                    Text("\(self.spent)\(Text(" / \(self.available)").foregroundColor(Color(.lightGray)).font(.system(size: 22, design: .rounded)))").font(.system(size: 30, design: .rounded)).fontWeight(.bold)
                    Spacer()
                }.padding(.bottom)
                */
                
                
                
                HStack{
                    
                    ZStack(alignment: .center)
                    {
                        Circle().frame(width: 40, height: 40).foregroundColor(Color(.systemRed))
                        Image(systemName: "arrow.down.heart").foregroundColor(Color(.white)).font(.system(size: 25, design: .rounded))
                    }.padding(.trailing, 5)
                    
                    
                    Text("\(self.spent)\(Text("  Spent").foregroundColor(Color(.gray)).font(.system(size: 20, design: .rounded)))").font(.system(size: 25, design: .rounded)).foregroundColor(Color(.systemRed)).fontWeight(.bold)
                    Spacer()
                }
                
                /*
                if self.isLarge{
                    BudgetStatusBarView(viewData: self.viewModel.getBudgetStatusBarViewData())
                }
                 */
                /*
                else{
                    BudgetStatusBarView(viewData: self.viewModel.getBudgetStatusBarViewData(), showLegend: false).padding(.top, 15)
                }
                 */
                
                /*
                if self.viewModel.getRemaining() < 0{
                    HStack(){
                    RemainingBudgetIndicatorView(viewModel: self.viewModel, budget: self.budget)
                    Spacer()
                    }.padding(.top, -8).padding(.bottom, 8)
                }
                */
                
            }.padding(.horizontal, 10).padding(.vertical,  10).background(Color(.systemBackground)).cornerRadius(30)
            
            
            
            
            VStack(spacing: 0){
            
                
                HStack{
                    
                    ZStack(alignment: .center)
                    {
                        Circle().frame(width: 40, height: 40).foregroundColor(Color(.systemBlue))
                        Image(systemName: "arrow.down.heart").foregroundColor(Color(.white)).font(.system(size: 25, design: .rounded))
                    }.padding(.trailing, 5)
                    
                    
                    Text("\(self.available)\(Text("  Remaining").foregroundColor(Color(.gray)).font(.system(size: 20, design: .rounded)))").font(.system(size: 25, design: .rounded)).foregroundColor(Color(.systemBlue)).fontWeight(.bold)
                    Spacer()
                }
                
                
            }.padding(.horizontal, 10).padding(.vertical,  10).background(Color(.systemBackground)).cornerRadius(30)
            
            
            
            
            
        }
            .onTapGesture {
            withAnimation{
                self.isLarge.toggle()
            }
            
        }
    }
    
    
    
    var graphView: some View{
        
        VStack(alignment: .center){
            
            HStack{
                Spacer()
                VStack(alignment: .center){
                    Text("Remaining").foregroundColor(Color(.gray)).font(.system(size: 20, weight: .bold, design: .rounded))
                    Text("\(self.available)").font(.system(size: 38, design: .rounded)).foregroundColor(Color(.black)).fontWeight(.bold)
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
        
        Section{
            
            VStack(spacing: 0.0){
                HStack{
                    
                    VStack(alignment: .leading){
                        Text("Remaining").foregroundColor(Color(.gray)).font(.system(size: 20, weight: .bold, design: .rounded))
                        Text("\(self.available)").font(.system(size: 38, design: .rounded)).foregroundColor(Color(.black)).fontWeight(.bold)
                    }.padding()//.padding(.bottom)
                    Spacer()
                }
                //BudgetStatusBarView(viewData: self.viewModel.getBudgetStatusBarViewData(), showLegend: false).padding(.horizontal, 35)
            }//.padding(.vertical, 15)
            
        }.listRowBackground(Color.clear).listRowSeparator(.hidden)
        
        Section(){
            
            VStack(){
                
                
                HStack{
                    Text("This Month vs Last Month").font(.system(size: 21, design: .rounded)).foregroundColor(Color(.black)).fontWeight(.bold)
                    Spacer()
                }
                
                HStack{
                    VStack(alignment: .leading){
                        
                        
                        Picker("", selection: $selection) {
                                        Text("Spending").tag(0)
                                        Text("Income").tag(1)
                                        
                                    }
                                    .pickerStyle(.segmented)
                    }
                    Spacer()
                    
                    
                }
                
                if selection == 0{
                    VStack{
                        LineView(dataSet1: self.viewModel.budgetTransactionsService.getThisMonthSpending(), dataSet2: self.viewModel.budgetTransactionsService.getLastMonthSpending(), cutOffValue: Double(self.budget.getAmountAvailable()), color1: Color(.systemBlue), color2: Color(.lightGray).opacity(0.7), cutOffColor: Color(.systemOrange), legendSet: self.viewModel.budgetTransactionsService.getGraphLabels()).frame(height: 200).padding(.vertical, 15)
                        
                        HStack(spacing: 3){
                            Spacer()
                            Rectangle().frame(width: 25, height: 4).foregroundColor(Color(.systemBlue))
                            Text("This Month").font(.system(size: 13, weight: .semibold)).padding(.trailing)
                            Rectangle().frame(width: 25, height: 4).foregroundColor(Color(.lightGray))
                            Text("Last Month").font(.system(size: 13, weight: .semibold)).padding(.trailing)
                            Line()
                                .stroke(Color(.systemOrange), style: StrokeStyle(lineWidth: 2, dash: [4]))
                                       .frame(width:25, height: 2)
                            Text("Budget").font(.system(size: 13, weight: .semibold))
                            Spacer()
                        }
                    }.padding(.top, 7)
                }
                else{
                    VStack{
                        LineView(dataSet1: self.viewModel.budgetTransactionsService.getThisMonthIncome(), dataSet2: self.viewModel.budgetTransactionsService.getLastMonthIncome(), cutOffValue: Double(self.budget.amount), color1: Color(.systemGreen), color2: Color(.lightGray).opacity(0.7), cutOffColor: Color(.systemOrange), legendSet: self.viewModel.budgetTransactionsService.getGraphLabels()).frame(height: 200).padding(.vertical, 10)
                        
                        HStack(spacing: 3){
                            Spacer()
                            Rectangle().frame(width: 25, height: 4).foregroundColor(Color(.systemGreen))
                            Text("This Month").font(.system(size: 13, weight: .semibold)).padding(.trailing)
                            Rectangle().frame(width: 25, height: 4).foregroundColor(Color(.lightGray))
                            Text("Last Month").font(.system(size: 13, weight: .semibold)).padding(.trailing)
                            Line()
                                       .stroke(style: StrokeStyle(lineWidth: 4, dash: [5]))
                                       .frame(width:25, height: 4)
                            Text("Typical Income").font(.system(size: 13, weight: .semibold))
                            Spacer()
                        }
                    }.padding(.top, 10)
                }
                
                
                
                
                
                
                      
            }.padding(12).background(Color(.systemBlue).opacity(0.08)).cornerRadius(25).padding(.horizontal).padding(.bottom)
        }.listRowBackground(Color.clear).listRowSeparator(.hidden)


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


