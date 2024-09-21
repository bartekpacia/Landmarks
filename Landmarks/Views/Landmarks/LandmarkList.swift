import SwiftUI

struct LandmarkList: View {
    @Environment(ModelData.self) var modelData
    @State private var showFavoritesOnly = false

    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            if showFavoritesOnly {
                return landmark.isFavorite
            }

            return true
        }
    }

    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }

                ForEach(filteredLandmarks) { landmark in
                    NavigationLink(
                        destination: { LandmarkDetail(landmark: landmark) },
                        label: { LandmarkRow(landmark: landmark) }
                    )
                    .navigationTitle("Landmarks")
                }
            }
        }
    }
}

#Preview {
    LandmarkList()
        .environment(ModelData())
}
