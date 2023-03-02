import XCTest
@testable import Calcium
@testable import GRProvider
@testable import SkeletonView

final class CalciumTests: XCTestCase {

    private struct TestSection: Sectionable {
        var items: [String] = []
    }

    func testTableViewSkeletonProviderItemCount() {
        let tableView = UITableView()
        let provider = GRSkeletonTableViewProvider<TestSection>()

        provider.configureSkeletonSectionCount = { provider, tableView in 2 }
        provider.configureSkeletonSectionItemCount = { provider, tableView, section in
            if section == 0 {
                return 3
            } else {
                return 5
            }
        }

        XCTAssert(provider.collectionSkeletonView(tableView, numberOfRowsInSection: 0) == 3)
        XCTAssert(provider.collectionSkeletonView(tableView, numberOfRowsInSection: 1) == 5)
    }

    func testCollectionViewSkeletonProviderItemCount() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let provider = GRSkeletonCollectionViewProvider<TestSection>()

        provider.configureSkeletonCollectionViewSectionCount = { provider, collectionView in 2 }
        provider.configureSkeletonCollectionViewSectionItemCount = { provider, collectionView, section in
            if section == 0 {
                return 3
            } else {
                return 5
            }
        }

        XCTAssert(provider.collectionSkeletonView(collectionView, numberOfItemsInSection: 0) == 3)
        XCTAssert(provider.collectionSkeletonView(collectionView, numberOfItemsInSection: 1) == 5)
    }

    func testProtocolConformance() {
        let subtype1 = GRSkeletonCollectionViewProvider<TestSection>() as SkeletonCollectionViewDelegate
        let subtype2 = GRSkeletonCollectionViewProvider<TestSection>() as SkeletonCollectionViewDataSource
        let subtype3 = GRSkeletonTableViewProvider<TestSection>() as SkeletonTableViewDelegate
        let subtype4 = GRSkeletonTableViewProvider<TestSection>() as SkeletonTableViewDataSource

        XCTAssertNotNil(subtype1)
        XCTAssertNotNil(subtype2)
        XCTAssertNotNil(subtype3)
        XCTAssertNotNil(subtype4)
    }
    
}
