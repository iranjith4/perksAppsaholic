//
//  ArticleListingCell.h
//  perkAppsaholic
//
//  Created by Ranjith on 16/05/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedItem.h"

@interface ArticleListingCell : UITableViewCell

@property (nonatomic, strong) UILabel *heading;
@property (nonatomic, strong) UILabel *summary;
@property (nonatomic, strong) UILabel *author;
@property (nonatomic, strong) UILabel *time;

- (void)initUIFor:(MWFeedItem *)feedItem;

@end
