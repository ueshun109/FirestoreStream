// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "FirestoreStream",
  platforms: [.iOS(.v14)],
  products: [
    .library(
      name: "FirestoreStream",
      targets: ["FirestoreStream"]
    ),
  ],
  dependencies: [
    .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk.git", from: "8.0.0"),
  ],
  targets: [
    .target(
      name: "FirestoreStream",
      dependencies: [
        .product(name: "FirebaseFirestore", package: "Firebase"),
        .product(name: "FirebaseFirestoreSwift-Beta", package: "Firebase"),
      ]
    ),
    .testTarget(
      name: "FirestoreStreamTests",
      dependencies: ["FirestoreStream"]
    ),
  ]
)
