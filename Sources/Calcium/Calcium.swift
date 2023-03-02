import GRProvider
import SkeletonView
import UIKit

open class GRSkeletonTableViewProvider<Section: Sectionable>: GRTableViewProvider<Section>, SkeletonTableViewDataSource {

    public typealias SkeletonCellIdentifierProvider = (GRSkeletonTableViewProvider, UITableView, IndexPath, Section) -> ReusableCellIdentifier
    public var configureSkeletonCellIdentifier: SkeletonCellIdentifierProvider? = nil

    public func numSections(in tableSkeletonView: UITableView) -> Int {
        1
    }

    public func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        guard let identifier = configureSkeletonCellIdentifier?(self, skeletonView, indexPath, sections[indexPath.section]) else {
            fatalError("⚠️ Cannot dequeue skeleton cell for IndexPath \(indexPath)")
        }
        return identifier
    }

}
