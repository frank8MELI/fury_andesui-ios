# Andes UI

How to use:

Add `pod 'AndesUI'` dependency in podspec/podfile, run pod install.

Note: AndesUI manages colors and fonts through **AndesStyleSheetManager**, all components should use it to get their style constants as defined by UX [here](https://company-161429.frontify.com/d/kxHCRixezmfK/n-a), this will allow us to inject the different style from each app.

When the app initializes **AndesStyleSheetManager** is set up with a class that implements _AndesStyleSheetProtocol_, if no implementation is given, by default _AndesStyleSheetDefault_ will be used.

eg: `AndesStyleSheetManager.styleSheet = AndesStyleSheetDefault()`

check each component's entry on the wiki to get instructions on how to use them.