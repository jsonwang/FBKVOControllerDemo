//
//  ViewController.m
//  FBKVODemo
//
//  Created by AK on 2017/10/9.
//  Copyright © 2017年 xingkongchuangtou. All rights reserved.
//

#import "ViewController.h"

#import "FBKVOController.h"
#import "NSObject+FBKVOController.h"

#import "model.h"
@interface ViewController ()
{
    FBKVOController *fbKVO;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    model * m = [[model alloc] init];
    m.name=@"one";
    NSMutableArray * books = [[NSMutableArray alloc] initWithObjects:@"1", nil];
    m.books = books;
    //初始化
    fbKVO=[FBKVOController controllerWithObserver:self];
    
    //注册通过block 方式直接获取监听
    
    [fbKVO observe:m keyPaths:@[@"name",@"books"] options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        NSLog(@"发生改变 %@",change);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        m.name=@"two";
        
        NSMutableArray * books = [[NSMutableArray alloc] initWithObjects:@"2", nil];
        m.books = books;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            m.name=@"three";
            
            NSMutableArray * books = [[NSMutableArray alloc] initWithObjects:@"3", nil];
            m.books = books;
        });
    });
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
