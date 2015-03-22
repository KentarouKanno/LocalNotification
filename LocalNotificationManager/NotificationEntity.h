//
//  NotificationEntity.h
//  LocalNotificationManager
//
//  Created by KentarOu on 2015/03/22.
//  Copyright (c) 2015年 KentarOu. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NotificationEntity : NSManagedObject

@property (nonatomic, retain) NSDate * fireDate;
@property (nonatomic, retain) NSString * alertTitle;
@property (nonatomic, retain) NSString * alertMessage;

@end
