import UIKit

class VerticalProgressView: UIView {

    fileprivate var progressLayer = CAShapeLayer()
    fileprivate var trackLayer = CAShapeLayer()
    fileprivate let lineWidth: CGFloat?

    var timeToFill = 1.0

    var progressColor = UIColor.myDarkGreen {
        didSet {
            progressLayer.backgroundColor = progressColor.cgColor
        }
    }

    var trackColor = UIColor.black.withAlphaComponent(0.3) {
        didSet {
            trackLayer.backgroundColor = trackColor.cgColor
        }
    }

var progress: Float = 0 {
        didSet {
            updateProgress()
        }
    }

    fileprivate func createProgressView() {
        self.backgroundColor = .clear

        // Track layer (static background layer)
        trackLayer.backgroundColor = trackColor.cgColor
        trackLayer.frame = bounds
        trackLayer.cornerRadius = bounds.width / 2
        layer.addSublayer(trackLayer)

        // Progress layer (dynamic foreground layer)
        progressLayer.backgroundColor = progressColor.cgColor
        progressLayer.frame = CGRect(x: 0, y: bounds.height, width: bounds.width, height: 0)
        progressLayer.cornerRadius = trackLayer.bounds.width / 2
        layer.addSublayer(progressLayer)
    }

    func updateProgress() {
        let newHeight = bounds.height * CGFloat(progress)
        let newFrame = CGRect(x: 0, y: bounds.height - newHeight - 4, width: bounds.width, height: newHeight)

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        progressLayer.frame = newFrame
        CATransaction.commit()
    }

    func setProgress(duration: TimeInterval = 3, to newProgress: Float) {
        let animation = CABasicAnimation(keyPath: "bounds.size.height")
        animation.duration = duration
        animation.fromValue = progressLayer.bounds.height
        animation.toValue = bounds.height * CGFloat(newProgress)
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        progressLayer.add(animation, forKey: "progress")

        progressLayer.frame = CGRect(x: 0, y: bounds.height - bounds.height * CGFloat(newProgress), width: bounds.width, height: bounds.height * CGFloat(newProgress))
    }

    override init(frame: CGRect) {
        lineWidth = 15
        super.init(frame: frame)
        createProgressView()
    }

    required init?(coder: NSCoder) {
        lineWidth = 15
        super.init(coder: coder)
        createProgressView()
    }

    init(frame: CGRect, lineWidth: CGFloat?) {
        self.lineWidth = lineWidth
        super.init(frame: frame)
        createProgressView()
    }
}
