//
//  PostModel.h
//  TrainingAPIRestV2
//
//  Created by Isaías on 5/4/18.
//  Copyright © 2018 Isaías. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Post.h"

@protocol PostModelDelegate

@required

-(void)didReceiveData:(BOOL)status WithResponse:(NSArray<Post *> *)response;

@end

@interface PostModel : NSObject

@property (nonatomic, assign) id <PostModelDelegate> delegate;

-(void)getPostsWithDelegation;
-(void)getPostsWithCallback:(void (^)(BOOL, NSArray<Post *> *))callbackBlock;
-(void)getPostsWithNotification;

@end
