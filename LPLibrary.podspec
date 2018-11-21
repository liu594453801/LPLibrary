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
    ss.source_files = 'LPLibrary/*.{h,m}'
    ss.public_header_files = 'AFNetworking/*.h'
  end

    s.subspec 'GTMBase64' do |ss|
    ss.source_files = 'AFNetworking/*.{h,m}'
    ss.public_header_files = 'AFNetworking/*.h'
  end

    s.subspec 'Macro' do |ss|
    ss.source_files = 'AFNetworking/*.{h,m}'
    ss.public_header_files = 'AFNetworking/*.h'
  end

    s.subspec 'Tool' do |ss|
    ss.source_files = 'AFNetworking/*.{h,m}'
    ss.public_header_files = 'AFNetworking/*.h'
  end

end