import SwiftUI
import Kingfisher

struct ListView: View {
    
    var body: some View {
        Group {
            switch state {
            case .loading:
                ProgressView()
                    .frame(width: Static.imageWidth, height: Static.imageHeight)
                    .progressViewStyle(.circular)
                    .tint(.green)
            case .loaded(let recepies):
                List(recepies) { recipe in
                    NavigationLink(destination: NoteView(recipe: recipe.wrappedValue)) {
                        HStack {
                            Color.clear
                                .frame(width: Static.imageWidth, height: Static.imageHeight)
                                .overlay(alignment: .leading) {
                                    if let stringUrl = recipe.imageUrl.wrappedValue,
                                       let url = URL(string: stringUrl) {
                                        KFImage.url(url)
                                            .placeholder {
                                                Circle()
                                                    .foregroundStyle(.gray)
                                            }
                                            .cropping(size: CGSize(width: Static.imageWidth, height: Static.imageHeight))
                                            .clipShape(Circle())
                                            .shadow(color: .green, radius: Static.shadowRadius)
                                    }
                                }
                        }
                        
                        Spacer(minLength: Static.spacing)
                        
                        Text(recipe.title.wrappedValue)
                            .font(.bold(Font.caption)())
                    }
                }
            case .error(let error):
                ErrorView(error: error)
            }
        }
        .onAppear {
            Task { @MainActor in
                state = await ListViewState(NetworkService.shared.loadList())
            }
        }
    }
    
    enum ListViewState {
        case loading
        case loaded(Binding<[Recipe]>)
        case error(Error)
        
        init(_ state: Result<[Recipe], Error>) {
            switch state {
            case .success(let recipes):
                self = .loaded(.constant(recipes))
            case .failure(let error):
                self = .error(error)
            }
        }
    }
    
    // MARK: - Private Properties
    
    @State private(set) var state: ListViewState = .loading
    
    enum Static {
        static let imageWidth: CGFloat = 50
        static let imageHeight: CGFloat = 50
        static let shadowRadius: CGFloat = 10
        static let spacing: CGFloat = 20
    }
    
}
