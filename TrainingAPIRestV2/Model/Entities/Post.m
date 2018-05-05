//
//  Post.m
//  TrainingAPIRestV2
//
//  Created by Isaías on 5/4/18.
//  Copyright © 2018 Isaías. All rights reserved.
//

#import "Post.h"

@implementation Post

-(id)initWithPid:(int)pid userId:(int)userId{
    if (self = [super init]) {
        self.pid = pid;
        self.userId = userId;
    }
    return self;
}


@end
