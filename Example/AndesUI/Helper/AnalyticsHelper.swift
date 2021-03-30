//
//  AnalyticsHelper.swift
//  AndesUI-demoapp
//
//  Created by Daniel Esteban Beltran Beltran on 12/02/21.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

import Foundation
import FirebaseAnalytics

enum ScreenTypeEvent: String {
    case dynamicScreen = "'\'dynamic"
    case staticScreen = "'\'static"
}

class AnalyticsHelper {

    private var viewAndPath: [String: String] = [
        "TooltipObjcViewController": ScreenTypeEvent.dynamicScreen.rawValue,
        "TooltipViewController": ScreenTypeEvent.dynamicScreen.rawValue,
        "AndesBadgeExtensionTabBarController": ScreenTypeEvent.dynamicScreen.rawValue,
        "CoachmarkViewController": ScreenTypeEvent.dynamicScreen.rawValue,
        "CoachmarkObjCViewController": ScreenTypeEvent.staticScreen.rawValue,
        "BottomSheetSwiftExampleViewController": ScreenTypeEvent.dynamicScreen.rawValue,
        "BottomSheetObjectiveCExampleViewController": ScreenTypeEvent.staticScreen.rawValue,
        "ButtonsViewController": ScreenTypeEvent.staticScreen.rawValue,
        "MessageViewController": ScreenTypeEvent.dynamicScreen.rawValue,
        "MessageObjCViewController": ScreenTypeEvent.staticScreen.rawValue,
        "TextFieldViewController": "'\'textfield\(ScreenTypeEvent.dynamicScreen.rawValue)",
        "TextAreaViewController": "'\'textarea\(ScreenTypeEvent.dynamicScreen.rawValue)",
        "TextFieldObjCViewController": "'\'textfield\(ScreenTypeEvent.staticScreen.rawValue)",
        "TextFieldsCodeViewController": "'\'textcode\(ScreenTypeEvent.dynamicScreen.rawValue)",
        "TextFieldsCodeObjCViewController": "'\'textcode\(ScreenTypeEvent.staticScreen.rawValue)",
        "AndesRadioButtonViewController": "''\'radiobutton\(ScreenTypeEvent.dynamicScreen.rawValue)",
        "RadioButtonObjCViewController": "''\'radiobutton\(ScreenTypeEvent.staticScreen.rawValue)",
        "AndesCheckboxInitViewController": ScreenTypeEvent.dynamicScreen.rawValue,
        "CheckboxObjCViewController": ScreenTypeEvent.staticScreen.rawValue,
        "AndesCheckboxViewController": ScreenTypeEvent.staticScreen.rawValue,
        "TagViewController": "'\'simple\(ScreenTypeEvent.dynamicScreen.rawValue)",
        "TagObjCViewController": "'\'simple\(ScreenTypeEvent.staticScreen.rawValue)",
        "TagChoiceObjCViewController": "'\'choice\(ScreenTypeEvent.staticScreen.rawValue)",
        "SnackbarViewController": ScreenTypeEvent.dynamicScreen.rawValue,
        "SnackbarObjCViewController": ScreenTypeEvent.staticScreen.rawValue,
        "CardViewController": ScreenTypeEvent.dynamicScreen.rawValue,
        "CardObjCViewController": ScreenTypeEvent.staticScreen.rawValue,
        "DatePickerViewController": ScreenTypeEvent.dynamicScreen.rawValue,
        "ThumbnailViewController": ScreenTypeEvent.staticScreen.rawValue,
        "ThumbnailObjCViewController": ScreenTypeEvent.staticScreen.rawValue,
        "ListViewController": ScreenTypeEvent.dynamicScreen.rawValue,
        "ListObjcViewController": ScreenTypeEvent.staticScreen.rawValue,
        "DropdownViewController": ScreenTypeEvent.dynamicScreen.rawValue,
        "DropDownObjcViewController": ScreenTypeEvent.dynamicScreen.rawValue,
        "BadgeViewController": ScreenTypeEvent.dynamicScreen.rawValue,
        "BadgeObjCViewController": ScreenTypeEvent.staticScreen.rawValue
    ]

    func createPathWith(_ component: String, view: String, variation: String? = nil) {
        guard let typeOfScreen = viewAndPath[view] else {return}

        let componentWhitoutAndes = component.lowercased().replacingOccurrences(of: "andes", with: "")
        let languaje = view.lowercased().contains("objc") ? "objc" : "swift"
        let screenPath = "\(componentWhitoutAndes)\(typeOfScreen)"

        sendNewTrack(screenClass: component, screenName: screenPath, languaje: languaje)
    }

    private func sendNewTrack(screenClass: String, screenName: String, languaje: String) {
        Analytics.logEvent(AnalyticsEventScreenView,
                           parameters: [AnalyticsParameterScreenName: screenName,
                                        AnalyticsParameterScreenClass: screenClass,
                                        AnalyticsParameterItemCategory: languaje])
    }
}
