import Foundation
import SwiftEntryKit

protocol AlertsManagerProtocol
{
    func show(alertType: AlertMessageType, data: Any)
    func show(text: String, type: AlertType, image: UIImage?, name: String?)
    
    var overlappingProgressSpinner: OverlappingProgressSpinner { get set}
}

enum AlertType
{
    case alert
    case warning
    case info
    case permanent
    
    func getBackgroundColor() -> UIColor
    {
        let color: UIColor
        
        switch self {
        case .alert:
            color = MyColors.alert_background.getUIColor()
        case .warning:
            color = MyColors.warning_background.getUIColor()
        case .info:
            color = MyColors.info_background.getUIColor()
        case .permanent:
            color = .clear
        }
        
        return color
    }
}

enum AlertStandartTypeName: String
{
    case alert
    case progress_spinner
    case sync_in_process
    case network_is_absent
    case auth_error
    case connection_error
}

enum AlertMessageType
{
    case errorDefault
}

class AlertsManager: AlertsManagerProtocol
{
    static let getInstance = AlertsManager()
    
    internal var overlappingProgressSpinner: OverlappingProgressSpinner = OverlappingProgressSpinner()
    
    private init() {}
    
    public func show(text: String, type: AlertType, image: UIImage? = nil, name: String? = nil)
    {
        if SwiftEntryKit.isCurrentlyDisplaying(entryNamed: (name ?? AlertStandartTypeName.alert.rawValue)) { return }
        
        if SwiftEntryKit.isCurrentlyDisplaying(entryNamed: AlertStandartTypeName.progress_spinner.rawValue) {
            overlappingProgressSpinner.isHidden = true
            dismissProgressSpinner()
        }
        
        let view = AlertView(image: image, text: text, type: type)
        view.snp.makeConstraints({ make in
            let height = view.getAlertViewHeight()
            make.height.equalTo(height)
        })
        
        let attributes = self.getAttributes(name: (name ?? AlertStandartTypeName.alert.rawValue), type: type)
        SwiftEntryKit.display(entry: view, using: attributes)
    }
    
    public func hide(name: String? = nil)
    {
        SwiftEntryKit.dismiss(.specific(entryName: name ?? AlertStandartTypeName.alert.rawValue))
    }
    
    public func show(alertType: AlertMessageType, data: Any)
    {
        switch alertType {
        case .errorDefault:
            showErrorDefaultAlert()
        }
    }
    
    private func showErrorDefaultAlert()
    {
        let name = "Error_default"
        
        if SwiftEntryKit.isCurrentlyDisplaying(entryNamed: name) { return }
        
        if SwiftEntryKit.isCurrentlyDisplaying(entryNamed: AlertStandartTypeName.progress_spinner.rawValue) {
            overlappingProgressSpinner.isHidden = true
            dismissProgressSpinner()
        }
        
        let text = ""
        
        let view = AlertView(image: nil, text: text, type: AlertType.alert)
        
        view.snp.makeConstraints({ make in
            let height = view.getAlertViewHeight()
            make.height.equalTo(height)
        })
        let attributes = self.getAttributes(name: name, type: AlertType.alert)
        
        SwiftEntryKit.display(entry: view, using: attributes)
    }
    
    public func showTipAlert(text: String, name: String, duration: Double = 300)
    {
        if SwiftEntryKit.isCurrentlyDisplaying(entryNamed: (name)) { return }
        
        if SwiftEntryKit.isCurrentlyDisplaying(entryNamed: AlertStandartTypeName.progress_spinner.rawValue) {
            overlappingProgressSpinner.isHidden = true
            dismissProgressSpinner()
        }
        
        let view = UIView()
        view.backgroundColor =  MyColors.black.getUIColor().withAlphaComponent(0.5)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = MyColors.gray.getCGColor()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        
        let label = UILabel()
        label.text = text
        label.font = MyFonts.getInstance.reg_s
        label.textColor = MyColors.text.getUIColor()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        
        view.addSubview(label)
        
        if UIDevice.current.isSmall() {
            label.font = MyFonts.getInstance.reg_xs
        } else {
            label.font = MyFonts.getInstance.reg_s
        }
        
        view.snp.makeConstraints({ make in
            make.height.equalTo(30)
        })
        label.snp.makeConstraints({ make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        })
        
        let attributes = self.getAttributesForTipAlert(name: name, duration: duration)
        SwiftEntryKit.display(entry: view, using: attributes)
    }
    
    private func getAttributes(name: String, type: AlertType) -> EKAttributes
    {
        var attributes = EKAttributes()
        
        attributes.name = name
        attributes.windowLevel = .normal
        attributes.position = .top
        attributes.displayDuration = 4
        
        let widthConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 1)
        let heightConstraint = EKAttributes.PositionConstraints.Edge.intrinsic
        attributes.entranceAnimation = .init(
            translate: .init(duration: 0.3),
            scale: .init(from: 1.07, to: 1, duration: 0.3)
        )
        attributes.exitAnimation = .init(translate: .init(duration: 0.3))
        attributes.positionConstraints.size = .init(width: widthConstraint, height: heightConstraint)
        attributes.statusBar = .light
        attributes.entryBackground = .color(color: EKColor.init(type.getBackgroundColor()))
        attributes.positionConstraints.verticalOffset = -GlobalHelper.statusBarHeight
        
        return attributes
    }
    
    private func getAttributesForTipAlert(name: String, duration: Double = 300) -> EKAttributes
    {
        var attributes = EKAttributes()
        
        attributes.name = name
        attributes.windowLevel = .normal
        attributes.position = .top
        attributes.displayDuration = duration
        
        let widthConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 0.9)
        let heightConstraint = EKAttributes.PositionConstraints.Edge.intrinsic
        attributes.entranceAnimation = .init(
            translate: .init(duration: 0.3),
            scale: .init(from: 1.07, to: 1, duration: 0.3)
        )
        attributes.exitAnimation = .init(translate: .init(duration: 0.3))
        attributes.positionConstraints.size = .init(width: widthConstraint, height: heightConstraint)
        attributes.statusBar = .light
        attributes.entryBackground = .color(color: EKColor.init(AlertType.permanent.getBackgroundColor()))
        
        return attributes
    }
}

extension AlertsManager: NSCopying {

    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}

// Overlapping progress spiner
extension AlertsManager
{
    public func dismissProgressSpinner()
    {
        overlappingProgressSpinner.indicator.stopAnimating()
        
        SwiftEntryKit.dismiss(.specific(entryName: AlertStandartTypeName.progress_spinner.rawValue))
    }
    
    public func showProgressSpinner()
    {
        if SwiftEntryKit.isCurrentlyDisplaying(entryNamed: AlertStandartTypeName.progress_spinner.rawValue) {
            return
        }
        
        overlappingProgressSpinner.isHidden = false
        overlappingProgressSpinner.indicator.startAnimating()
        
        var attributes = EKAttributes()
        
        attributes.name = AlertStandartTypeName.progress_spinner.rawValue
        attributes.windowLevel = .statusBar
        attributes.position = .center
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .disabled
        
        let widthConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 1)
        let heightConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 1)
        attributes.entranceAnimation = .init(fade: .init(from: 0.0, to: 1, duration: 0.3))
        attributes.exitAnimation = .init(fade: .init(from: 1, to: 0, duration: 0.3))
        attributes.positionConstraints.size = .init(width: widthConstraint, height: heightConstraint)
        attributes.displayDuration = 30
        
        SwiftEntryKit.display(entry: overlappingProgressSpinner, using: attributes)
    }
}
