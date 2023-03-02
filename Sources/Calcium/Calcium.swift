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

public typealias SkeletonTableViewCellIdentifierProvider = (SkeletonTableViewProvider, UITableView, IndexPath) -> ReusableCellIdentifier
public typealias SkeletonTableViewHeaderFooterIdentifierProvider = (SkeletonTableViewProvider, UITableView, Int) -> ReusableCellIdentifier
public typealias SkeletonTableViewSectionCountProvider = (SkeletonTableViewProvider, UITableView) -> Int
public typealias SkeletonTableViewSectionItemCountProvider = (SkeletonTableViewProvider, UITableView, Int) -> Int

public typealias SkeletonCollectionViewCellIdentifierProvider = (SkeletonCollectionViewProvider, UICollectionView, IndexPath) -> ReusableCellIdentifier
public typealias SkeletonCollectionViewSupplementaryItemIdentifierProvider = (SkeletonCollectionViewProvider, UICollectionView, String, IndexPath) -> ReusableCellIdentifier
public typealias SkeletonCollectionViewSectionCountProvider = (SkeletonCollectionViewProvider, UICollectionView) -> Int
public typealias SkeletonCollectionViewSectionItemCountProvider = (SkeletonCollectionViewProvider, UICollectionView, Int) -> Int

// MARK: - Configuration

public class SkeletonTableViewConfiguration {

    public var configureSkeletonTableViewCellIdentifier: SkeletonTableViewCellIdentifierProvider? = nil
    public var configureSkeletonTableViewSectionCount: SkeletonTableViewSectionCountProvider? = nil
    public var configureSkeletonTableViewSectionItemCount: SkeletonTableViewSectionItemCountProvider? = nil
    public var configureSkeletonTableViewSectionHeaderIdentifier: SkeletonTableViewHeaderFooterIdentifierProvider? = nil
    public var configureSkeletonTableViewSectionFooterIdentifier: SkeletonTableViewHeaderFooterIdentifierProvider? = nil

}

public class SkeletonCollectionViewConfiguration {

    public var configureSkeletonCollectionViewCellIdentifier: SkeletonCollectionViewCellIdentifierProvider? = nil
    public var configureSkeletonCollectionViewSupplementaryItemIdentifier: SkeletonCollectionViewSupplementaryItemIdentifierProvider? = nil
    public var configureSkeletonCollectionViewSectionCount: SkeletonCollectionViewSectionCountProvider? = nil
    public var configureSkeletonCollectionViewSectionItemCount: SkeletonCollectionViewSectionItemCountProvider? = nil

}

// MARK: - SkeletonTableViewProvider

public protocol SkeletonTableViewProvider: SkeletonTableViewDelegate, SkeletonTableViewDataSource {

    var skeletonTableViewConfiguration: SkeletonTableViewConfiguration { get }

}

public extension SkeletonTableViewProvider {

    var configureSkeletonCellIdentifier: SkeletonTableViewCellIdentifierProvider? {
        get {
            skeletonTableViewConfiguration.configureSkeletonTableViewCellIdentifier
        }
        set {
            skeletonTableViewConfiguration.configureSkeletonTableViewCellIdentifier = newValue
        }
    }

    var configureSkeletonSectionCount: SkeletonTableViewSectionCountProvider? {
        get {
            skeletonTableViewConfiguration.configureSkeletonTableViewSectionCount
        }
        set {
            skeletonTableViewConfiguration.configureSkeletonTableViewSectionCount = newValue
        }
    }

    var configureSkeletonSectionItemCount: SkeletonTableViewSectionItemCountProvider? {
        get {
            skeletonTableViewConfiguration.configureSkeletonTableViewSectionItemCount
        }
        set {
            skeletonTableViewConfiguration.configureSkeletonTableViewSectionItemCount = newValue
        }
    }

    var configureSkeletonSectionHeaderIdentifier: SkeletonTableViewHeaderFooterIdentifierProvider? {
        get {
            skeletonTableViewConfiguration.configureSkeletonTableViewSectionHeaderIdentifier
        }
        set {
            skeletonTableViewConfiguration.configureSkeletonTableViewSectionHeaderIdentifier = newValue
        }
    }

    var configureSkeletonSectionFooterIdentifier: SkeletonTableViewHeaderFooterIdentifierProvider? {
        get {
            skeletonTableViewConfiguration.configureSkeletonTableViewSectionFooterIdentifier
        }
        set {
            skeletonTableViewConfiguration.configureSkeletonTableViewSectionFooterIdentifier = newValue
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

// MARK: - SkeletonCollectionViewProvider

public protocol SkeletonCollectionViewProvider: SkeletonCollectionViewDelegate, SkeletonCollectionViewDataSource {

    var skeletonCollectionViewConfiguration: SkeletonCollectionViewConfiguration { get }

}

public extension SkeletonCollectionViewProvider {

    var configureSkeletonCollectionViewCellIdentifier: SkeletonCollectionViewCellIdentifierProvider? {
        get {
            skeletonCollectionViewConfiguration.configureSkeletonCollectionViewCellIdentifier
        }
        set {
            skeletonCollectionViewConfiguration.configureSkeletonCollectionViewCellIdentifier = newValue
        }
    }

    var configureSkeletonCollectionViewSupplementaryItemIdentifier: SkeletonCollectionViewSupplementaryItemIdentifierProvider? {
        get {
            skeletonCollectionViewConfiguration.configureSkeletonCollectionViewSupplementaryItemIdentifier
        }
        set {
            skeletonCollectionViewConfiguration.configureSkeletonCollectionViewSupplementaryItemIdentifier = newValue
        }
    }

    var configureSkeletonCollectionViewSectionCount: SkeletonCollectionViewSectionCountProvider? {
        get {
            skeletonCollectionViewConfiguration.configureSkeletonCollectionViewSectionCount
        }
        set {
            skeletonCollectionViewConfiguration.configureSkeletonCollectionViewSectionCount = newValue
        }
    }

    var configureSkeletonCollectionViewSectionItemCount: SkeletonCollectionViewSectionItemCountProvider? {
        get {
            skeletonCollectionViewConfiguration.configureSkeletonCollectionViewSectionItemCount
        }
        set {
            skeletonCollectionViewConfiguration.configureSkeletonCollectionViewSectionItemCount = newValue
        }
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        guard let identifier = configureSkeletonCollectionViewCellIdentifier?(self, skeletonView, indexPath) else {
            fatalError("⚠️ Cannot dequeue skeleton cell for IndexPath \(indexPath)")
        }

        return identifier
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? {
        configureSkeletonCollectionViewSupplementaryItemIdentifier?(self, skeletonView, supplementaryViewIdentifierOfKind, indexPath)
    }

    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        configureSkeletonCollectionViewSectionCount?(self, collectionSkeletonView) ?? 1
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        configureSkeletonCollectionViewSectionItemCount?(self, skeletonView, section) ?? UICollectionView.automaticNumberOfSkeletonItems
    }

}

// MARK: - Implementation

open class GRSkeletonTableViewProvider<Section: Sectionable>: GRTableViewProvider<Section>, SkeletonTableViewProvider {

    public var skeletonTableViewConfiguration = SkeletonTableViewConfiguration()

}

open class GRSkeletonDiffableTableViewProvider<Section: Sectionable>: GRDiffableTableViewProvider<Section>, SkeletonTableViewProvider where Section: Hashable & Equatable, Section.Item: Hashable & Equatable {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 0 }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { UITableViewCell() }

    public var skeletonTableViewConfiguration = SkeletonTableViewConfiguration()

}

open class GRSkeletonCollectionViewProvider<Section: Sectionable>: GRCollectionViewProvider<Section>, SkeletonCollectionViewProvider {

    public var skeletonCollectionViewConfiguration = SkeletonCollectionViewConfiguration()

}

open class GRSkeletonDiffableCollectionViewProvider<Section: Sectionable>: GRDiffableCollectionViewProvider<Section>, SkeletonCollectionViewProvider where Section: Hashable & Equatable, Section.Item: Hashable & Equatable {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 0 }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { UICollectionViewCell() }

    public var skeletonCollectionViewConfiguration = SkeletonCollectionViewConfiguration()

}
