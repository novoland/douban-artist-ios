//
//  DAPlayerC.m
//  DoubanArtist
//
//  Created by liujing on 14-11-20.
//
//

#import "DAPlayerC.h"
#import "UIView+Borders.h"

@interface DAPlayerC ()

@end

@implementation DAPlayerC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 1px border at top
    self.view.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addTopBorderWithHeight: 1.0 andColor:[UIColor lightGrayColor]];
    
    // img
    self.trackImg.layer.cornerRadius = self.trackImg.frame.size.width / 2;
    self.trackImg.clipsToBounds = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickListBtn:(id)sender {
}

- (IBAction)clickPlayBtn:(id)sender {
}

- (IBAction)clickNextBtn:(id)sender {
}
@end
