#import <UIKit/UIKit.h>
#import "ThemesViewControllerDelegate.h"

@interface ThemesViewController: UIViewController

@property (nonatomic, assign) id<ThemesViewControllerDelegate> themesViewControllerDelegate;

@end

