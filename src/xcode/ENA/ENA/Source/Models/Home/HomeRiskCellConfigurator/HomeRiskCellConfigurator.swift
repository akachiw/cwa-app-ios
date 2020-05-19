//
//  HomeRiskCellConfigurator.swift
//  ENA
//
//  Created by Tikhonov, Aleksandr on 04.05.20.
//  Copyright © 2020 SAP SE. All rights reserved.
//

import UIKit
import ExposureNotification

final class HomeRiskCellConfigurator: CollectionViewCellConfigurator {
    
    // MARK: Properties
    var contactAction: (() -> Void)?
    
    private var lastUpdateDate: Date?
    private var riskLevel: RiskLevel
    private var numberRiskContacts: Int
    private var lastContactDate: Date
    
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    // MARK: Creating a Home Risk Cell Configurator
    init(riskLevel: RiskLevel, lastUpdateDate: Date?, numberRiskContacts: Int, lastContactDate: Date) {
        self.riskLevel = .high //  riskLevel
        self.lastUpdateDate = lastUpdateDate
        self.numberRiskContacts = numberRiskContacts
        self.lastContactDate = lastContactDate
    }
    
    // MARK: Configuration
    func configure(cell: RiskCollectionViewCell) {
        
        var dateString: String?
        if let date = lastUpdateDate {
            dateString = HomeRiskCellConfigurator.dateFormatter.string(from: date)
        }
        let numberRiskContactsString = String(numberRiskContacts)
        let lastContactDateString = HomeRiskCellConfigurator.dateFormatter.string(from: lastContactDate)
        
        let holder = HomeRiskCellPropertyHolder.propertyHolder(for: riskLevel, dateString: dateString, numberRiskContacts: numberRiskContactsString, lastContactDateString: lastContactDateString)
        // The delegate will be called back when the cell's primary action is triggered
        cell.configure(with: holder, delegate: self)
    }
}


extension HomeRiskCellConfigurator: RiskCollectionViewCellDelegate {
    func contactButtonTapped(cell: RiskCollectionViewCell) {
        contactAction?()
    }
}
