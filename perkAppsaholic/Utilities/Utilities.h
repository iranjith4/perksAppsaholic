//
//  Utilities.h
//  perkAppsaholic
//
//  Created by Ranjith on 16/05/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Fonts
#define FONT_REGULAR @"AppleSDGothicNeo-Regular"
#define FONT_THIN @"AppleSDGothicNeo-Thin"
#define FONT_LIGHT @"AppleSDGothicNeo-Light"
#define FONT_MEDIUM @"AppleSDGothicNeo-Medium"
#define FONT_SEMIBOLD @"AppleSDGothicNeo-SemiBold"
#define FONT_BOLD @"AppleSDGothicNeo-Bold"

@interface Utilities : NSObject

+ (CGFloat)heightForLabel:(NSString *)string inRect:(CGRect) rect withFont:(UIFont *)font lines:(int)lines;
+ (NSString *)getReadingTimeFor:(NSString *)text;
@end
