import SwiftUI

struct LandmarkList: View {
  @EnvironmentObject var modelData: ModelData
  @State private var showFavoritesOnly = false
  @State private var username = ""
  @State private var password = ""

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
        Text("lol")
        TextField("username", text: $username)
        SecureField("password", text: $password)
          .accessibilityLabel("username")
        Toggle(isOn: $showFavoritesOnly) {
          Text("Favorites only")
        }
        ForEach(filteredLandmarks) { landmark in
          NavigationLink {
            LandmarkDetail(landmark: landmark)
          } label: {
            LandmarkRow(landmark: landmark)
          }
          .navigationTitle("Landmarks")
        }
      }
    }
  }
}

struct LandmarkList_Previews: PreviewProvider {
  static var previews: some View {
    LandmarkList().environmentObject(ModelData())
  }
}
