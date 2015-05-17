//
//  RSSFeedsList.m
//  perkAppsaholic
//
//  Created by Ranjith on 17/05/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import "RSSFeedsList.h"
#import <Parse/Parse.h>
#import "BButton.h"
#import "ArticleListing.h"
#import "Utilities.h"

@interface RSSFeedsList (){
    UIScrollView *scroll;
    NSArray *feedslist;
    int yPos;
}

@end

@implementation RSSFeedsList

- (void)viewDidLoad {
    
    //Scroll set
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scroll.scrollEnabled = YES;
    scroll.alwaysBounceVertical = YES;
    [self.view addSubview:scroll];
    
    yPos = 80;
    //Setting Corner Radius for Buttons
    
    [[BButton appearance] setButtonCornerRadius:@20.0f];
    
    [super viewDidLoad];
    [self loadFeedData];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)loadFeedData{
    PFQuery *query = [PFQuery queryWithClassName:@"feed"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"HEHE : %@",objects);
            feedslist = objects;
            [self addButtons];
            //TODO: Call the buttons
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addButtons{
    yPos = 80;
    
    
    BButton *add = [[BButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 10 - 40 , yPos, 40, 40) type:BButtonTypePrimary style:BButtonStyleBootstrapV2];
    [add setTitle:@"+" forState:UIControlStateNormal];
    add.layer.cornerRadius = add.frame.size.height / 2;
    add.titleLabel.font = [UIFont fontWithName:FONT_BOLD size:29];
    [add addTarget:self action:@selector(addFeed) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:add];
    yPos += add.frame.size.height + 2;
    
    int i = 0;
    for (PFObject *obj in feedslist) {
        BButton *button = [[BButton alloc] initWithFrame:CGRectMake(10, yPos, self.view.frame.size.width * 0.60, 40) type:BButtonTypePurple style:BButtonStyleBootstrapV2];
        [button setTitle:[NSString stringWithFormat:@"%@ >",obj[@"name"]] forState:UIControlStateNormal];
        button.tag = i;
        button.layer.cornerRadius = button.frame.size.height / 2;
        [button addTarget:self action:@selector(feedSelector:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:button];
        yPos += button.frame.size.height + 2;
        
        UILabel *author = [[UILabel alloc] initWithFrame:CGRectMake(0, yPos, button.frame.size.width, 10)];
        author.font = [UIFont fontWithName:FONT_MEDIUM size:14];
        author.textColor = [UIColor colorWithRed:0.427 green:0.235 blue:0.776 alpha:1.000];
        author.text = obj[@"author"];
        [author sizeToFit];
        author.center = CGPointMake(button.center.x, author.center.y);
        [scroll addSubview:author];
        yPos += author.frame.size.height + 20;
        i++;
    }
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, yPos);
}

- (void)addFeed{
    AddRssViewController *add = [[AddRssViewController alloc] initWithNibName:nil bundle:nil];
    add.del = self;
    [self presentViewController:add animated:YES completion:nil];
}

- (void)feedSelector:(UIButton *)sender{
    int tag = (int)sender.tag;
    NSLog(@"GOR : %d",tag);
    PFObject *obj = [feedslist objectAtIndex:tag];
    ArticleListing *articleList = [[ArticleListing alloc] initWithNibName:nil bundle:nil];
    [articleList loadControllerWithArtile:obj[@"url"]];
    [self.navigationController pushViewController:articleList animated:YES];
}

- (void)addFeedWithData:(NSDictionary *)data{
    //TODO send data to parse
    PFObject *gameScore = [PFObject objectWithClassName:@"feed"];
    gameScore[@"name"] = data[@"name"];
    gameScore[@"author"] = data[@"author"];
    gameScore[@"url"] = data[@"url"];
    [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self removeAndAddButtons];
        } else {

        }
    }];
}

- (void)removeAndAddButtons{
    int n = (int)self.view.subviews.count;
    for (int i = 0; i < n; i++) {
        if ([[self.view.subviews objectAtIndex:i] isKindOfClass:[BButton class]]) {
            BButton *b =  [self.view.subviews objectAtIndex:i];
            [b removeFromSuperview];
            b = nil;
        }
    }
    [self loadFeedData];
}


- (void)getARandomX{
    
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
