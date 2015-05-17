//
//  ArticleScrollView.m
//  perkAppsaholic
//
//  Created by Ranjith on 16/05/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import "ArticleScrollView.h"
#import "Utilities.h"
#import "AppsaholicSDK.h"


#define ARTICLE_PAGE_READ_TIME 10

@implementation ArticleScrollView{
    MWFeedItem *feedItem;
    float xPos;
    float yPos;
    int currentPage;
    NSTimer *timer;
    BOOL isRewardClaimed;
    
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

- (void)disableTimers{
    [timer invalidate];
    timer = nil;
}

- (void) initUI{
    isRewardClaimed = NO;
    xPos = 10;
    yPos = 10;
    
    //Setting the number of Pages to 4
    numberOfPages = [self getNumberOfPages];
    
    for (int i = 0; i < numberOfPages; i++) {
        [timerArray addObject:[NSNumber numberWithInt:0]];
    }
    
    // Scroll Settings
    self.scrollEnabled = YES;
    currentPage = 0;
    [self runTimerForPage:0];
//    self.pagingEnabled = YES;
    self.delegate = self;
    self.backgroundColor = [UIColor whiteColor];
    self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height * numberOfPages);
    
    //Adding Timer Array
    
    
    
    // Arrangement of UIs
    [self loadHeading];
    [self addALine];
    [self loadAuthor];
    [self addALine];
    [self loadEnclosures];
    [self addArticleContent];
    [self addCharts];
    
    self.contentSize = CGSizeMake(self.frame.size.width, yPos);
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
    author.font = [UIFont fontWithName:FONT_REGULAR size:16];
    author.textColor = [UIColor colorWithWhite:0.245 alpha:1.000];
    author.textAlignment = NSTextAlignmentLeft;
    author.numberOfLines = 0;
    author.lineBreakMode = NSLineBreakByWordWrapping;
    author.text = [Utilities decodedString:feedItem.content ? feedItem.content : @"[No Content]"];
    [author sizeToFit];
    [self addSubview:author];
    yPos += author.frame.size.height + 20;
}

- (void)loadEnclosures{
    if (feedItem.enclosures > 0 && feedItem.enclosures != nil) {
        NSDictionary *enclosure = [feedItem.enclosures objectAtIndex:0];
        if ([enclosure[@"type"] isEqualToString:@"video/mp4"]) {
            [self loadVideoFor:enclosure[@"url"]];
        }
    }
}

- (void)addCharts{
//    PNCircleChart * circleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, yPos, self.frame.size.width, self.frame.size.width) total:[NSNumber numberWithInt:100] current:[NSNumber numberWithInt:45] clockwise:YES];
//    circleChart.backgroundColor = [UIColor clearColor];
//    [circleChart setStrokeColor:PNGreen];
//    [circleChart strokeChart];
//    [self addSubview:circleChart];
    
//    JBBarChartView *barChartView = [[JBBarChartView alloc] initWithFrame:CGRectMake(0, yPos, self.frame.size.width * 0.90, self.frame.size.width * 0.90)];
//    barChartView.dataSource = self;
//    barChartView.delegate = self;
//    [self addSubview:barChartView];
//    [barChartView reloadData];
    
    
    UILabel *page = [[UILabel alloc] initWithFrame:CGRectMake(10, yPos, self.frame.size.width, self.frame.size.height)];
    page.font = [UIFont fontWithName:FONT_BOLD size:14];
    page.text = [NSString stringWithFormat:@"Read Status"];
    page.textColor = [UIColor grayColor];
    [page sizeToFit];
    [self addSubview:page];
    yPos += page.frame.size.height + 5;
    
    for (int i = 0; i < numberOfPages; i++) {
        
        UILabel *page = [[UILabel alloc] initWithFrame:CGRectMake(10, yPos, self.frame.size.width, self.frame.size.height)];
        page.font = [UIFont fontWithName:FONT_BOLD size:10];
        page.text = [NSString stringWithFormat:@"Page %d",i +1];
        page.textColor = [UIColor grayColor];
        [page sizeToFit];
        [self addSubview:page];
        yPos += page.frame.size.height + 3;
        
        UIProgressView *progress = [[UIProgressView alloc] initWithFrame:CGRectMake(10, yPos, self.frame.size.width - 20, 5)];
        progress.progress = [[timerArray objectAtIndex:i] intValue] / ARTICLE_PAGE_READ_TIME;
        progress.progressTintColor = [UIColor colorWithRed:1.000 green:0.451 blue:0.148 alpha:1.000];
        progress.trackTintColor = [UIColor colorWithWhite:0.973 alpha:1.000];
        progress.tag = i;
        [self addSubview:progress];
        yPos += progress.frame.size.height + 1;
    }
    
    yPos += 20;
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
//        NSLog(@"TIME %f",timer.timeInterval);
        [self timerEnds:timer];
        [self saveTimerData:timer];
        [timer invalidate];
    }
    NSLog(@"TIME %d running",page);
   timer =  [NSTimer scheduledTimerWithTimeInterval:ARTICLE_PAGE_READ_TIME target:self selector:@selector(timerEnds:) userInfo:[NSNumber numberWithInt:page] repeats:NO];
}

- (void)timerEnds:(NSTimer *)timers{
//    NSLog(@"%f",[self getTimeDiff:[timers.fireDate timeIntervalSinceReferenceDate]]);
    [self saveTimerData:timers];
}

- (NSTimeInterval)getTimeDiff:(NSTimeInterval)time1{
    NSTimeInterval now = [[NSDate date] timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = time1 - now;
//    NSLog(@"HH %d for %@",(int)elapsed,timer.userInfo);
    return elapsed;
}

- (void) saveTimerData:(NSTimer *)tm{
    int timeToAdd;
    int index = [tm.userInfo intValue];
    
    //Exception Handled here
    if (index >= timerArray.count) {
        index = index - 1;
    }
    NSLog(@"INDEX %d",index);
    int getTime = [[timerArray objectAtIndex:index] intValue];
    if (getTime < ARTICLE_PAGE_READ_TIME) {
        getTime = getTime + ARTICLE_PAGE_READ_TIME - [self getTimeDiff:[tm.fireDate timeIntervalSinceReferenceDate]];
        if (getTime >= ARTICLE_PAGE_READ_TIME) {
            timeToAdd = ARTICLE_PAGE_READ_TIME;
        }else{
            timeToAdd = getTime;
        }
        [timerArray setObject:[NSNumber numberWithInt:timeToAdd] atIndexedSubscript:index];
        [self updateProgress];
       // NSLog(@"time %d added at %d",timeToAdd,index);
    }else if (getTime == ARTICLE_PAGE_READ_TIME){
        //Do Nothing
    }
    //TODO: Update Progress Chart
    if ([self isUserGotAllPoints]) {
        //DO the SDK thing here
        [self addAppsPoints];
        NSLog(@"DONEEEEEE !");
    }
}

- (BOOL)isUserGotAllPoints{
    for (NSNumber *num in timerArray) {
        if ([num intValue]!= ARTICLE_PAGE_READ_TIME) {
            return NO;
        }
    }
    return YES;
}

- (void)addAppsPoints{
    if (!isRewardClaimed) {
        if (self) {
            [self.del addpointsForArticles];
            isRewardClaimed = YES;

        }
            }
    
}

- (void)updateProgress{
    for (UIProgressView *view in self.subviews) {
        if ([view isKindOfClass:[UIProgressView class]]) {
            int tag = (int)view.tag;
                view.progress = (float)[[timerArray objectAtIndex:tag] intValue] / ARTICLE_PAGE_READ_TIME;
        }
    }
}

- (int)getNumberOfPages{
    CGFloat x,y;
    x = 10;
    y = 10;
    
    y += 30;
    
    y += [Utilities heightForLabel:[Utilities decodedString:feedItem.title] inRect:CGRectMake(xPos, yPos, self.frame.size.width - xPos - 5, 600) withFont:[UIFont fontWithName:FONT_BOLD size:25] lines:0];
    
    y += [Utilities heightForLabel:[Utilities decodedString:feedItem.content] inRect:CGRectMake(xPos, yPos, self.frame.size.width - xPos - 5, 600) withFont:[UIFont fontWithName:FONT_BOLD size:16] lines:0];
    
     y += [Utilities heightForLabel:[Utilities decodedString:feedItem.author] inRect:CGRectMake(xPos, yPos, self.frame.size.width - xPos - 5, 600) withFont:[UIFont fontWithName:FONT_BOLD size:13] lines:0];
    
    y += 10;
    
    CGSize size = CGSizeMake(self.frame.size.width, y);
    
    int pageN = size.height / self.frame.size.height;
    return pageN;
}

#pragma mark - Bar Chart
//
//- (NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView
//{
//    return numberOfPages;
//}
//
//- (CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtIndex:(NSUInteger)index
//{
//    return 100; // height of bar at index
//}
//
//-(UIView *)barChartView:(JBBarChartView *)barChartView barViewAtIndex:(NSUInteger)index{
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor grayColor];
//    return view;
//}
//
//- (UIColor *)barChartView:(JBBarChartView *)barChartView colorForBarViewAtIndex:(NSUInteger)index{
//    return [UIColor orangeColor];
//}

@end
