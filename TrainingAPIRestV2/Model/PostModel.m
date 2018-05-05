//
//  PostModel.m
//  TrainingAPIRestV2
//
//  Created by Isaías on 5/4/18.
//  Copyright © 2018 Isaías. All rights reserved.
//

#import "PostModel.h"
#import "Constants.h"

@interface PostModel()

@property (nonatomic, strong) AFHTTPSessionManager *AFManager;

@end


@implementation PostModel

-(id)init{
    if (self = [super init]) {
        _AFManager = [AFHTTPSessionManager manager];
    }
    return self;
}

-(void)getPostsWithDelegation{
    [self.AFManager GET:URL_POSTS parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *jsonObject = (NSArray *)responseObject;
        NSArray<Post *> *postArray = [self parseJSONtoPost:jsonObject];
        [self.delegate didReceiveData:YES WithResponse:postArray];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate didReceiveData:NO WithResponse:nil];
    }];
}

-(void)getPostsWithCallback:(void (^)(BOOL, NSArray<Post *> *))callbackBlock{
    [self.AFManager GET:URL_POSTS parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *jsonObject = (NSArray *)responseObject;
        NSArray<Post *> *postArray = [self parseJSONtoPost:jsonObject];
        callbackBlock(YES, postArray);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        callbackBlock(NO, nil);
    }];
}


-(void)getPostsWithNotification{
    [self.AFManager GET:URL_POSTS parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *jsonObject = (NSArray *)responseObject;
        NSArray<Post *> *postArray = [self parseJSONtoPost:jsonObject];
        
        NSDictionary *userInfo = @{KEY_POST_DATA: postArray};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NC_GET_DATA object:nil userInfo:userInfo];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(NSArray<Post *> *)parseJSONtoPost:(NSArray *)postArray{
    NSMutableArray<Post *> *arr = [[NSMutableArray<Post *> alloc] init];
    
    for (NSDictionary *dict in postArray) {
        int pid = [[dict valueForKey:KEY_ID] intValue];
        int userId = [[dict valueForKey:KEY_USER_ID] intValue];
        NSString *title = [dict valueForKey:KEY_TITLE];
        NSString *body = [dict valueForKey:KEY_BODY];
        
        Post *post = [[Post alloc] initWithPid:pid userId:userId];
        post.title = title;
        post.body = body;
        
        [arr addObject:post];
    }
    
    return (NSArray *) arr;
}

@end
