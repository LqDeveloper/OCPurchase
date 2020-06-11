#
#  Be sure to run `pod spec lint OCPurchase.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "OCPurchase"
  spec.version      = "0.0.2"
  spec.summary      = "OCPurchase 是针对iOS内购写的一个工具类"
  spec.description  = <<-DESC
                         包含了获取产品列表，购买，restore，获取验证receipt
                      DESC
  spec.homepage     = "https://github.com/LqDeveloper/OCPurchase"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Quan Li" => "1083099465@qq.com" }
  spec.platform     = :ios, "9.0"
  spec.requires_arc = true
  spec.default_subspec = 'Core'
  spec.cocoapods_version = '>= 1.4.0' 
  spec.source       = { :git => "https://github.com/LqDeveloper/OCPurchase.git", :tag => "#{spec.version}" }


  spec.subspec  'Core' do |sub|
    sub.source_files  = "OCPurchase/Core/**/*.{h,m}"
    sub.frameworks  = "Foundation","StoreKit"
  end

end
