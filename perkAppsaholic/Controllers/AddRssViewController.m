//
//  AddRssViewController.m
//  perkAppsaholic
//
//  Created by Ranjith on 17/05/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import "AddRssViewController.h"
#import "JVFloatLabeledTextField.h"
#import "BButton.h"
#import "Utilities.h"

@interface AddRssViewController ()

@end

@implementation AddRssViewController{
    JVFloatLabeledTextField *title;
    JVFloatLabeledTextField *author;
    JVFloatLabeledTextField *url;
    float yPos;
}

- (void)viewDidLoad {
    yPos = 50;
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self addCloseButton];
    [self addFields];
}

- (void)addCloseButton{
    BButton *add = [[BButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 10 - 40 , yPos, 40, 40) type:BButtonTypeDanger style:BButtonStyleBootstrapV2];
    [add setTitle:@"X" forState:UIControlStateNormal];
    add.layer.cornerRadius = add.frame.size.height / 2;
    add.titleLabel.font = [UIFont fontWithName:FONT_BOLD size:29];
    [add addTarget:self action:@selector(closeController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:add];
    yPos += add.frame.size.height + 2;
}

- (void)closeController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addFields{
    title = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(10, yPos, self.view.frame.size.width - 20, 50)];
    title.floatingLabel.text = @"Title";
    title.floatingLabelTextColor = [UIColor colorWithRed:0.369 green:0.354 blue:0.384 alpha:1.000];
    title.floatingLabelActiveTextColor = [UIColor colorWithRed:0.392 green:0.200 blue:0.737 alpha:1.000];

    [title setPlaceholder:@"Enter a RSS Title" floatingTitle:@"RSS Title"];
    [self.view addSubview:title];
    yPos += title.frame.size.height + 5;
    
    author = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(10, yPos, self.view.frame.size.width - 20, 50)];
    author.floatingLabel.text = @"Author";
    author.floatingLabelTextColor = [UIColor colorWithRed:0.369 green:0.354 blue:0.384 alpha:1.000];
    author.floatingLabelActiveTextColor = [UIColor colorWithRed:0.392 green:0.200 blue:0.737 alpha:1.000];
    [author setPlaceholder:@"Enter Author Name" floatingTitle:@"Author"];
    [self.view addSubview:author];
    yPos += title.frame.size.height + 5;
    
    url = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(10, yPos, self.view.frame.size.width - 20, 50)];
    url.floatingLabel.text = @"URL";
    url.floatingLabelTextColor = [UIColor colorWithRed:0.369 green:0.354 blue:0.384 alpha:1.000];
    url.floatingLabelActiveTextColor = [UIColor colorWithRed:0.392 green:0.200 blue:0.737 alpha:1.000];
    [url setPlaceholder:@"Enter RSS Url" floatingTitle:@"URL"];
    [self.view addSubview:url];
    yPos += title.frame.size.height + 5;
    
    
    BButton *add = [[BButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 10 - 60 , yPos, 60, 40) type:BButtonTypeFacebook style:BButtonStyleBootstrapV2];
    [add setTitle:@"Add" forState:UIControlStateNormal];
    add.layer.cornerRadius = add.frame.size.height / 2;
    add.titleLabel.font = [UIFont fontWithName:FONT_BOLD size:17];
    add.center = CGPointMake(self.view.center.x, add.center.y);
    [add addTarget:self action:@selector(addFeed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:add];
    yPos += add.frame.size.height + 2;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addFeed{
    NSDictionary *dict = @{
                           @"name" : title.text,
                           @"author":author.text,
                           @"url" : url.text
};
    [self.del addFeedWithData:dict];
    [self closeController];
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
