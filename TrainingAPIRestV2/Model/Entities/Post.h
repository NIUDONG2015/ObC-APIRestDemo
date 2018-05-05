//
//  Post.h
//  TrainingAPIRestV2
//
//  Created by Isaías on 5/4/18.
//  Copyright © 2018 Isaías. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

@property (nonatomic) int pid;
@property (nonatomic) int userId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *body;

-(id)initWithPid:(int)pid userId:(int)userId;
@end
