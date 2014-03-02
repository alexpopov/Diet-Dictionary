//
//  FoodInfo.m
//  CodeTest
//
//  Created by Alex Popov II on 2014-03-01.
//  Copyright (c) 2014 Alex Popov II. All rights reserved.
//

#import "FoodInfo.h"

@implementation FoodInfo

- (id)initWithFoodID:(int)fd_id name:(NSString *)name group:(NSString *)group {
    if ((self = [super init])) {
        self.fd_id = fd_id;
        self.name = name;
        self.group = group;
    }
    return self;
}

@end
