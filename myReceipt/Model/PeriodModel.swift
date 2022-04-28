//
//  PeriodModel.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/28.
//

import Foundation

class PeriodModel {
    static let shared = PeriodModel()
    
    func monthToPeriod(month: String) -> String {
        if month <= "02" {
            return "02"
        } else if month <= "04" {
            return "04"
        } else if month <= "06" {
            return "06"
        } else if month <= "08" {
            return "08"
        } else if month <= "10" {
            return "10"
        } else if month <= "12" {
            return "12"
        } else {
            return ""
        }
    }
    
    func periodToMonth(period: String) -> String {
        switch period {
        case "02":
            return "01-02 月"
        case "04":
            return "03-04 月"
        case "06":
            return "05-06 月"
        case "08":
            return "07-08 月"
        case "10":
            return "09-10 月"
        case "12":
            return "11-12 月"
        default:
            return "錯誤"
        }
    }
}
