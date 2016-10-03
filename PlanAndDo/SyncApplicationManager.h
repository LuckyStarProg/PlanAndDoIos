//
//  SyncApplicationManager.h
//  PlanAndDo
//
//  Created by Arthur Chistyak on 22.09.16.
//  Copyright © 2016 TodoTeamGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserApiManager.h"
#import "SettingsApiManager.h"
#import "CategoryApiManager.h"
#import "TasksApiManager.h"
#import "SubTasksApiManager.h"
#import "SyncApiManager.h"

@interface SyncApplicationManager : NSObject
@property int lst;

-(void)syncWithCompletion:(void (^)(bool))completed;


-(void) syncUserWithCompletion:(void (^)(bool))completed;

-(void) syncSettingsWithCompletion:(void (^)(bool))completed;

-(void) syncCategoriesWithCompletion:(void (^)(bool))completed;

-(void) syncTasksWithCompletion:(void (^)(bool))completed;

-(void) syncSubTasksWithCompletion:(void (^)(bool))completed;



@end
