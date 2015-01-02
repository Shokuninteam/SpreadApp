import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    let pagesIdentifiers = ["profil", "feed", "notes"]
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.hidden = true
        self.dataSource = self
        self.delegate = self
        
        let startingViewController = self.storyboard!.instantiateViewControllerWithIdentifier(pagesIdentifiers[1]) as UIPageTargetViewController
        
        let viewControllers: NSArray = [startingViewController]
        
        self.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)

    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var controller : UIPageTargetViewController = viewController as UIPageTargetViewController
        var index = controller.index
        if index == 1 {
            return self.storyboard!.instantiateViewControllerWithIdentifier(pagesIdentifiers[0]) as? UIPageTargetViewController
        } else if index == 2 {
            return self.storyboard!.instantiateViewControllerWithIdentifier(pagesIdentifiers[1]) as? UIPageTargetViewController
        } else {
            return nil
        }
        
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var controller : UIPageTargetViewController = viewController as UIPageTargetViewController
        var index = controller.index
        if index == 0 {
            return self.storyboard!.instantiateViewControllerWithIdentifier(pagesIdentifiers[1]) as? UIPageTargetViewController
        } else if index == 1 {
            return self.storyboard!.instantiateViewControllerWithIdentifier(pagesIdentifiers[2]) as? UIPageTargetViewController
        } else {
            return nil
        }
        
    }
}
