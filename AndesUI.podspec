Pod::Spec.new do |s|
    s.name             = 'AndesUI'
    s.version          = '3.27.11'
    s.summary          = 'AndesUI library for ios app.'
    
    s.description      = 'AndesUI is the UI library of Mercado Libre. It provides the definitions, components and tools to build consistent experiences, with agility and visual quality.'
    
    s.homepage         = 'https://github.com/mercadolibre/fury_andesui-ios'
    s.license          = spec.license = { :type => 'MIT', :text => <<-LICENSE
        Copyright (c) 2019 Mercado Libre 

        Permission is hereby granted, free of charge, to any person obtaining a copy
        of this software and associated documentation files (the "Software"), to deal
        in the Software without restriction, including without limitation the rights
        to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        copies of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:

        The above copyright notice and this permission notice shall be included in
        all copies or substantial portions of the Software.

        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
        THE SOFTWARE.
      LICENSE
    }
    s.author           = 'Mercado Libre'
    s.source = { :http => "https://mercadolibre.bintray.com/ios-public/AndesUI/#{s.version}/AndesUI.zip" }
    
    s.platform         = :ios, '10.0'
    s.requires_arc     = true
    s.swift_version = '5.0'
    s.default_subspec = 'Core'
    
    s.subspec 'Core' do |core|
        core.source_files = 'LibraryComponents/Classes/Core/**/*.{h,m,swift}'
        core.resource_bundle = {'AndesUIResources' => ['LibraryComponents/Classes/Core/**/*.{xib}',
            'LibraryComponents/Resources/Core/Assets/AndesPaletteColors.xcassets', 'LibraryComponents/Resources/Core/Strings/*.lproj']}
        
        # remove this if we start using remote strategy for icons
        core.dependency 'AndesUI/LocalIcons'
    end
    
    s.subspec 'AndesCoachmark' do |coachmark|
        coachmark.source_files = 'LibraryComponents/Classes/AndesCoachmark/**/*.{h,m,swift}'
        
        coachmark.dependency 'AndesUI/Core'
    end
    
    s.subspec 'AndesBottomSheet' do |bottomsheet|
        bottomsheet.source_files = 'LibraryComponents/Classes/AndesBottomSheet/**/*.{h,m,swift}'
        
        bottomsheet.dependency 'AndesUI/Core'
    end
    
    s.subspec 'AndesDropdown' do |dropdown|
        dropdown.source_files = 'LibraryComponents/Classes/AndesDropdown/**/*.{h,m,swift}'
        dropdown.resource_bundle = {'AndesDropdownResources' => ['LibraryComponents/Classes/AndesDropdown/**/*.{xib}']}
        
        dropdown.dependency 'AndesUI/Core'
        dropdown.dependency 'AndesUI/AndesBottomSheet'
    end
    
    s.subspec 'LocalIcons' do |la|
        la.resource_bundle = {'AndesIcons' => ['LibraryComponents/Resources/LocalIcons/Assets/Images.xcassets']}
    end
end
