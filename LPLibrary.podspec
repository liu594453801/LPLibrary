Pod::Spec.new do |s|
    s.name         = "LPLibrary"
    s.version      = "1.0.3"
    s.summary      = "custom LPLibrary"
    s.homepage     = "https://github.com/liu594453801/LPLibrary"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.authors      = { "liu594453801" => "594453801@qq.com" }
    s.platform     = :ios, "9.0"
    s.source       = {:git => "https://github.com/liu594453801/LPLibrary.git", :tag => s.version}
    s.source_files = "LPLibrary/*.{h,m}"
    s.requires_arc = true

    s.subspec 'Category' do |ss|
    ss.source_files = 'LPLibrary/NSDate+Tool.{h,m}','LPLibrary/NSDictionary+Tool.{h,m}','LPLibrary/NSString+Tool.{h,m}','LPLibrary/NSString+XPath.{h,m}','LPLibrary/UIBarButtonItem+Tool.{h,m}','LPLibrary/UIButton+Addition.{h,m}','LPLibrary/UIFont+CustomFont.{h,m}','LPLibrary/UIImage+Tool.{h,m}','LPLibrary/UILabel+Tool.{h,m}','LPLibrary/UITabBar+badge.{h,m}','LPLibrary/UIViewExt.{h,m}'
    ss.public_header_files = 'LPLibrary/NSDate+Tool.h','LPLibrary/NSDictionary+Tool.h','LPLibrary/NSString+Tool.h','LPLibrary/NSString+XPath.h','LPLibrary/UIBarButtonItem+Tool.h','LPLibrary/UIButton+Addition.h','LPLibrary/UIFont+CustomFont.h','LPLibrary/UIImage+Tool.h','LPLibrary/UILabel+Tool.h','LPLibrary/UITabBar+badge.h','LPLibrary/UIViewExt.h'
    ss.frameworks = 'SystemConfiguration'
  end

    s.subspec 'GTMBase64' do |ss|
    ss.source_files = 'LPLibrary/GTMBase64.{h,m}'
    ss.public_header_files = 'LPLibrary/GTMBase64.h','LPLibrary/GTMDefines.h'
    ss.frameworks = 'SystemConfiguration'
  end

    s.subspec 'Macro' do |ss|
    ss.source_files = 'LPLibrary/MacroDefine.{h,m}'
    ss.public_header_files = 'LPLibrary/MacroDefine.h'
    ss.frameworks = 'SystemConfiguration'
  end

    s.subspec 'Tool' do |ss|
    ss.source_files = 'LPLibrary/BCSLocationManager.{h,m}','LPLibrary/BCSQRCode.{h,m}','LPLibrary/DeviceTool.{h,m}','LPLibrary/JZLocationConverter.{h,m}','LPLibrary/KeyChainTool.{h,m}','LPLibrary/PublicClass.{h,m}'
    ss.public_header_files = 'LPLibrary/BCSLocationManager.h','LPLibrary/BCSQRCode.h','LPLibrary/DeviceTool.h','LPLibrary/JZLocationConverter.h','LPLibrary/KeyChainTool.h','LPLibrary/PublicClass.h'
    ss.frameworks = 'SystemConfiguration'
  end

end