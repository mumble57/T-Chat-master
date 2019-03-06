
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Themes.h"


@implementation Themes

UIColor* _theme1;
UIColor* _theme2;
UIColor* _theme3;


- (instancetype)init:(UIColor *)theme1 theme2:(UIColor *)theme2 theme3:(UIColor *)theme3
{
    self = [super init];
    if (self) {
        _theme1 = theme1;
        _theme2 = theme2;
        _theme3 = theme3;
    }
    return self;
}

- (UIColor *)theme1
{
    return _theme1;
}

- (UIColor *)theme2
{
    return _theme2;
}

- (UIColor *)theme3
{
    return _theme3;
}

- (void)setTheme1:(UIColor *)theme1
{
    _theme1 = theme1;
}

- (void)setTheme2:(UIColor *)theme2
{
    _theme2 = theme2;
}

- (void)setTheme3:(UIColor *)theme3
{
    _theme3 = theme3;
}

@end
