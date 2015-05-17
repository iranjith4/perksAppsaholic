//
//  AddRssViewController.h
//  perkAppsaholic
//
//  Created by Ranjith on 17/05/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddFeedDelegate <NSObject>

- (void)addFeedWithData:(NSDictionary *)data;

@end

@interface AddRssViewController : UIViewController
@property (nonatomic, strong) id<AddFeedDelegate> del;

@end
