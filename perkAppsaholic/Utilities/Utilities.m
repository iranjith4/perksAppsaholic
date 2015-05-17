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
    return height + 0.12 * height;
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

+ (NSString *)decodedString:(NSString *)feed{
    NSString *content = [feed stringByConvertingHTMLToPlainText];
 //   content = [content stringByDecodingHTMLEntities];
    content = [content stringByRemovingNewLinesAndWhitespace];
    content = [content stringByLinkifyingURLs];
    return content;
}

// Convert HTML to Plain Text
////  - Strips HTML tags & comments, removes extra whitespace and decodes HTML character entities.
//- (NSString *)stringByConvertingHTMLToPlainText;
//
//// Decode all HTML entities using GTM.
//- (NSString *)stringByDecodingHTMLEntities;
//
//// Encode all HTML entities using GTM.
//- (NSString *)stringByEncodingHTMLEntities;
//
//// Minimal unicode encoding will only cover characters from table
//// A.2.2 of http://www.w3.org/TR/xhtml1/dtds.html#a_dtd_Special_characters
//// which is what you want for a unicode encoded webpage.
//- (NSString *)stringByEncodingHTMLEntities:(BOOL)isUnicode;
//
//// Replace newlines with <br /> tags.
//- (NSString *)stringWithNewLinesAsBRs;
//
//// Remove newlines and white space from string.
//- (NSString *)stringByRemovingNewLinesAndWhitespace;
//
//// Wrap plain URLs in <a href="..." class="linkified">...</a>
////  - Ignores URLs inside tags (any URL beginning with =")
////  - HTTP & HTTPS schemes only
////  - Only works in iOS 4+ as we use NSRegularExpression (returns self if not supported so be careful with NSMutableStrings)
////  - Expression: (?<!=")\b((http|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?)
////  - Adapted from http://regexlib.com/REDetails.aspx?regexp_id=96
//- (NSString *)stringByLinkifyingURLs;

@end
