//
//  ArticleListing.m
//  perkAppsaholic
//
//  Created by Ranjith on 16/05/15.
//  Copyright (c) 2015 RanjithKumar Matheswaran. All rights reserved.
//

#import "ArticleListing.h"
#import "ArticleListingTable.h"
#import "ArticleListingCell.h"
#import "Utilities.h"
#import "ArticleDetailViewController.h"

@interface ArticleListing (){
    NSMutableArray *articlesArray;
    NSArray *dataArray;
    MWFeedParser *feedParser;
    NSString *url;
    ArticleListingTable *articlesTable;
}

@end

@implementation ArticleListing

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationItem.hidesBackButton = YES;
}

- (void)allocations{
    articlesArray = [[NSMutableArray alloc] init];
}

-(void)loadControllerWithArtile:(NSString *)link{
    [self allocations];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadUI];
    
    
    url = link;
    NSURL *feedURL = [NSURL URLWithString:url];
    feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
    feedParser.delegate = self;
    feedParser.feedParseType = ParseTypeFull;
    feedParser.connectionType = ConnectionTypeSynchronously;
    [feedParser parse];
}

- (void) loadData{
    
}

- (void) loadUI{
    CGSize phoneSize = [[UIScreen mainScreen] bounds].size;
    articlesTable = [[ArticleListingTable alloc] initWithFrame:CGRectMake(0, self.view.frame.origin.y, phoneSize.width , phoneSize.height) style:UITableViewStylePlain];
    articlesTable.delegate = self;
    articlesTable.dataSource = self;
    [self.view addSubview:articlesTable];
    [articlesTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Parser Delegates

- (void)feedParserDidFinish:(MWFeedParser *)parser{
    NSLog(@"complete");
    dataArray = [articlesArray mutableCopy];
    [articlesTable reloadData];
     dispatch_async(dispatch_get_main_queue(), ^{[articlesTable reloadData];});
    //This will be called when the parsing is completely done
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info{
    NSLog(@"info");
    //This method will be called when you get the Info
    self.title = info.title;
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item{
    NSLog(@"item");
    //This method will be called for every item in the XML
    [articlesArray addObject:item];
}

#pragma mark - Table View Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MWFeedItem *item = [dataArray objectAtIndex:indexPath.row];
    UITableViewCell *cell;
    
    ArticleListingCell *articleCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!articleCell) {
        articleCell = [[ArticleListingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [articleCell initUIFor:item];
    [self checkContentFor:item];
    cell = articleCell;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return [self calculatingHeightForItem:[dataArray objectAtIndex:indexPath.row]];
}

- (float)calculatingHeightForItem:(MWFeedItem *)item{
    CGFloat xPos,yPos;
    xPos = 10;
    yPos = 10;
    
    //Heading label
//    UILabel *heading = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 20,0)];
//    heading.lineBreakMode = NSLineBreakByWordWrapping;
//    heading.font = [UIFont fontWithName:FONT_BOLD size:18];
//    
//    height += [Utilities heightForLabel:item.title inRect:heading.frame withFont:[UIFont fontWithName:FONT_BOLD size:18] lines:heading.numberOfLines];
    
    //Heading label
//    UILabel *summary = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 20, self.view.frame.size.width * 0.09)];
//    summary.lineBreakMode = NSLineBreakByWordWrapping;
//    summary.font = [UIFont fontWithName:FONT_BOLD size:13];
//    
//    height += [Utilities heightForLabel:item.summary inRect:summary.frame withFont:[UIFont fontWithName:FONT_BOLD size:18] lines:0];
    
    yPos += [Utilities heightForLabel:[Utilities decodedString:item.title] inRect:CGRectMake(xPos, yPos, self.view.frame.size.width - xPos - 5, 600) withFont:[UIFont fontWithName:FONT_BOLD size:18] lines:0];
    
    yPos += [Utilities heightForLabel:[Utilities decodedString:item.summary] inRect:CGRectMake(xPos, yPos, self.view.frame.size.width - xPos - 5, 600) withFont:[UIFont fontWithName:FONT_BOLD size:13] lines:0];
    
    yPos += 10;
    //  yPos += [ImageResize changeSpaceHeightToMyDevice:IPHONE5_SIZE :5];
    
    //  yPos += [self heightForLabel:@"Like" inRect:CGRectMake(xPos, yPos,50,10) withFont:[UIFont fontWithName:@"Helvetica Neue" size:[ImageResize mePageFontChangeWithWidth:IPHONE5_SIZE :12]] lines:1];
    
    //Button Height
    
    CGSize size = CGSizeMake(self.view.frame.size.width, yPos);
    return size.height + 40;

    
   // return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MWFeedItem *feed = [dataArray objectAtIndex:indexPath.row];
    ArticleDetailViewController *articleDetail = [[ArticleDetailViewController alloc] initWithNibName:nil bundle:nil];
    [articleDetail loadUIForFeed:feed];
    [self.navigationController pushViewController:articleDetail animated:YES];
}


#pragma mark - Test Content

- (void)checkContentFor:(MWFeedItem *)itm{
    NSLog(@"\n################\n################\n################\n################");
    NSLog(@"title       : %@",itm.title ? @"YES" : @"NO");
    NSLog(@"summary     : %@",itm.summary ? @"YES" : @"NO");
    NSLog(@"update time : %@",itm.updated ? @"YES" : @"NO");
    NSLog(@"content     : %@",itm.content ? @"YES" : @"NO");
    NSLog(@"enclosures  : %@",itm.enclosures ? @"YES" : @"NO");
    NSLog(@"Link        : %@",itm.link ? @"YES" : @"NO");
    NSLog(@"Date        : %@",itm.date ? @"YES" : @"NO");
    NSLog(@"Author      : %@",itm.author ? @"YES" : @"NO");
    NSLog(@"\n################\n################\n################\n################");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
