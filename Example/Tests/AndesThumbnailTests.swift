//
//  AndesThumbnailTests.swift
//  AndesUI_Tests
//
//  Created by Alejo Echeguia on 06/07/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Quick
import Nimble
@testable import AndesUI

class AndesThumbnailTests: QuickSpec {

	override func spec() {
		describe("Andes Thumbnail should draw its view depends on their properties") {
			context("When creating AndesThumbnail - Icon") {
				var  loadImage: UIImage?
				AndesIconsProvider.loadIcon(name: "andes_navegacion_notificaciones_24", success: { loadImage = $0 })

				guard let image = loadImage else {return}

				it("Has the right view type") {
					let thumbnail = AndesThumbnail(hierarchy: .defaultHierarchy, type: .icon, size: .size24, state: .enabled, image: image, accentColor: UIColor.Andes.blueML100)

					expect(thumbnail.contentView.isKind(of: AndesThumbnailIconView.self)).to(beTrue())
				}

				it("should have a Size of 24 px") {
					let thumbnail = AndesThumbnail(hierarchy: .defaultHierarchy, type: .icon, size: .size24, state: .enabled, image: image, accentColor: UIColor.Andes.blueML100)
					let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
					let size: CGFloat = 24.0
					expect(configuration.size).to(equal(size))
					expect(configuration.iconSize).to(equal(16.0))
					expect(configuration.cornerRadius).to(equal(size/2))
				}

				it("should have a Size of 32 px") {
					let thumbnail = AndesThumbnail(hierarchy: .defaultHierarchy, type: .icon, size: .size32, state: .enabled, image: image, accentColor: UIColor.Andes.blueML100)
					let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
					let size: CGFloat = 32.0
					expect(configuration.size).to(equal(size))
					expect(configuration.iconSize).to(equal(20.0))
					expect(configuration.cornerRadius).to(equal(size/2))
				}

				it("should have a Size of 40 px") {
					let thumbnail = AndesThumbnail(hierarchy: .defaultHierarchy, type: .icon, size: .size40, state: .enabled, image: image, accentColor: UIColor.Andes.blueML100)
					let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
					let size: CGFloat = 40.0
					expect(configuration.size).to(equal(size))
					expect(configuration.iconSize).to(equal(24.0))
					expect(configuration.cornerRadius).to(equal(size/2))
				}

				it("should have a Size of 48 px") {
					let thumbnail = AndesThumbnail(hierarchy: .defaultHierarchy, type: .icon, size: .size48, state: .enabled, image: image, accentColor: UIColor.Andes.blueML100)
					let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
					let size: CGFloat = 48.0
					expect(configuration.size).to(equal(size))
					expect(configuration.iconSize).to(equal(24.0))
					expect(configuration.cornerRadius).to(equal(size/2))
				}

				it("should have a Size of 56 px") {
					let thumbnail = AndesThumbnail(hierarchy: .defaultHierarchy, type: .icon, size: .size56, state: .enabled, image: image, accentColor: UIColor.Andes.blueML100)
					let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
					let size: CGFloat = 56.0
					expect(configuration.size).to(equal(size))
					expect(configuration.iconSize).to(equal(32.0))
					expect(configuration.cornerRadius).to(equal(size/2))
				}

				it("should have a Size of 64 px") {
					let thumbnail = AndesThumbnail(hierarchy: .defaultHierarchy, type: .icon, size: .size64, state: .enabled, image: image, accentColor: UIColor.Andes.blueML100)
					let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
					let size: CGFloat = 64.0
					expect(configuration.size).to(equal(size))
					expect(configuration.iconSize).to(equal(32.0))
					expect(configuration.cornerRadius).to(equal(size/2))
				}

				it("should have a Size of 72 px") {
					let thumbnail = AndesThumbnail(hierarchy: .defaultHierarchy, type: .icon, size: .size72, state: .enabled, image: image, accentColor: UIColor.Andes.blueML100)
					let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
					let size: CGFloat = 72.0
					expect(configuration.size).to(equal(size))
					expect(configuration.iconSize).to(equal(32.0))
					expect(configuration.cornerRadius).to(equal(size/2))
				}

				it("should have a Size of 80 px") {
					let thumbnail = AndesThumbnail(hierarchy: .defaultHierarchy, type: .icon, size: .size80, state: .enabled, image: image, accentColor: UIColor.Andes.blueML100)
					let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
					let size: CGFloat = 80.0
					expect(configuration.size).to(equal(size))
					expect(configuration.iconSize).to(equal(48.0))
					expect(configuration.cornerRadius).to(equal(size/2))
				}

				it("should have a corrects colors, hierarchy: loud state: enabled") {
					let accentColor = UIColor.Andes.blueML500
					let thumbnail = AndesThumbnail(hierarchy: .loud, type: .icon, size: .size80, state: .enabled, image: image, accentColor: accentColor)
					let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
					expect(configuration.backgroundColor).to(equal(accentColor))
					expect(configuration.iconColor).to(equal(UIColor.white))
				}

				it("should have a corrects colors, hierarchy: quiet state: enabled") {
					let accentColor = UIColor.Andes.blueML500
					let thumbnail = AndesThumbnail(hierarchy: .quiet, type: .icon, size: .size80, state: .enabled, image: image, accentColor: accentColor)
					let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
					let bgColor = accentColor.withAlphaComponent(0.10)
					expect(configuration.backgroundColor).to(equal(bgColor))
					expect(configuration.iconColor).to(equal(accentColor))
				}

				it("should have a corrects colors, hierarchy:(loud, quiet) state: disabled") {
					let backgroundColor = UIColor.Andes.gray100
					let iconColor = UIColor.Andes.gray250
					let accentColor = UIColor.Andes.blueML500
					let thumbnail = AndesThumbnail(hierarchy: .loud, type: .icon, size: .size80, state: .disabled, image: image, accentColor: accentColor)
					let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
					expect(configuration.backgroundColor).to(equal(backgroundColor))
					expect(configuration.iconColor).to(equal(iconColor))
				}

				it("should have a corrects colors, hierarchy:default  state: disabled") {
					let backgroundColor = UIColor.white
					let iconColor = UIColor.Andes.gray250
					let accentColor = UIColor.Andes.blueML500
					let thumbnail = AndesThumbnail(hierarchy: .defaultHierarchy, type: .icon, size: .size80, state: .disabled, image: image, accentColor: accentColor)
					let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
					expect(configuration.backgroundColor).to(equal(backgroundColor))
					expect(configuration.iconColor).to(equal(iconColor))
				}
			}

			context("When creating AndesThumbnail - Images") {
				let imageV = UIImage(imageLiteralResourceName: "thumbnailImageVertical")
				it("Has the right view type - ImageCircle") {
					let thumbnail = AndesThumbnail(hierarchy: .defaultHierarchy, type: .imageCircle, size: .size24, state: .enabled, image: imageV, accentColor: UIColor.Andes.blueML100)
					expect(thumbnail.contentView.isKind(of: AndesThumbnailImageView.self)).to(beTrue())
				}

				it("Has the right view type - ImageSquare") {
					let thumbnail = AndesThumbnail(hierarchy: .defaultHierarchy, type: .imageSquare, size: .size24, state: .enabled, image: imageV, accentColor: UIColor.Andes.blueML100)
					expect(thumbnail.contentView.isKind(of: AndesThumbnailImageView.self)).to(beTrue())
				}

				context("should have a Size of 24 px") {
					let thumbnail =  AndesThumbnail(hierarchy: .defaultHierarchy, type: .imageCircle, size: .size24, state: .enabled, image: imageV, accentColor: UIColor.Andes.blueML100)

					it("should have correct size, imageCircle") {
						let size: CGFloat = 24.0
						let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
						expect(configuration.size).to(equal(size))
						expect(configuration.cornerRadius).to(equal(size/2))
					}

					it("should have correct size, imageSquare") {
						thumbnail.type = .imageSquare
						let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
						expect(configuration.cornerRadius).to(equal(3.0))
					}
				}

				context("should have a Size of 32 px") {
					let thumbnail =  AndesThumbnail(hierarchy: .defaultHierarchy, type: .imageCircle, size: .size32, state: .enabled, image: imageV, accentColor: UIColor.Andes.blueML100)

					it("should have correct size, imageCircle") {
						let size: CGFloat = 32.0
						let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
						expect(configuration.size).to(equal(size))
						expect(configuration.cornerRadius).to(equal(size/2))
					}

					it("should have correct size, imageSquare") {
						thumbnail.type = .imageSquare
						let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
						expect(configuration.cornerRadius).to(equal(3.0))
					}
				}

				context("should have a Size of 40 px") {
					let thumbnail =  AndesThumbnail(hierarchy: .defaultHierarchy, type: .imageCircle, size: .size40, state: .enabled, image: imageV, accentColor: UIColor.Andes.blueML100)

					it("should have correct size, imageCircle") {
						let size: CGFloat = 40.0
						let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
						expect(configuration.size).to(equal(size))
						expect(configuration.cornerRadius).to(equal(size/2))
					}

					it("should have correct size, imageSquare") {
						thumbnail.type = .imageSquare
						let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
						expect(configuration.cornerRadius).to(equal(4.0))
					}
				}

				context("should have a Size of 48 px") {
					let thumbnail =  AndesThumbnail(hierarchy: .defaultHierarchy, type: .imageCircle, size: .size48, state: .enabled, image: imageV, accentColor: UIColor.Andes.blueML100)

					it("should have correct size, imageCircle") {
						let size: CGFloat = 48.0
						let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
						expect(configuration.size).to(equal(size))
						expect(configuration.cornerRadius).to(equal(size/2))
					}

					it("should have correct size, imageSquare") {
						thumbnail.type = .imageSquare
						let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
						expect(configuration.cornerRadius).to(equal(4.0))
					}
				}

				context("should have a Size of 56 px") {
					let thumbnail =  AndesThumbnail(hierarchy: .defaultHierarchy, type: .imageCircle, size: .size56, state: .enabled, image: imageV, accentColor: UIColor.Andes.blueML100)

					it("should have correct size, imageCircle") {
						let size: CGFloat = 56.0
						let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
						expect(configuration.size).to(equal(size))
						expect(configuration.cornerRadius).to(equal(size/2))
					}

					it("should have correct size, imageSquare") {
						thumbnail.type = .imageSquare
						let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
						expect(configuration.cornerRadius).to(equal(4.0))
					}
				}

				context("should have a Size of 64 px") {
					let thumbnail =  AndesThumbnail(hierarchy: .defaultHierarchy, type: .imageCircle, size: .size64, state: .enabled, image: imageV, accentColor: UIColor.Andes.blueML100)

					it("should have correct size, imageCircle") {
						let size: CGFloat = 64.0
						let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
						expect(configuration.size).to(equal(size))
						expect(configuration.cornerRadius).to(equal(size/2))
					}

					it("should have correct size, imageSquare") {
						thumbnail.type = .imageSquare
						let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
						expect(configuration.cornerRadius).to(equal(4.0))
					}
				}

				context("should have a Size of 72 px") {
					let thumbnail =  AndesThumbnail(hierarchy: .defaultHierarchy, type: .imageCircle, size: .size72, state: .enabled, image: imageV, accentColor: UIColor.Andes.blueML100)

					it("should have correct size, imageCircle") {
						let size: CGFloat = 72.0
						let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
						expect(configuration.size).to(equal(size))
						expect(configuration.cornerRadius).to(equal(size/2))
					}

					it("should have correct size, imageSquare") {
						thumbnail.type = .imageSquare
						let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
						expect(configuration.cornerRadius).to(equal(5.0))
					}
				}

				context("should have a Size of 80 px") {
					let thumbnail =  AndesThumbnail(hierarchy: .defaultHierarchy, type: .imageCircle, size: .size80, state: .enabled, image: imageV, accentColor: UIColor.Andes.blueML100)

					it("should have correct size, imageCircle") {
						let size: CGFloat = 80
						let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
						expect(configuration.size).to(equal(size))
						expect(configuration.cornerRadius).to(equal(size/2))
					}

					it("should have correct size, imageSquare") {
						thumbnail.type = .imageSquare
						let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
						expect(configuration.cornerRadius).to(equal(5.0))
					}
				}
			}
		}

		describe("AndesThumbnail should be able to be change on runtime") {

			context("Should take the new configuration") {
				let accentColor = UIColor.Andes.blueML500
				var thumbnail: AndesThumbnail!
				var  image: UIImage?
				AndesIconsProvider.loadIcon(name: "andes_navegacion_notificaciones_24", success: { image = $0 })

				beforeEach {
					 thumbnail = AndesThumbnail(hierarchy: .defaultHierarchy, type: .icon, size: .size24, state: .enabled, image: image!, accentColor: accentColor)
				}

				it("AndesThumbnail is now Quiet") {
					thumbnail.hierarchy = .quiet
					let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
					let bgColor = accentColor.withAlphaComponent(0.10)
					expect(configuration.backgroundColor).to(equal(bgColor))
					expect(configuration.iconColor).to(equal(accentColor))
				}

				it("AndesThumbnail is now Loud and new accentColor") {
					let accentColor = UIColor.Andes.green500
					thumbnail.hierarchy = .loud
					thumbnail.accentColor = accentColor
					let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
					expect(configuration.backgroundColor).to(equal(accentColor))
					expect(configuration.iconColor).to(equal(UIColor.white))
				}

				it("AndesThumbnail change size to 80") {
					thumbnail.size = .size80
					let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
					expect(configuration.size).to(equal(80.0))
				}

				it("AndesThumbnail change state") {
					let backgroundColor = UIColor.white
					let iconColor = UIColor.Andes.gray250
					thumbnail.state = .disabled
					let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
					expect(configuration.backgroundColor).to(equal(backgroundColor))
					expect(configuration.iconColor).to(equal(iconColor))
				}

				it("AndesThumbnail change type") {
					let imageV = UIImage(imageLiteralResourceName: "thumbnailImageVertical")
					thumbnail.type = .imageSquare
					thumbnail.image = imageV
					let configuration = AndesThumbnailViewConfigFactory.provide(for: thumbnail)
					expect(configuration.backgroundColor).to(equal(UIColor.white))
					expect(configuration.borderColor).to(equal(UIColor.Andes.gray070))
					expect(configuration.cornerRadius).to(equal(3.0))
					expect(configuration.image).to(equal(imageV))
				}
			}
		}
	}
}
