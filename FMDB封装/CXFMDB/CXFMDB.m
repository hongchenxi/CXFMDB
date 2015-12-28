//
//  CXFMDB.m
//  FMDB封装
//
//  Created by 洪晨希 on 15/12/28.
//  Copyright © 2015年 洪晨希. All rights reserved.
//

#import "CXFMDB.h"
#import "NSString+CXFMDB.h"

@interface CXFMDB()

@property (nonatomic, strong) FMDatabaseQueue *queue;

@end

@implementation CXFMDB
singleton_implementation(CXFMDB)

+ (void)initialize{
    
    CXFMDB *cxFMDB = [CXFMDB sharedCXFMDB];
    
    NSDictionary *infoDic = [[NSBundle mainBundle]infoDictionary];
    NSString *key = (NSString *)kCFBundleNameKey;
    NSString *bundleName = infoDic[key];
    
//    NSString *dataBaseName = [NSString stringWithFormat:@"%@%@",bundleName,@".sqlite"];
    NSString *dataBaseName = [NSString stringWithFormat:@"%@%@",@"cxfmdb",@".sqlite"];
    NSString *dataBasePath = [bundleName.documentsSubFolder stringByAppendingPathComponent:dataBaseName];
    
    const BOOL needLogSqliteFilePath = YES;
    
    if (needLogSqliteFilePath) {
        NSLog(@"databasePath:%@",dataBasePath);
    }
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dataBasePath];
    if (queue == nil) {
        NSLog(@"创建数据库失败");
    }else{
        NSLog(@"创建数据库成功");
    }
    
    cxFMDB.queue = queue;
}

+ (BOOL)executeUpdate:(NSString *)sql{
    
    __block BOOL updateResult = NO;
    CXFMDB *cxFMDB = [CXFMDB sharedCXFMDB];
    [cxFMDB.queue inDatabase:^(FMDatabase *db) {
        updateResult = [db executeUpdate:sql];
    }];
    return updateResult;
    
}

+ (void)executeQuery:(NSString *)sql queryResultBlock:(void (^)(FMResultSet *))queryResultBlock{
    
    CXFMDB *cxFMDB = [CXFMDB sharedCXFMDB];
    [cxFMDB.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:sql];
        if (queryResultBlock != nil) {
            queryResultBlock(set);
        }
    }];
}


@end
