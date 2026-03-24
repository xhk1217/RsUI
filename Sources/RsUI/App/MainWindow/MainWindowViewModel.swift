import Foundation
import Observation

@Observable
class MainWindowViewModel {
    var backwardViews: [View] = []
    var forwardViews: [View] = []
    var currentView: View? = nil
}