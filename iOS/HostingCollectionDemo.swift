import SwiftUI
import SwiftUIBackports

#if os(iOS) || os(tvOS)
@available(iOS 14, *)
struct HostingCollectionDemo: Demonstrable {
    var body: some View {
        Representable()
            .edgesIgnoringSafeArea(.all)
    }
}

@available(iOS 14, *)
private struct Representable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> Controller { .init() }
    func updateUIViewController(_ controller: Controller, context: Context) { }
}

@available(iOS 14, *)
private final class Controller: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Int, Int>
    private var dataSource: DataSource?

    private static var layout: UICollectionViewCompositionalLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .grouped)
        config.headerMode = .supplementary
        return UICollectionViewCompositionalLayout.list(using: config)
    }

    init() {
        super.init(collectionViewLayout: Self.layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var content: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                Image(systemName: "swift")
                    .font(.title)
                    .padding(10)
                    .backport.background {
                        Circle()
                            .stroke(lineWidth: 3)
                    }
                    .foregroundColor(.accentColor)
                    .padding(.top, 3)

                VStack(alignment: .leading) {
                    Text("Swift")
                        .font(.title3)
                    Text("Programming Language")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }

                Spacer(minLength: 0)
            }

            HStack {
                Text("Where dream come true.")
                Spacer(minLength: 0)
            }
            .foregroundColor(.secondary)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let cell = UICollectionView.CellRegistration<UICollectionViewListCell, Int> { cell, indexPath, item in
            cell.backport.contentConfiguration = Backport.UIHostingConfiguration { self.content }
                .margins(.all, 20)
        }

        let header = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) { view, kind, indexPath in
            var configuration = view.defaultContentConfiguration()

            switch indexPath.section {
            case 0:
                configuration.text = "Backport"
            default:
                configuration.text = "Native"
            }

            view.contentConfiguration = configuration
        }

        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: cell, for: indexPath, item: item)
        }

        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                return collectionView.dequeueConfiguredReusableSupplementary(using: header, for: indexPath)
            default:
                fatalError()
            }
        }

        collectionView.dataSource = dataSource

        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        snapshot.appendItems([0])

        if #available(iOS 16, *) {
            snapshot.appendSections([1])
            snapshot.appendItems([1])
        }

        dataSource?.apply(snapshot)
    }

    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool { false }

}

#endif
