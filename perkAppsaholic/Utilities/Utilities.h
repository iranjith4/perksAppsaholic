//
//  Utilities.h
//  perkAppsaholic
//
//  Created by Ranjith on 16/05/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MWFeedItem.h"
#import "NSString+HTML.h"

#define APPSAHOLIC_API_KEY @"6deea98d606cc5f50ebd8fa8cb2458d18b6ef424"

#define EVENT_IDS

#define EVNT_ARTICLE @"54c6f5598ece8c0d5bdd7112744ec49ba5ac5ca2"


// Fonts
#define FONT_REGULAR @"Avenir-Book"
#define FONT_THIN @"AppleSDGothicNeo-Thin"
#define FONT_LIGHT @"AppleSDGothicNeo-Light"
#define FONT_MEDIUM @"AppleSDGothicNeo-Medium"
#define FONT_SEMIBOLD @"Avenir-Heavy"
#define FONT_BOLD @"AppleSDGothicNeo-Bold"

@interface Utilities : NSObject

+ (CGFloat)heightForLabel:(NSString *)string inRect:(CGRect) rect withFont:(UIFont *)font lines:(int)lines;
+ (NSString *)getReadingTimeFor:(NSString *)text;
+ (NSString *)decodedString:(NSString *)feed;
@end
