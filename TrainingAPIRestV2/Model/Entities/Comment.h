//
//  Comment.h
//  TrainingAPIRestV2
//
//  Created by Isaías on 5/4/18.
//  Copyright © 2018 Isaías. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

@interface Comment : NSObject

@property (nonatomic, strong) Post *post;
@property (nonatomic) int mid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *body;

-(id)initWithPost:(Post *)post andId:(int)mId;
@end
