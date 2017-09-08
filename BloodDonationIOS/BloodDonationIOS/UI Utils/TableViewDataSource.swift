//
//  TableViewDataSource.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 8/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit


class TableViewDataSource<CellType, DataType>: NSObject, UITableViewDelegate, UITableViewDataSource where CellType: UITableViewCell {
    
    typealias ConfigureCellBlock = (_ cell: CellType, _ object: DataType) -> ()
    typealias SelectCellBlock = (_ object: DataType, _ indexPath: IndexPath) -> ()
    
    private var sections: [CollectionSection<DataType>] = []
    private var configureCellBlock: ConfigureCellBlock?
    private var selectCellBlock: SelectCellBlock?
    private weak var tableView: UITableView?
    
    // MARK: Public methods
    
    func configure(tableView: UITableView?) {
        self.tableView = tableView
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
    }

    
    func reloadData(tableSections: [CollectionSection<DataType>]) {
        guard let tableView = tableView else {
            print("warning tableView nil please use configure");
            return
        }
        sections = tableSections
        tableView.reloadData()
    }
    
    // MARK: table view delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[safe: section]?.rows.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tableRow = sections[safe:indexPath.section]?.rows[safe:indexPath.row] else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableRow.cellIdentifier, for: indexPath) as? CellType else { return UITableViewCell() }
        
        configureCellBlock?(cell, tableRow.data)
        return cell
    }
    
    
    func objectAtIndexPath(_ indexPath: IndexPath) -> DataType? {
        
        return sections[safe:indexPath.section]?.rows[safe:indexPath.row]?.data
    }
    
    func hasSomeData() -> Bool {
        
        return (sections.count > 0) ? true : false
    }
    
    func resetSections(viewModels: [[DataType]], cellIdentifier: String) {
        let tableSections =  viewModels.map { CollectionSection<DataType>(rows: $0.map { CollectionRow<DataType>(data: $0, cellIdentifier: cellIdentifier) }) }
        reloadData(tableSections: tableSections)
    }
    
    // MARK: Event handlers
    
    func onEventConfigureCell(configureCell: @escaping ConfigureCellBlock) {
        self.configureCellBlock = configureCell
    }

    func onEventItemSelected(selectCell: @escaping SelectCellBlock) {
        self.selectCellBlock = selectCell
    }
    
    // MARK: TableView delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let viewModel = objectAtIndexPath(indexPath) {
            selectCellBlock?(viewModel, indexPath)
        }
    }
    
    
}
