//
//  ViewController.m
//  perkAppsaholic
//
//  Created by Ranjith on 15/05/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import "ViewController.h"
#import "NSString+HTML.h"
#import "ArticleListing.h"
#import "Utilities.h"
#import "AppsaholicSDK.h"
#import "RSSFeedsList.h"

@interface ViewController ()

@end

@implementation ViewController{
    MWFeedParser *feedParser;
    UILabel *webview;
}

- (void)viewDidLoad {
//    [AppsaholicSDK sharedManager];
    ((AppsaholicSDK*)[AppsaholicSDK sharedManager]).rootViewController = self;
    [self startAppsaholicSession];
    [super viewDidLoad];
   // [self testFeedParsing];
    [self loadFeedList];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startAppsaholicSession{
    [[AppsaholicSDK sharedManager] startSession:APPSAHOLIC_API_KEY withSuccess:^(BOOL success, NSString* status) {
        
    }];
}

- (void)loadFeedList{
    RSSFeedsList *rss = [[RSSFeedsList alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:rss animated:NO];
}

-(void)testFeedParsing {
    ArticleListing *articleList = [[ArticleListing alloc] initWithNibName:nil bundle:nil];
    [articleList loadControllerWithArtile:@"http://feeds.arstechnica.com/arstechnica/apple/"];
    [self.navigationController pushViewController:articleList animated:NO];
}



@end
