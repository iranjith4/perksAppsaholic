//
//  ArticleDetailViewController.m
//  perkAppsaholic
//
//  Created by Ranjith on 16/05/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import "ArticleDetailViewController.h"
#import "ArticleScrollView.h"
#import "Utilities.h"

@interface ArticleDetailViewController (){
    ArticleScrollView *scroll;
}

@end

@implementation ArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated{
    [scroll disableTimers];
}


- (void)loadUIForFeed:(MWFeedItem *)feed{
    scroll = [[ArticleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) andFeedItem:feed];
    scroll.del = self;
    [self.view addSubview:scroll];
}

- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addpointsForArticles{
    [[AppsaholicSDK sharedManager] trackEvent:EVNT_ARTICLE notificationType:NO withController:self withSuccess:^(BOOL success, NSString *notificationtext, NSNumber *pointEarned) {
        NSLog(@"%@ and %@",notificationtext,pointEarned);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
