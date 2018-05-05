//
//  Comment.m
//  TrainingAPIRestV2
//
//  Created by Isaías on 5/4/18.
//  Copyright © 2018 Isaías. All rights reserved.
//

#import "Comment.h"

@implementation Comment

-(id)initWithPost:(Post *)post andId:(int)mId{
    if (self = [super init]) {
        self.post = post;
        self.mid = mId;
    }
    return self;
}

@end
