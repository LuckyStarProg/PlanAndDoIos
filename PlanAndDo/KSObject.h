//
//  KSObject.h
//  PlanAndDo
//
//  Created by Амин on 08.09.16.
//  Copyright © 2016 TodoTeamGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSObject : NSObject
@property (nonatomic) NSDictionary * serverJSon;
@property (nonatomic) int ID;
@property (nonatomic) NSUInteger syncStatus;
@end
