import SwiftUI
import Kingfisher

struct NoteView: View {
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        VStack {
            Color.clear
                .frame(width: Static.imageWidth, height: Static.imageHeight)
                .overlay(alignment: .leading) {
                    if let stringUrl = recipe.imageUrl,
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
                .padding(.vertical, Static.spacing)
            Text(recipe.title)
                .tint(.green)
                .font(.bold(Font.title)())
                .shadow(color: .white, radius: Static.shadowRadius)
                .padding(.bottom, Static.spacing)
            
            Spacer()
            
            HStack {
                Text(Static.title)
                    .tint(.green)
                    .font(.bold(Font.headline)())
                    .shadow(color: .white, radius: Static.shadowRadius)
                    .padding(.bottom, Static.spacing)
                Spacer()
            }
            .padding(.horizontal)
            
            instructionsView
                .onAppear {
                    Task { @MainActor in
                        state = NoteViewState(
                            await NetworkService.shared.loadSteps(for: recipe.id)
                        )
                    }
                }
            
        }
    }
    
    @ViewBuilder
    private var instructionsView: some View {
        switch state {
        case .loaded(let steps):
            TabView {
                ForEach(steps, id: \.self) { step in
                    Form {
                        VStack(alignment: .leading) {
                            Text(step.step)
                                .font(.body)
                                .padding()
                                .shadow(color: .green, radius: Static.shadowRadius)
                            Divider()
                            ForEach(step.ingredients, id: \.self) { ingredient in
                                Text("• \(ingredient.name)")
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .tabItem {
                        Text(step.number.toEmoji())
                    }
                }
            }
        case .loading:
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.green)
        case .error(let error):
            ErrorView(error: error)
        }
    }
    
    // MARK: - Private Types
    
    private enum Static {
        static let imageWidth: CGFloat = 150
        static let imageHeight: CGFloat = 150
        static let shadowRadius: CGFloat = 10
        static let spacing: CGFloat = 20
        static let title = "Steps"
    }
    
    private enum NoteViewState {
        case loaded(steps: [Step])
        case loading
        case error(Error)
        
        init (_ result: Result<[Step], Error>) {
            switch result {
            case .success(let steps):
                self = .loaded(steps: steps)
            case .failure(let error):
                self = .error(error)
            }
        }
    }
    
    // MARK: - Private Properties
    
    @State
    private var state: NoteViewState = .loading
    private let recipe: Recipe
    
}

#Preview {
    NoteView(
        recipe: Recipe(id: 1, imageUrl: "https://example.com/image1.jpg", title: "Spaghetti Bolognese")
    )
}
