
@import Foundation;
@class ThemesViewController;

@protocol ThemesViewControllerDelegate <NSObject>

- (void)themesViewController:(ThemesViewController *)controller didSelectTheme:(UIColor *)selectedTheme;

@end
