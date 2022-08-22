import UIKit
import AVKit

class PlayerVc: AVPlayerViewController
{
    var playerLooper: AVPlayerLooper?
    
    init()
    {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        hideBackground()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hideBackground()
    {
        let iv = UIView()
        
        iv.backgroundColor = MyColors.gray_light.getUIColor()
        
        self.contentOverlayView!.addSubview(iv)
        
        let v = self.contentOverlayView!
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iv.bottomAnchor.constraint(equalTo:v.bottomAnchor),
            iv.topAnchor.constraint(equalTo:v.topAnchor),
            iv.leadingAnchor.constraint(equalTo:v.leadingAnchor),
            iv.trailingAnchor.constraint(equalTo:v.trailingAnchor),
        ])
        
        self.view.addSubview(self.contentOverlayView!)
        self.contentOverlayView?.layer.zPosition = -1
        self.contentOverlayView!.snp.makeConstraints(
            { make in

                make.edges.equalToSuperview()
        })
    }
}
