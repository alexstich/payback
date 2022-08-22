
import UIKit
import SnapKit
import RxSwift

class FeedViewController: UIViewController
{
    var ps_clicked_shoping_tile:  PublishSubject<Void> = PublishSubject()

    var table:  FeedTable!
    
    var features: [ModelFeature] = []
    {
        didSet{
            table.features = features
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        table = FeedTable(vc: self)
        table.delegate = self
        
        setupViews()
        
        title = "Feed"
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkLastUpdatingDate), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func checkLastUpdatingDate()
    {
        if let lastDateString = LocalData.getLastUpdatingDate() {
            if let lastDate = try? lastDateString.convertToDate(format: DateManager.FORMAT_AS_SERVER), lastDate.addDays(days: 1) < Date() {
                loadFeatures()
            } else {
                let features = getStoredFeatures()
                addFeatures(features: features)
            }
        } else {
            loadFeatures()
        }
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupViews()
    {
        self.view.backgroundColor = MyColors.feed_background.getUIColor()
        
        self.view.addSubview(table)
        
        table.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    @objc
    func loadFeatures()
    {
        let provider = NetworkProvider(showProgress: true, showErrorAlert: true)
        var resource = FeaturesIndexResource()
        resource.parameters = [
            "alt": "media",
            "token": "3b3606dd-1d09-4021-a013-a30e958ad930"
        ]
        
        provider.makeAPIRequest(
            resource: resource,
            onSuccess: { [weak self] response in
                if let features = response?.features  {
                    self?.addFeatures(features: features)
                    
                    // Save last updating date
                    LocalData.saveLastUpdatingDate(date: Date().formatToString(format: DateManager.FORMAT_AS_SERVER))
                }
            },onError: { [weak self] _ in
                if let features = self?.getStoredFeatures() {
                    self?.addFeatures(features: features)
                }
            }
        )
    }
    
    var filePath: URL = {
        let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let fileName = "features"
        return dir.appendingPathComponent(fileName)
    }()
    
    private func getStoredFeatures() -> [ModelFeature]
    {
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: filePath.path) {
            if let data = try? Data(contentsOf: filePath) {
                let decoder = GlobalHelper.globalJsonDecoder
                let features = try? decoder.decode([ModelFeature].self, from: data)
                return features ?? []
            }
        }
        
        return [ModelFeature]()
    }
    
    private func addFeatures(features: [ModelFeature])
    {
        var features = features
        
        features = features.sorted(by: { (a,b) in
            a.score! > b.score!
        })
        
        self.features = features
        
        saveFeaturesToFile(features: features)
    }
    
    private func saveFeaturesToFile(features: [ModelFeature])
    {
        let encoder = GlobalHelper.globalJsonEncoder
        if let data = try? encoder.encode(features) {
            do {
                try data.write(to: filePath)
            } catch {
                print("Unexpected error: \(error).")
            }
        }
    }
}


extension FeedViewController: FeedTableDelegate
{
    func clickedTile(feature: ModelFeature)
    {
        if feature.isWebsite(), feature.data != nil {
            let webViewVC = WebViewController()
            webViewVC.urlString = feature.data!
            self.present(webViewVC, animated: true, completion: nil)
        }
        if feature.isImage(), feature.data != nil, let url = URL(string: feature.data!) {
            let viewer = ImageViewer(presented_vc: self, images_urls: [url], image_index_to_show: 0)
            viewer.showViewer()
        }
        if feature.isShoppingList(){
            ps_clicked_shoping_tile.onNext(())
        }
        
    }
}


