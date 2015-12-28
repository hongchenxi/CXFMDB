//
//  ViewController.m
//  FMDB封装
//
//  Created by 洪晨希 on 15/12/28.
//  Copyright © 2015年 洪晨希. All rights reserved.
//

#import "ViewController.h"
#import "CXFMDB.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    BOOL result = [CXFMDB executeUpdate:@"create table if not exists t_students(id integer primary key autoIncrement, name text not null, age integer not null);"];
    if (result) {
        NSLog(@"创建students表成功");
    }else{
        NSLog(@"创建students表失败");
    }
    
   
    
    for (int i = 0; i < 20; i++) {
        
        NSString *name = [NSString stringWithFormat:@"'cx%d'",i];
        
        int age = i;
        
        NSString *sqlStr = [NSString stringWithFormat:@"insert into t_students(name, age)values(%@, %d);",name,age];
        
        BOOL insertResult = [CXFMDB executeUpdate:sqlStr];
        
        if (insertResult) {
            NSLog(@"插入数据成功");
        }else{
            NSLog(@"插入数据失败");
        }
        
    }
    
    
    NSString *sqlStr = @"select * from t_students;";
    [CXFMDB executeQuery:sqlStr queryResultBlock:^(FMResultSet *set) {
        while ([set next]) {
            NSLog(@"name:%@ - age:%d",[set stringForColumn:@"name"], [set intForColumn:@"age"]);

        }
    }];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
