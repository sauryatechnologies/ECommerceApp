import SwiftUI

struct CartButton: View {
    @EnvironmentObject var cartVM: CartViewModel
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "cart")
                    .font(.title2)
                
                if cartVM.totalQuantity > 0 {
                    Text("\(cartVM.totalQuantity)")
                        .font(.caption2).bold()
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Circle().fill(Color.red))
                        .offset(x: 10, y: -10)
                }
            }
        }
    }
}

