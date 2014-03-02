//
//  FoodInfo.h
//  CodeTest
//
//  Created by Alex Popov II on 2014-03-01.
//  Copyright (c) 2014 Alex Popov II. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodInfo : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *group;
@property (nonatomic, assign) int fd_id;


- (id)initWithFoodID:(int)fd_id name:(NSString *)name group:(NSString *)group;

@end
