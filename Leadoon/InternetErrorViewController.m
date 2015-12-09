//
//  InernetErrorViewController.m
//  Leadoon
//
//  Created by Кирилл Ковыршин on 09.12.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "InternetErrorViewController.h"
#import "Reachability.h"
#import "MainView.h"


@interface InternetErrorViewController ()
@property (assign,nonatomic) BOOL isError;

@end

@implementation InternetErrorViewController





-(void) showHideAlert: (NSString*)result{
    
    if([result isEqualToString:@"0"]){
        NSLog(@"error Connection");
        self.isError = YES;
        
    }else{
        if(self.isError==YES){
            self.isError = NO;
            MainView* detail = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
            [self.navigationController pushViewController:detail animated:YES];
        }

    }
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
