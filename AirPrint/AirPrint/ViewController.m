//
//  ViewController.m
//  AirPrint
//
//  Created by Alan on 2020/11/13.
//

#import "ViewController.h"

@interface ViewController ()<UIPrintInteractionControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 300, 200, 100)];
    [button2 setTitle:@"打印多种文件" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(printMore) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    
}

- (void)printMore
{
    NSString *pdfStrig = [[NSBundle mainBundle] pathForResource:@"pdf1" ofType:@"pdf"];
    NSURL *pdfurl = [NSURL fileURLWithPath:pdfStrig];
    
    NSData *pdfData = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pdf2" ofType:@"pdf"]];
    
    NSURL *imageurl = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1605265625525&di=f302c6821509013a3138ecd6fa1a10a0&imgtype=0&src=http%3A%2F%2Fa4.att.hudong.com%2F25%2F99%2F19300000421423134190997943822.jpg"];
    
    
    NSData *imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"111" ofType:@"png"]];
    
    UIImage *image = [UIImage imageNamed:@"background"];
    
    NSArray *array = @[pdfurl,pdfData,imageurl,image,imageData,[NSURL URLWithString:@""]];

    [self printFile:array];
    
    
    
}
// 数组里只能为 NSurl NSdata UIimage 三种对象  也只是pdf 和 图片类型
- (void)printFile:(NSArray *)array
{
    if (!array || array.count == 0) {
        return;
    }
    
    NSMutableArray *fileArray = [NSMutableArray array];
    for (id obj in array) {
        
        if ([obj isKindOfClass:[NSURL class]]) {
            if([UIPrintInteractionController canPrintURL:obj]) {
                [fileArray addObject:obj];
            }
        }else if ([obj isKindOfClass:[NSData class]]) {
            if([UIPrintInteractionController canPrintData:obj]) {
                [fileArray addObject:obj];
            }
        }else if ([obj isKindOfClass:[UIImage class]]) {
            [fileArray addObject:obj];
        }
    }
    
    if (fileArray.count > 0) {
        [self printDocumentFiles:fileArray];
    }

}

// 数组里只能为 nsurl nsdata uiimage 三种对象  也只是pdf 和 图片类型
- (void)printDocumentFiles:(NSArray *)array
{
    if (!array || array.count == 0) {
        return;
    }
    
    //打印任务的信息
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    //printInfo.jobName = [iFilePath lastPathComponent];

    
    UIPrintInteractionController *printController = [UIPrintInteractionController sharedPrintController];
    printController.delegate = self;
    printController.printingItems = array;
    printController.printInfo = printInfo;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        [printController presentFromRect:CGRectMake(10, 10, 10, 10) inView:self.view animated:YES completionHandler:^(UIPrintInteractionController *printInteractionController, BOOL completed, NSError *error) {
            if (completed) {
                NSLog(@"iPad print completed");
            } else {
                NSLog(@"iPad print fails");
            }
         }];
    }else{
        [printController presentAnimated:YES completionHandler:^(UIPrintInteractionController *printInteractionController, BOOL completed, NSError *error) {
            if (completed) {
                NSLog(@"iPhone print completed");
            } else {
                NSLog(@"iPhone print fails");
            }
        }];
    }
}



@end
