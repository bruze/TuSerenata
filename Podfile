#source 'https://github.com/CocoaPods/Specs.git'
#platform :ios, '9.0'

target 'TuSerenata' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TuSerenata
  #Backend
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
  pod 'Firebase/Storage'
  #Side Menu
  pod 'DualSlideMenu'
  #Soporte para widgets especiales
  pod 'LTInfiniteScrollView'
  #Manejo de Teclado
  pod 'IQKeyboardManagerSwift'#, '4.0.5'
  #Herramientas
  pod 'EZSwiftExtensions'#, '1.6'
  #pod 'PropertyExtensions' Deprecated, now using 'AssociatedValues'
  pod 'AssociatedValues'
  #Chat
  pod "JSQMessagesViewController"
  #Pagos
  pod 'PayPal-iOS-SDK'
  #Animación de Carga
  pod 'UCZProgressView'
  #Calendario
  pod 'CVCalendar'#, '1.3.0'
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '3.0'
          end
      end
  end
end
