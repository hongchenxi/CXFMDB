//
//  NSString+CXFMDB.m
//  FMDB封装
//
//  Created by 洪晨希 on 15/12/28.
//  Copyright © 2015年 洪晨希. All rights reserved.
//

#import "NSString+CXFMDB.h"

@implementation NSString (CXFMDB)

- (NSString *)documentsSubFolder{
    
    NSString *documentFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    
    return [NSString mkFolderWithParentFolder:documentFolder andChirldFoloder:self];
}

+ (NSString *)mkFolderWithParentFolder:(NSString *)parentFolder andChirldFoloder:(NSString *)chirldFolder{
    
    NSString *folder = [NSString stringWithFormat:@"%@/%@",parentFolder,chirldFolder];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isexis = [fileManager fileExistsAtPath:folder isDirectory:&isDir];
    
    if (!(isexis == YES && isDir)) {
        [fileManager createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return folder;
}




@end
