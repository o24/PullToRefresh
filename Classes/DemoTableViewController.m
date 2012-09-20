//
//  RootViewController.m
//  PullToRefresh
//
//  Created by Leah Culver on 7/25/10.
//  Copyright Plancast 2010. All rights reserved.
//

#import "DemoTableViewController.h"


@implementation DemoTableViewController
{
	UIWebView* _webview;
	UITableViewCell* _firstCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Pull to Refresh";
    items = [[NSMutableArray alloc] initWithObjects:@"What time is it?", nil];
	//NSURL* url = [NSURL URLWithString:@"http://yahoo.co.jp"];
	NSURL* url = [NSURL URLWithString:@"http://o24.me/app/pulltorefresh/"];
	_webview = [[UIWebView alloc]initWithFrame:self.view.bounds];
	_webview.delegate = self;
	[_webview loadRequest:[NSURLRequest requestWithURL:url ]];
}


- (void)refresh {
    //[self performSelector:@selector(addItem) withObject:nil afterDelay:2.0];
	[_webview reload];
}

- (void)addItem {
    // Add a new time
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    NSString *now = [dateFormatter stringFromDate:[NSDate date]];
    [items insertObject:[NSString stringWithFormat:@"%@", now] atIndex:0];

    [self.tableView reloadData];

    [self stopLoading];
}

- (void)dealloc {
    [items release];
    [super dealloc];
}

/***** UITableViewDelegate *****/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 416.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [items count];
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	

    cell.textLabel.text = [items objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	[cell addSubview:_webview];
	_firstCell = cell;

    return cell;
}

/***** UIWebViewDelegate *****/
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self stopLoading];
}

@end

