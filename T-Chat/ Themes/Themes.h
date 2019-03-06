#import <UIKit/UIKit.h>

@interface Themes: NSObject

@property (nonatomic, retain) UIColor *theme1;
@property (nonatomic, retain) UIColor *theme2;
@property (nonatomic, retain) UIColor *theme3;

- (instancetype)init:(UIColor *)theme1 theme2:(UIColor *)theme2 theme3:(UIColor *)theme3;

@end
