
import UIKit
import Kingfisher
import SnapKit
import AVKit

class CellVideo: CellFeature
{
    var playerController: PlayerVc?
    
    let video_layout = UIView()
    
    var videoLayoutHeightConstraint: Constraint?
    let play_btn = UIButton()
    
    var playerDidEndPlay: Bool = false

    override func prepareForReuse()
    {
        playerController?.player?.pause()
        playerController?.player = nil
        
        super.prepareForReuse()
    }
    
    override func setupViews()
    {
        super.setupViews()
        
        btn.addSubview(video_layout)
        
        video_layout.snp.makeConstraints({ make in
            make.top.equalTo(header.snp.bottom)
            make.bottom.equalTo(subline.snp.top)
            make.left.right.equalToSuperview()
            videoLayoutHeightConstraint = make.height.equalTo(200).constraint
        })
    }
    
    override func bindData(feature: ModelFeature, index: Int)
    {
        super.bindData(feature: feature, index: index)
        
        videoLayoutHeightConstraint?.layoutConstraints.first?.constant = tiledefaultHeight + (feature.headline != nil ? 0 : 50) + (feature.subline != nil ? 0 : 50)
        
        if feature.data != nil {
            self.bindVideoToView(url: URL(string: feature.data!)!)
        }
    }
    
    func bindVideoToView(url: URL)
    {
        play_btn.removeFromSuperview()
        
        playerController?.view.addSubview(play_btn)
        play_btn.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        play_btn.removeTarget(self, action: #selector(clickedTile), for: .touchUpInside)
        play_btn.addTarget(self, action: #selector(clickedTile), for: .touchUpInside)
        
        playerController?.player?.pause()
        playerController?.player = nil
        
        playerDidEndPlay = false
        
        playerController?.player = AVPlayer(url: url)
        playerController?.showsPlaybackControls = false
        
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(videoDidEnded), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerController?.player?.currentItem)
        
        // if loop need
//        playerController?.player = AVQueuePlayer()
//        let asset = AVAsset(url: url)
//        let playerItem = AVPlayerItem(asset: asset)
//        playerController?.playerLooper = AVPlayerLooper(player: playerController!.player as! AVQueuePlayer, templateItem: playerItem)
    }
    
    @objc private func videoDidEnded()
    {
        playerDidEndPlay = true
    }
    
    @objc override func clickedTile()
    {
        if let player = self.playerController?.player {
            if playerDidEndPlay {
                playerDidEndPlay = false
                player.seek(to: CMTime.zero)
                player.play()
            } else if player.timeControlStatus == .playing {
                player.pause()
            } else {
                player.play()
            }
        }
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)

    }
}
