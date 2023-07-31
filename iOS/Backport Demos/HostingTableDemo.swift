import SwiftUI
import SwiftUIBackports

#if os(iOS) || os(tvOS)

@available(iOS 14, *)
struct HostingTableDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
                .backport.navigationTitle("TableView")
        } label: {
            if #available(macOS 11, *) {
                Image(systemName: "curlybraces").foregroundColor(.accentColor)
            }
            Text("TableView")
        }
    }
}

@available(iOS 14, *)
private struct Demo: View {
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
private final class Controller: UITableViewController {
    private typealias DataSource = UITableViewDiffableDataSource<Int, Int>
    private var dataSource: DataSource?

    init() {
        super.init(style: .insetGrouped)
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
                    .padding(.top, 3)

                VStack(alignment: .leading) {
                    Text("Swift")
                        .font(.title3)
                    Text("Programming Language")
                        .font(.footnote)
                }

                Spacer(minLength: 0)
            }

            HStack {
                Text("Where dream come true.")
                Spacer(minLength: 0)
            }
        }
        .foregroundColor(Color(.systemBackground))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PersonCell")
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
            cell.backport.contentConfiguration = Backport.UIHostingConfiguration {
                self.content
            }
            .margins(.all, 16)
            .background(Color.blue)
            return cell
        }

        tableView.dataSource = dataSource

        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        snapshot.appendItems([0])

        if #available(iOS 16, *) {
            snapshot.appendSections([1])
            snapshot.appendItems([1])
        }

        dataSource?.apply(snapshot)
    }

    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool { false }

}

#endif
