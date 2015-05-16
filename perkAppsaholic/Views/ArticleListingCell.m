//
//  ArticleListingCell.m
//  perkAppsaholic
//
//  Created by Ranjith on 16/05/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import "ArticleListingCell.h"
#import "Utilities.h"

@implementation ArticleListingCell{
    float xPos;
    float yPos;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)initUIFor:(MWFeedItem *)feedItem{
    xPos = 10;
    yPos = 10;
    CGRect frame;
    
//Create Heading
    if (!self.heading) {
        self.heading = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, self.frame.size.width - 20, self.frame.size.width * 0.09)];
        self.heading.numberOfLines = 3;
        self.heading.lineBreakMode = NSLineBreakByWordWrapping;
        self.heading.font = [UIFont fontWithName:FONT_BOLD size:18];
        [self addSubview:self.heading];
    }
    self.heading.text = feedItem.title;
    [self.heading sizeToFit];
    frame = self.heading.frame;
    frame.origin.y = yPos;
    self.heading.frame = frame;
    yPos += self.heading.frame.size.height + 5;
    
    if (!self.summary) {
        self.summary = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, self.frame.size.width - 20, self.frame.size.width * 0.09)];
        self.summary.numberOfLines = 10;
        self.summary.lineBreakMode = NSLineBreakByWordWrapping;
        self.summary.font = [UIFont fontWithName:FONT_REGULAR size:13];
        self.summary.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.summary];
    }
    self.summary.text = feedItem.summary;
    [self.summary sizeToFit];
    frame = self.summary.frame;
    frame.origin.y = yPos;
    self.summary.frame = frame;
    yPos += self.summary.frame.size.height + 5;
    
    if (!self.time) {
        self.time = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, self.frame.size.width - 20, self.frame.size.width * 0.09)];
        self.time.numberOfLines = 10;
        self.time.lineBreakMode = NSLineBreakByWordWrapping;
        self.time.font = [UIFont fontWithName:FONT_REGULAR size:13];
        self.time.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.time];
    }
    self.time.text = [Utilities getReadingTimeFor:feedItem.content];
    [self.time sizeToFit];
    frame = self.time.frame;
    frame.origin.y = yPos;
    self.time.frame = frame;
    yPos += self.time.frame.size.height + 5;
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
