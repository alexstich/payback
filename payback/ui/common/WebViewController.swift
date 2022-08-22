import UIKit
import WebKit

class WebViewController: UIViewController
{
    public var urlString: String! {
        didSet {
            if let url = URL(string: urlString) {
                let urlRequest = URLRequest(url:url)
                self.webView.load(urlRequest)
            }
        }
    }

    public lazy var webView: WKWebView = {
        
        let webView = WKWebView()
        webView.navigationDelegate = self
        
        return webView
    }()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.addSubview(self.webView)
        
        self.webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // Show here a HUD or any loader
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Dismiss your HUD
    }
}
