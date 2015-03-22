//
//  ViewController.m
//  LocalNotificationManager
//
//  Created by KentarOu on 2015/03/21.
//  Copyright (c) 2015年 KentarOu. All rights reserved.
//

#import "ViewController.h"
#import "LocalNotificationManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    

    
   // [LocalNotificationManager setLocalNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)requestButton:(id)sender {
    
     [[LocalNotificationManager sharedManager] requestUserNotification];
}

- (IBAction)notification:(id)sender {
    
    [[LocalNotificationManager sharedManager] setLocalNotification];
}


@end
