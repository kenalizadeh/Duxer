let package = Package(

    name: "Duxer",
    products: [
        .library(
            name: "Duxer",
            targets: ["Duxer"]
        )
    ],
    targets: [
        .target(
            name: "Duxer",
            sources: "Duxer/Classes"
        )
    ]
)
