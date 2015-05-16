//
//  ArticleScrollView.h
//  perkAppsaholic
//
//  Created by Ranjith on 16/05/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedItem.h"
#import "JBBarChartView.h"

@protocol ArticlesDelegate <NSObject>

- (void)addpointsForArticles;

@end


@interface ArticleScrollView : UIScrollView<UIScrollViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame andFeedItem:(MWFeedItem *)feed;

@property (nonatomic, assign) id<ArticlesDelegate> del;

@end
