//
//  Calcium.swift
//  Calcium-iOS
//
//  Created by Filip Šašala on 02/03/2023.
//

import DeepDiff
import GRProvider
import SkeletonView
import UIKit

// MARK: - Typealiases

public typealias SkeletonCellIdentifierProvider = (SkeletonTableViewProvider, UITableView, IndexPath) -> ReusableCellIdentifier
public typealias SkeletonHeaderFooterIdentifierProvider = (SkeletonTableViewProvider, UITableView, Int) -> ReusableCellIdentifier
public typealias SkeletonSectionCountProvider = (SkeletonTableViewProvider, UITableView) -> Int
public typealias SkeletonSectionItemCountProvider = (SkeletonTableViewProvider, UITableView, Int) -> Int

// MARK: - Configuration

public class SkeletonTableViewProviderConfiguration {

    public var configureSkeletonCellIdentifier: SkeletonCellIdentifierProvider? = nil
    public var configureSkeletonSectionCount: SkeletonSectionCountProvider? = nil
    public var configureSkeletonSectionItemCount: SkeletonSectionItemCountProvider? = nil
    public var configureSkeletonSectionHeaderIdentifier: SkeletonHeaderFooterIdentifierProvider? = nil
    public var configureSkeletonSectionFooterIdentifier: SkeletonHeaderFooterIdentifierProvider? = nil

}


// MARK: - Protocol

public protocol SkeletonTableViewProvider: SkeletonTableViewDelegate, SkeletonTableViewDataSource {

    var skeletonTableViewConfiguration: SkeletonTableViewProviderConfiguration { get }

}

public extension SkeletonTableViewProvider {

    var configureSkeletonCellIdentifier: SkeletonCellIdentifierProvider? {
        get {
            skeletonTableViewConfiguration.configureSkeletonCellIdentifier
        }
        set {
            skeletonTableViewConfiguration.configureSkeletonCellIdentifier = newValue
        }
    }

    var configureSkeletonSectionCount: SkeletonSectionCountProvider? {
        get {
            skeletonTableViewConfiguration.configureSkeletonSectionCount
        }
        set {
            skeletonTableViewConfiguration.configureSkeletonSectionCount = newValue
        }
    }

    var configureSkeletonSectionItemCount: SkeletonSectionItemCountProvider? {
        get {
            skeletonTableViewConfiguration.configureSkeletonSectionItemCount
        }
        set {
            skeletonTableViewConfiguration.configureSkeletonSectionItemCount = newValue
        }
    }

    var configureSkeletonSectionHeaderIdentifier: SkeletonHeaderFooterIdentifierProvider? {
        get {
            skeletonTableViewConfiguration.configureSkeletonSectionHeaderIdentifier
        }
        set {
            skeletonTableViewConfiguration.configureSkeletonSectionHeaderIdentifier = newValue
        }
    }

    var configureSkeletonSectionFooterIdentifier: SkeletonHeaderFooterIdentifierProvider? {
        get {
            skeletonTableViewConfiguration.configureSkeletonSectionFooterIdentifier
        }
        set {
            skeletonTableViewConfiguration.configureSkeletonSectionFooterIdentifier = newValue
        }
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        guard let identifier = configureSkeletonCellIdentifier?(self, skeletonView, indexPath) else {
            fatalError("⚠️ Cannot dequeue skeleton cell for IndexPath \(indexPath)")
        }

        return identifier
    }

    func collectionSkeletonView(_ skeletonView: UITableView, identifierForHeaderInSection section: Int) -> ReusableHeaderFooterIdentifier? {
        configureSkeletonSectionHeaderIdentifier?(self, skeletonView, section)
    }

    func collectionSkeletonView(_ skeletonView: UITableView, identifierForFooterInSection section: Int) -> ReusableHeaderFooterIdentifier? {
        configureSkeletonSectionFooterIdentifier?(self, skeletonView, section)
    }

    func numSections(in tableView: UITableView) -> Int {
        configureSkeletonSectionCount?(self, tableView) ?? 1
    }

    func collectionSkeletonView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        configureSkeletonSectionItemCount?(self, tableView, section) ?? UITableView.automaticNumberOfSkeletonRows
    }

}

// MARK: - Implementation

open class GRSkeletonTableViewProvider<Section: Sectionable>: GRTableViewProvider<Section>, SkeletonTableViewProvider {

    public var skeletonTableViewConfiguration: SkeletonTableViewProviderConfiguration = SkeletonTableViewProviderConfiguration()

}

open class GRSkeletonDiffableTableViewProvider<Section: Sectionable>: GRDiffableTableViewProvider<Section>, SkeletonTableViewProvider where Section: Hashable & Equatable, Section.Item: Hashable & Equatable {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 0 }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { UITableViewCell() }

    public var skeletonTableViewConfiguration: SkeletonTableViewProviderConfiguration = SkeletonTableViewProviderConfiguration()

}
