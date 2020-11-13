//
//  WebViewController.m
//  AirPrint
//
//  Created by Alan on 2020/11/13.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
@interface WebViewController ()

@property(nonatomic, strong) WKWebView *printWebView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//- (UIWebView *)printWebView
//{
//    if (!_printWebView) {
//
//        _printWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 100 , 100)];
//
//        _printWebView.backgroundColor = HexRGB(0xf9f9f9);
//
//        _printWebView.delegate = self;
//
//        _printWebView.scalesPageToFit = YES;
//    }
//return _printWebView;
//}


@end
