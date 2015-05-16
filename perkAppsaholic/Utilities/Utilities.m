//
//  Utilities.m
//  perkAppsaholic
//
//  Created by Ranjith on 16/05/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+ (CGFloat)heightForLabel:(NSString *)string inRect:(CGRect) rect withFont:(UIFont *)font lines:(int)lines{
    UILabel *lbl = [[UILabel alloc] initWithFrame:rect];
    [lbl setFont:font];
    lbl.numberOfLines = lines;
    [lbl setText:string];
    [lbl sizeToFit];
    CGFloat height = lbl.frame.size.height;
    [lbl removeFromSuperview];
    lbl = nil;
    return height;
}


+ (NSString *)getReadingTimeFor:(NSString *)text {
    NSCharacterSet *separators = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSArray *words = [text componentsSeparatedByCharactersInSet:separators];
    
    NSIndexSet *separatorIndexes = [words indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return [obj isEqualToString:@""];
    }];
    
    float wordsCount =  [words count] - [separatorIndexes count];
    NSString *timeString = [self timeFormatted:wordsCount];
    return timeString;
}

+ (NSString *)timeFormatted:(float)words{
    float time = words * 0.6; // Assuming Humans average reading time is 100 words per minute
    return [NSString stringWithFormat:@" %.2f sec read",time];
}

@end
