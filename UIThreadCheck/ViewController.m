//
//  ViewController.m
//  UIThreadCheck
//
//  Created by fdd on 2018/1/18.
//  Copyright © 2018年 fdd. All rights reserved.
//

#import "ViewController.h"
//#import "UIView+ThreadCheck.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self test01];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)test01 {//非主线程运行的例子
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(100, 100, 100, 100);
    
    
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", NULL);
    dispatch_async(serialQueue, ^{
        [self.view addSubview:view];
        NSLog(@"%@" , [NSThread currentThread]);
    });
}
- (void)test02 {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:view];
    NSLog(@"%@" , [NSThread currentThread]);
}
@end
