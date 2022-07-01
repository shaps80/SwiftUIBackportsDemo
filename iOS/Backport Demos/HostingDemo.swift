import SwiftUI
import SwiftUIBackports

#if os(iOS) || os(tvOS)

@available(iOS 14, *)
struct HostingDemo: View {
    var body: some View {
        NavigationView {
            Representable()
                .backport.navigationTitle("Host Config")
        }
        .navigationViewStyle(.stack)

//        NavigationLink {
//            Representable()
//                .backport.navigationTitle("UIHostingConfiguration")
//        } label: {
//            Text("UIHostingConfiguration")
//        }
    }
}

@available(iOS 14, *)
private struct Representable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> Controller { .init() }
    func updateUIViewController(_ controller: Controller, context: Context) { }
}

@available(iOS 14, *)
private final class Controller: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    private var dataSource: DataSource?

    private static var layout: UICollectionViewCompositionalLayout {
        .list(using: .init(appearance: .insetGrouped))
    }

    init() {
        super.init(collectionViewLayout: Self.layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let reg = UICollectionView.CellRegistration<UICollectionViewListCell, String> { cell, indexPath, item in

            cell.backport.contentConfiguration = Backport.UIHostingConfiguration {
                VStack(alignment: .leading) {
                    Text("Primary")
                    Text("Secondary")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
            }

        }

        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: reg, for: indexPath, item: item)
        }

        collectionView.dataSource = dataSource

        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(["SwiftUI"])

        dataSource?.apply(snapshot)
    }

    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool { true }
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool { true }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { }

}

#endif
