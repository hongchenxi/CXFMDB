//
//  CXFMDB.h
//  FMDB封装
//
//  Created by 洪晨希 on 15/12/28.
//  Copyright © 2015年 洪晨希. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXFMDBSingleton.h"
#import <FMDB.h>

@interface CXFMDB : NSObject
singleton_interface(CXFMDB)


+ (BOOL)executeUpdate:(NSString *)sql;

+ (void)executeQuery:(NSString *)sql queryResultBlock:(void(^)(FMResultSet *set))queryResultBlock;

@end
