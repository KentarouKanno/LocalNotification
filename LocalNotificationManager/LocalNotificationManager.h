//
//  LocalNotificationManager.h
//  LocalNotificationManager
//
//  Created by KentarOu on 2015/03/21.
//  Copyright (c) 2015年 KentarOu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LocalNotificationManager : NSObject 

+ (LocalNotificationManager *)sharedManager;

// ユーザーに対してローカル通知の許可を求める
- (void) requestUserNotification;

// ローカル通知を設定する
- (void)setLocalNotification;

@end
