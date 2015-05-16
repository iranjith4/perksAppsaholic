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

@interface ViewController ()

@end

@implementation ViewController{
    MWFeedParser *feedParser;
    UILabel *webview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testFeedParsing];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)testFeedParsing {
    ArticleListing *articleList = [[ArticleListing alloc] initWithNibName:nil bundle:nil];
    [articleList loadControllerWithArtile:@"https://www.yahoo.com/tech/rss"];
    [self.navigationController pushViewController:articleList animated:NO];
}



@end
