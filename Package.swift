// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Moya",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10),
        .watchOS(.v3)
    ],
    products: [
        .library(name: "Moya", targets: ["Moya"]),
        .library(name: "RxMoya", targets: ["RxMoya"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.0"))
    ],
    targets: [
        .target(name: "Moya", dependencies: ["Alamofire"]),
        .target(name: "RxMoya", dependencies: ["Moya", "RxSwift"])
    ]
)

#if canImport(PackageConfig)
import PackageConfig

let config = PackageConfiguration([
    "rocket": [
	"before": [
            "scripts/update_changelog.sh",
            "scripts/update_podspec.sh"
	],
	"after": [
            "rake create_release\\[\"$VERSION\"\\]",
            "scripts/update_docs_website.sh"
	]
    ]
]).write()
#endif
