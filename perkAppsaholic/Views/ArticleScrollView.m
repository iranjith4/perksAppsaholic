//
//  ArticleScrollView.m
//  perkAppsaholic
//
//  Created by Ranjith on 16/05/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import "ArticleScrollView.h"
#import "Utilities.h"

@implementation ArticleScrollView{
    MWFeedItem *feedItem;
    float xPos;
    float yPos;
    int currentPage;
    NSTimer *timer;
    
    //Time Calculation Algorithm
    int numberOfPages;
    NSMutableArray *timerArray;
}

- (instancetype)initWithFrame:(CGRect)frame andFeedItem:(MWFeedItem *)feed
{
    self = [super initWithFrame:frame];
    if (self) {
        timerArray = [[NSMutableArray alloc] init];
        feedItem = feed;
        self.delegate = self;
        [self initUI];
    }
    return self;
}

- (void) initUI{
    xPos = 10;
    yPos = 10;
    
    //Setting the number of Pages to 4
    numberOfPages = 10;
    
    // Scroll Settings
    self.scrollEnabled = YES;
    currentPage = 0;
    [self runTimerForPage:0];
//    self.pagingEnabled = YES;
    self.delegate = self;
    self.backgroundColor = [UIColor whiteColor];
    self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height * numberOfPages);
    
    //Adding Timer Array
    
    for (int i = 0; i < numberOfPages; i++) {
        [timerArray setObject:[NSNumber numberWithInt:numberOfPages] atIndexedSubscript:i];
    }
    
    // Arrangement of UIs
    [self loadHeading];
    [self addALine];
    [self loadAuthor];
    [self addALine];
    [self loadEnclosures];
    [self addArticleContent];
    [self addArticleContent];
    [self addArticleContent];
}


- (void)loadHeading{
    UILabel *heading = [[UILabel alloc] initWithFrame:CGRectMake(10, yPos, self.frame.size.width - 20, self.frame.size.width * 0.10)];
    heading.font = [UIFont fontWithName:FONT_BOLD size:25];
    heading.textColor = [UIColor orangeColor];
    heading.textAlignment = NSTextAlignmentLeft;
    heading.numberOfLines = 0;
    heading.lineBreakMode = NSLineBreakByWordWrapping;
    heading.text = [Utilities decodedString:feedItem.title];
    [heading sizeToFit];
    [self addSubview:heading];
    yPos += heading.frame.size.height + 5;
}

- (void)loadAuthor{
    UILabel *author = [[UILabel alloc] initWithFrame:CGRectMake(20, yPos, self.frame.size.width - 40, self.frame.size.width * 0.10)];
    author.font = [UIFont fontWithName:FONT_REGULAR size:13];
    author.textColor = [UIColor blackColor];
    author.textAlignment = NSTextAlignmentLeft;
    author.numberOfLines = 0;
    author.lineBreakMode = NSLineBreakByWordWrapping;
    author.text = [Utilities decodedString:feedItem.author ? feedItem.author : @"[No Author]"];
    [author sizeToFit];
    [self addSubview:author];
    yPos += author.frame.size.height + 5;
}

- (void)addALine{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, yPos, self.frame.size.width - 40, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self addSubview:line];
    yPos += line.frame.size.height + 5;
}

- (void)addArticleContent{
    UILabel *author = [[UILabel alloc] initWithFrame:CGRectMake(10, yPos, self.frame.size.width - 20, self.frame.size.width * 0.10)];
    author.font = [UIFont fontWithName:FONT_REGULAR size:13];
    author.textColor = [UIColor colorWithWhite:0.245 alpha:1.000];
    author.textAlignment = NSTextAlignmentLeft;
    author.numberOfLines = 0;
    author.lineBreakMode = NSLineBreakByWordWrapping;
    author.text = [Utilities decodedString:feedItem.content ? feedItem.content : @"[No Content]"];
    [author sizeToFit];
    [self addSubview:author];
    yPos += author.frame.size.height + 5;
}

- (void)loadEnclosures{
    if (feedItem.enclosures > 0 && feedItem.enclosures != nil) {
        NSDictionary *enclosure = [feedItem.enclosures objectAtIndex:0];
        if ([enclosure[@"type"] isEqualToString:@"video/mp4"]) {
            [self loadVideoFor:enclosure[@"url"]];
        }
    }
}

#pragma mark - Enclosure thing

- (void)loadVideoFor:(NSString *)url{
    NSString* embedHTML = @"\
    <html><head>\
    <style type=\"text/css\">\
    body {\
    background-color: transparent;\
    color: white;\
    }\
    </style>\
    </head><body style=\"margin:0\">\
    <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \
    width=\"%0.0f\" height=\"%0.0f\"></embed>\
    </body></html>";
    NSString* html = [NSString stringWithFormat:embedHTML, url, self.frame.size.width, self.frame.size.width * 3/4];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(xPos, yPos, self.frame.size.width - 2 * xPos, (self.frame.size.width - 2 *xPos) * 3/4)];
    [self addSubview:webView];
    [webView loadHTMLString:html baseURL:nil];
    yPos += webView.frame.size.height + 5;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self calculteReadingPointFor:scrollView.contentOffset.y];
}

- (void)calculteReadingPointFor:(float)yPoint{
    int readingPage = [self determinePage:yPoint];
    [self runTimersForReadingForPage:readingPage];
}

- (int)determinePage:(float)point{
    int n = point / [[UIScreen mainScreen] bounds].size.height;
//    if ((n % (int)[[UIScreen mainScreen] bounds].size.height) > 0) {
//        n = n + 1;
//    }
    return n;
}

- (void)runTimersForReadingForPage:(int)page{
    
    if (currentPage == page){
        //Do Nothing
    }else{
        currentPage = page;
        [self runTimerForPage:page];
    }
}

#pragma mark - Timer Run

- (void)runTimerForPage:(int)page{
    if (timer.isValid) {
        NSLog(@"TIME %f",timer.timeInterval);
        [self timerEnds:timer];
        [timer invalidate];
    }
    NSLog(@"TIME %d running",page);
   timer =  [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timerEnds:) userInfo:[NSNumber numberWithInt:page] repeats:NO];
}

- (void)timerEnds:(NSTimer *)timers{
    NSLog(@"%f",[self getTimeDiff:[timers.fireDate timeIntervalSinceReferenceDate]]);
}

- (NSTimeInterval)getTimeDiff:(NSTimeInterval)time1{
    NSTimeInterval now = [[NSDate date] timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = time1 - now;
    NSLog(@"HH %d for %@",(int)elapsed,timer.userInfo);
    return elapsed;
}
@end
