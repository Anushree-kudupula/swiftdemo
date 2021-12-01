//
//  main.swift
//  demobank
//
//  Created by Anushree on 01/12/21.
//

import Foundation

@objc protocol BankOnCustomer {
    var name: String {get}
    var initialAmount: Double {get}
    @objc optional var emailId: String {get}
    @objc optional var mobileNo: Int {get}
}

class Customer: BankOnCustomer {
    
    var name: String
    var initialAmount: Double
    var accountType: String
    var emailId: String
    var mobileNo: Int
    
    init(name: String, initialAmount: Double, emailId: String, mobileNo: Int, accountType: String) {
        self.name = name
        self.initialAmount = initialAmount
        self.emailId = emailId
        self.mobileNo = mobileNo
        self.accountType = accountType
    }
    
    func getAccountNo(bankDetails: Bank)-> Int {
        return bankDetails.createAccountNo()
    }
}

var customer1 = Customer(name: "Anu", initialAmount: 13000.00, emailId: "example@gmail.com", mobileNo: 4433552345, accountType: "Savings")
var customer2 = Customer(name: "Avi", initialAmount: 9000.00, emailId: "example2@gmail.com", mobileNo: 6677889900, accountType: "Fixed")

class Bank {
    
    var accountHolders : [Customer] = [customer1, customer2]
    var accountNo: [Int]
    
    init(accountNo: [Int]) {
        self.accountNo = accountNo
    }
    
    func createAccountNo()-> Int {
        var id: Int
        id = Int.random(in: 1000000000000...9999999999999)
        
        while (accountNo.contains(id)) {
            id = Int.random(in: 1000000000000...9999999999999)
            accountNo.append(id)
            return id
        }
            accountNo.append(id)
            return id
    }
}

class AccountBalance {
    
    func getAccountBalance(details: Customer)-> Double {
        let currentBalance = details.initialAmount
        return currentBalance
    }
}

class CaSaAccount: AccountBalance {
    
    var accountStatements : [Double]
    var interestRate : Int = 9
    
    init(accountStatements: [Double]) {
        self.accountStatements = accountStatements
    }
    
    func deposit(details: Customer, amountToDeposit: Double)-> Double {
        details.initialAmount = details.initialAmount + amountToDeposit
        accountStatements.append(details.initialAmount)
        return details.initialAmount
    }
    
    func withdraw(details: Customer, amountToWithdraw: Double)-> Double {
        if(details.initialAmount >= amountToWithdraw) {
            details.initialAmount = details.initialAmount - amountToWithdraw
            accountStatements.append(details.initialAmount)
            return details.initialAmount
        } else {
            print("Insufficient balance!!!")
            return 0.00
        }
    }
    
    func getAccountStatements() {
        for index in (accountStatements.count - 10)...(accountStatements.count) {
            print (accountStatements[index])
        }
    }
    
    func addInterest(details: Customer) -> Double {
        details.initialAmount = details.initialAmount * (details.initialAmount * Double(interestRate) / 365)
        return details.initialAmount
    }
}

class Savings: CaSaAccount {}
class Current: CaSaAccount {}

class LoanAccount: AccountBalance {
    
    var loanAccountStatements: [Double]
    var interestRate: Int = 6
    
    init(loanAccountStatements: [Double]) {
        self.loanAccountStatements = loanAccountStatements
    }
    
    func depositLoan(details: Customer, amountToDeposit: Double)-> Double {
        details.initialAmount = details.initialAmount + amountToDeposit
        loanAccountStatements.append(details.initialAmount)
        return details.initialAmount
    }
    
    func getLoanAccountStatements() {
        for index in (loanAccountStatements.count - 10)...(loanAccountStatements.count) {
            print (loanAccountStatements[index])
        }
    }
    
    func addInterestToLoan(details: Customer) -> Double {
        details.initialAmount = details.initialAmount * (details.initialAmount * Double(interestRate) / 365)
        return details.initialAmount
    }

}

class HouseLoan: LoanAccount {}
class VehicleLoan: LoanAccount{}
class PersonalLoan: LoanAccount {}

class FixedAccount {
    var interestRate: Int = 3
    var term: Int = 2
    
    func depositOnce(details: Customer, amountToDeposit: Double)-> Double {
            struct Holder { static var called = false }

            if !Holder.called {
                Holder.called = true
                details.initialAmount = details.initialAmount + amountToDeposit
                return details.initialAmount
            } else {
              print("Fixed deposit accountcan be deposited only once!!!")
              return 0.00
            }
        }
    
    func addInterestToDeposit(details: Customer) -> Double {
        details.initialAmount = details.initialAmount * (details.initialAmount * Double(interestRate) * Double(term))
        return details.initialAmount
    }
}

class RecurringAccount {
    var recurringAccountStatements : [Double]
    var interestRate: Double = 2.50
    var term: Int = 6
    
    init(recurringAccountStatements: [Double]) {
        self.recurringAccountStatements = recurringAccountStatements
    }
    
    func depositLoan(details: Customer, amountToDeposit: Double)-> Double {
        details.initialAmount = details.initialAmount + amountToDeposit
        recurringAccountStatements.append(details.initialAmount)
        return details.initialAmount
    }
    
    func getRecurringAccountStatements() {
        for index in (recurringAccountStatements.count - 10)...(recurringAccountStatements.count) {
            print (recurringAccountStatements[index])
        }
    }
    
    func addInterestToDeposit(details: Customer) -> Double {
        details.initialAmount = details.initialAmount * (details.initialAmount * interestRate * Double(term))
        return details.initialAmount
    }
}

class AccountDetails {
    
    var accountHolders : [Customer] = [customer1, customer2]
    
    func displayAccountDetails(name: String) ->(String, String, Int) {
        for person in accountHolders {
            if (name == person.name) {
                return (person.name, person.accountType, person.getAccountNo(bankDetails: Bank))
            }
        }
    }
}

class AccountManager {
    var listOfAccounts : [AccountDetails]
    
    init(listOfAccounts: [AccountDetails]) {
        self.listOfAccounts = listOfAccounts
    }
}


