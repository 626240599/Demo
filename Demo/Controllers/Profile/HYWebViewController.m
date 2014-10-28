//
//  HYWebViewController.m
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYWebViewController.h"

@interface HYWebViewController () <UIWebViewDelegate> {
    UIActivityIndicatorView* _activityIndicator;
    UIWebView* _webView;
}
@end

@implementation HYWebViewController
-(void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *strURL = @"http://darma.co/press";
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    CGRect frame = self.view.frame;
    frame.size.height = self.view.frame.size.height - 120.0;
    _webView = [[UIWebView alloc] initWithFrame:frame];
    _webView.delegate = self;
    _webView.mediaPlaybackAllowsAirPlay = YES;
    _webView.mediaPlaybackRequiresUserAction = NO;
    [_webView loadRequest:urlRequest];
    [self.view addSubview:_webView];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
}

#pragma mark - Web View Delegate

-(BOOL)webView:(UIWebView*)w shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)type {

    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: YES];

}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString* string =  [webView.request.URL absoluteString];
    if ([string rangeOfString:@"success"].location != NSNotFound) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
    // report the error inside the webview
    NSString* errorString = [NSString stringWithFormat:@"<html><center><font size=30 color='black'>An error occurred:<br>%@</font></center></html>", error.localizedDescription];
    [webView loadHTMLString:errorString baseURL:nil];
}

@end
