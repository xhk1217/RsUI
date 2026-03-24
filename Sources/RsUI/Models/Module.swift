import Foundation
import WindowsFoundation
import WinUI
import RsHelper

/// 模块协议，定义了模块的标准接口
public protocol Module : ExpressibleByEmptyLiteral {
    /// 模块的唯一标识符
    var id: String { get }

    func register(in context: WindowContext)

    func registerNavigationViewItems(in context: WindowContext) -> [NavigationViewItemBase]

    func makeSettingsCard() -> UIElement?

    func navigationRequested(for uri: Uri, in context: WindowContext) -> View?
}

public extension Module {
    func register(in context: WindowContext) {
    }

    func registerNavigationViewItems(in context: WindowContext) -> [NavigationViewItemBase] {
        return []
    }

    func makeSettingsCard() -> UIElement? {
        return nil
    }
}
