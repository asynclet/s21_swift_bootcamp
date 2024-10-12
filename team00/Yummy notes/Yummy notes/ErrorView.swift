import SwiftUI

struct ErrorView: View {
    
    let error: Error
    
    var body: some View {
        ZStack {
            Text("🚫")
                .font(.system(size: Static.textSize))
            Text("Error: \(error.localizedDescription)")
                .foregroundColor(.red)
                .font(.bold(Font.caption)())
                .shadow(color: .black, radius: Static.shadowRadius)
        }
    }
    
    enum Static {
        static let textSize: CGFloat = 60
        static let shadowRadius: CGFloat = 10
    }
}
