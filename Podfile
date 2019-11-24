source 'https://github.com/CocoaPods/Specs.git'

platform :ios, "13.0"
use_frameworks!
inhibit_all_warnings!

def shared_pods
  pod "SDWebImage", "5.3.2"
end

target "Cuadrado" do
  shared_pods
end

target "Specs" do
  shared_pods

  pod "Quick"
  pod "Nimble"
end
