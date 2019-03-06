
#import "ThemesViewController.h"
#import "Themes.h"

@interface ThemesViewController ()

@end

@implementation ThemesViewController{
    
    IBOutlet UIButton *changeColorButton1;
    IBOutlet UIButton *changeColorButton2;
    IBOutlet UIButton *changeColorButton3;
    //    - (void) doSomething{
//        // Do cool things here.
//        // Now call delegate, in this example, this will be ClassB
//        //[themesViewControllerDelegate didDoSomethingCool:@"Hello from Class A"];
//        self.view.backgroundColor = [UIColor redColor];
//    }


}
- (void) doSomething{
        // Do cool things here.
        // Now call delegate, in this example, this will be ClassB
        //[themesViewControllerDelegate didDoSomethingCool:@"Hello from Class A"];
        self.view.backgroundColor = [UIColor redColor];
}
- (IBAction)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

-(IBAction)changColor:(UIButton *)sender{
    //NSLog(@"%i", (UIButton *)sender.tag);

//    if (sender.selected)
//        return;
    Themes *theme = [[Themes alloc]init: UIColor.redColor theme2:UIColor.greenColor theme3:UIColor.yellowColor];
    UIColor *selectedThemeColor;
    switch (sender.tag) {
        case 1:
            selectedThemeColor = theme.theme1;
            break;

        case 2:
            selectedThemeColor = theme.theme2;
            break;

        case 3:
            selectedThemeColor = theme.theme3;
            break;

        default:
            // default value
            selectedThemeColor = [UIColor whiteColor];
            break;
    }
    
    self.view.backgroundColor = selectedThemeColor;
    NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:selectedThemeColor];
    [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:@"myColor"];
    [self.themesViewControllerDelegate themesViewController:self didSelectTheme:selectedThemeColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewDidLoad];
    NSData *colorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"myColor"];
    UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
    self.view.backgroundColor = color;
}

- (void)dealloc {
    [changeColorButton1 release];
    [changeColorButton2 release];
    [changeColorButton3 release];
    [super dealloc];
}
@end

