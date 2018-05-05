//
//  ViewController.m
//  TrainingAPIRestV2
//
//  Created by Isaías on 5/4/18.
//  Copyright © 2018 Isaías. All rights reserved.
//

#import "ViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "AFNetworking.h"
#import "Post.h"
#import "PostModel.h"
#import "Constants.h"
#import "PostCell.h"


@interface ViewController ()<PostModelDelegate, UITableViewDataSource>

@property (nonatomic, strong) PostModel *postModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<Post *> *postsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.postModel.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(postDataReceived:)
                                                 name:NC_GET_DATA
                                               object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)reloadTableView{
    [SVProgressHUD show];
    self.postsArray = nil;
    [self.tableView reloadData];
}

#pragma mark - Lazy
-(PostModel *)postModel{
    if (!_postModel) {
        _postModel = [[PostModel alloc] init];
    }
    
    return _postModel;
}

#pragma mark - NSNotification Center
-(void)postDataReceived:(NSNotification *)data{
    [SVProgressHUD dismiss];
    NSArray<Post *> *postArray = [data.userInfo objectForKey:KEY_POST_DATA];
    self.postsArray = postArray;
    [self.tableView reloadData];
}

#pragma mark - Actions

- (IBAction)callbackAction:(UIButton *)sender {
    [self reloadTableView];
    
    [self.postModel getPostsWithCallback:^(BOOL success, NSArray<Post *> *dataReceived) {
        [SVProgressHUD dismiss];
        if (success) {
            self.postsArray = dataReceived;
            [self.tableView reloadData];
        }
    }];
    
}
- (IBAction)delegationAction:(UIButton *)sender {
    [self reloadTableView];
    [self.postModel getPostsWithDelegation];
}

- (IBAction)notificationAction:(UIButton *)sender {
    [self reloadTableView];
    [self.postModel getPostsWithNotification];
}


#pragma mark - PostModel Delegate
-(void)didReceiveData:(BOOL)status WithResponse:(NSArray<Post *> *)response {
    [SVProgressHUD dismiss];
    
    if (status == YES) {
        self.postsArray = response;
        [self.tableView reloadData];
    }
    else{
        NSLog(@"NO DATA RESPONSE. FAILED...");
    }
}

#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell = (PostCell *) [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Post *post = self.postsArray[indexPath.row];
    cell.titleLabel.text = post.title;
    cell.bodyLabel.text = post.body;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postsArray.count;
}


@end
