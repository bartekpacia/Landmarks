import SwiftUI

struct LandmarkRow: View {
    var landmark: Landmark

    var body: some View {
        HStack {
            landmark.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(landmark.name)

            Spacer()

            if landmark.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

#Preview("First", traits: .fixedLayout(width: 300, height: 70)) {
    LandmarkRow(landmark: ModelData().landmarks[0])
}

#Preview("Second", traits: .fixedLayout(width: 300, height: 70)) {
    LandmarkRow(landmark: ModelData().landmarks[1])
}
