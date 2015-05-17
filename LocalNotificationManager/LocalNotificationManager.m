//
//  LocalNotificationManager.m
//  LocalNotificationManager
//
//  Created by KentarOu on 2015/03/21.
//  Copyright (c) 2015年 KentarOu. All rights reserved.
//

#import "LocalNotificationManager.h"

@interface LocalNotificationManager()
{
    //  現在ローカル通知が許可されているかどうかのフラグ(iOS8)
    BOOL isAcceptNotification;
    UIUserNotificationSettings *currentSettings;
}

@end

@implementation LocalNotificationManager


static LocalNotificationManager *sharedInstance = nil;

+ (LocalNotificationManager *)sharedManager{
    @synchronized(self){
        if (!sharedInstance) {
            sharedInstance = [LocalNotificationManager new];
        }
    }
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        // バックグラウンド移行時通知を登録する為の通知を登録
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLocalNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
        
        currentSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
        isAcceptNotification = currentSettings.types == UIUserNotificationTypeNone? NO:YES;
    }
    return self;
}

- (void)dealloc {
    // 通知を削除
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


// ユーザーに対してローカル通知の許可を求める
- (void)requestUserNotification {
    
    UIApplication *application = [UIApplication sharedApplication];

    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        
        // iOS8からユーザーの許可を求める事が必須
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
        
        if (currentSettings.types == UIUserNotificationTypeNone) {
            // 通知がOFFに設定されていた場合アラートを出す等の対応
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ローカル通知"
                                                            message:@"通知が許可されていません\n設定->通知から許可してください"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
    } else {
        
        
        
    }
}



- (void)setLocalNotification {
    
    if (currentSettings.types == UIUserNotificationTypeNone) {
        isAcceptNotification = NO;
        NSLog(@"通知が許可されていない");
        return;
    } else  {
        isAcceptNotification = YES;
        NSLog(@"通知を登録する");
    }
    
    // 登録前に全ての通知を削除する
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    NSDate *fireDate = [NSDate date];
    
    NSDictionary *userInfo = @{@"title":@"Alert Title",
                               @"message":@"Alert Message"};
    
//    if (fireDate == nil || [fireDate timeIntervalSinceNow] <= 0) {
//        return;
//    }
    [self schedule:fireDate userInfo:userInfo];
    
    [self scheduledLocalNotifications];
}

- (void)schedule:(NSDate *) fireDate userInfo:(NSDictionary *) userInfo {
    
    // ローカル通知を作成する
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [[NSDate date] dateByAddingTimeInterval: 10];
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.userInfo = userInfo;
    notification.alertBody = @"通知が届きました";
    notification.alertAction = @"開く";
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    // ローカル通知登録
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
}

// 現在設定されている通知をログ出力
- (void)scheduledLocalNotifications {
    
    NSArray *notifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *notification in notifications) {
        NSLog(@"LocalNotification title = %@, message = %@, 通知日 = %@",notification.userInfo[@"title"],notification.userInfo[@"message"],notification.fireDate);
        
        NSLog(@"LocalNotification = %@",notification);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
    }
    NSLog(@"test2");
}

@end
