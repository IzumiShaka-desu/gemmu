//
//  AboutPageView.swift
//  gemmu
//
//  Created by Akashaka on 09/02/22.
//
import SwiftUI
import NetworkImage

struct AboutPageView: View {
  @State private var bottomSheetShown = false
  @State var updater: Bool = false
  @AppStorage("name", store: UserDefaults(
    suiteName: "group.DarkshanDev.userdefaults")) private  var username: String?
  @AppStorage("position", store: UserDefaults(
    suiteName: "group.DarkshanDev.userdefaults")) private var position: String?
  @AppStorage("imageUrl", store: UserDefaults(
    suiteName: "group.DarkshanDev.userdefaults")) private  var imageUrl: String?

  var body: some View {
    GeometryReader { geometry in
      HStack(alignment: .center) {
        Spacer()
        VStack {
          Spacer()
          Text("About me")
            .font(.title)
          NetworkImage(url: URL(string: imageUrl ?? Constants.profileImageUrl)) { image in
            image.resizable()
          } placeholder: {
            ProgressView()
          } fallback: {
            Image(systemName: "photo")

          }
          .frame(width: 150, height: 150)
          .clipped()
          .background().cornerRadius(10)
          Text(username ?? Constants.profileName)
          Text(position ?? Constants.positionName)
          Button(
            action: {
              self.bottomSheetShown =  true
            },
            label: {
              Image(systemName: "pencil.circle")
              Text("Update user profile")
            }
          )
          Spacer()
          Spacer()
          Spacer()
        }
        Spacer()
      }
      BottomSheetView(
        isOpen: self.$bottomSheetShown,
        maxHeight: geometry.size.height * 0.7

      ) {
        ProfileFormView(
          username: username ?? "",
          position: position ?? "",
          imageUrl: imageUrl ?? "", onSubmit: {username, position, imageUrl in
            let storage = UserDefaults(
              suiteName: "group.DarkshanDev.userdefaults"
            )
            storage?.set(username, forKey: "name")
            storage?.set(position, forKey: "position")
            storage?.set(imageUrl, forKey: "imageUrl")
            self.bottomSheetShown =  false
            self.updater.toggle()
          }
        )
      }
    }.edgesIgnoringSafeArea(.all)

  }
}
struct ProfileFormView: View {
  @State  var username = ""
  @State  var position = ""
  @State  var imageUrl = ""
  var onSubmit: (_ username: String?,
                 _ position: String?,
                 _ imageUrl: String?) -> Void
  var body: some View {
    VStack {
      TextField("fill your name ...", text: $username )
        .padding(7)
        .padding(.horizontal, 25)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.horizontal, 10)
      TextField("fill your position ...", text: $position )
        .padding(7)
        .padding(.horizontal, 25)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.horizontal, 10)
      TextField("fill profile image url ...", text: $imageUrl )
        .padding(7)
        .padding(.horizontal, 25)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.horizontal, 10)
      Button(
        action: {
          let name = username.isEmpty ? nil : username
          let position = position.isEmpty ? nil : position
          let imageUrl = imageUrl.isEmpty ? nil : imageUrl
          onSubmit(name, position, imageUrl)
        },
        label: {
          Image(systemName: "pencil.circle")
          Text("Update user profile")
        })

    }

  }
}

struct BottomSheetView<Content: View>: View {
  @Binding var isOpen: Bool

  let maxHeight: CGFloat
  let minHeight: CGFloat
  let content: Content

  init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
    self.minHeight = maxHeight * Constants.minHeightRatio
    self.maxHeight = maxHeight
    self.content = content()
    self._isOpen = isOpen
  }
  private var offset: CGFloat {
    isOpen ? 0 : maxHeight - minHeight
  }

  private var indicator: some View {
    RoundedRectangle(cornerRadius: Constants.radius)
      .fill(Color.secondary)
      .frame(
        width: Constants.indicatorWidth,
        height: Constants.indicatorHeight
      )
  }

  @GestureState private var translation: CGFloat = 0

  var body: some View {
    GeometryReader { geometry in
      VStack(spacing: 0) {
        self.indicator.padding()
        self.content
      }
      .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
      .background(Color(.secondarySystemBackground))
      .cornerRadius(Constants.radius)
      .frame(height: geometry.size.height, alignment: .bottom)
      .offset(y: max(self.offset + self.translation, 0))
      .animation(.interactiveSpring(), value: isOpen)
      .animation(.interactiveSpring(), value: translation)
      .gesture(
        DragGesture()
          .updating(self.$translation) { value, state, _ in
            state = value.translation.height
          }.onEnded { value in
            let snapDistance = self.maxHeight * Constants.snapRatio
            guard abs(value.translation.height) > snapDistance else {
              return
            }
            self.isOpen = value.translation.height < 0
          }
      )
    }
  }
}
struct AboutPageView_Previews: PreviewProvider {
  static var previews: some View {
    AboutPageView()
  }
}
