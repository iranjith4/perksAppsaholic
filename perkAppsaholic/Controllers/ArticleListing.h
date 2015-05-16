//
//  ArticleListing.h
//  perkAppsaholic
//
//  Created by Ranjith on 16/05/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"

@interface ArticleListing : UIViewController<MWFeedParserDelegate,UITableViewDelegate,UITableViewDataSource>

- (void)loadControllerWithArtile:(NSString *)link;

@end
