//
//  DataSimple.m
//  Book
//
//  Created by admin on 2019/9/17.
//  Copyright © 2019 zhongjiaoyuke. All rights reserved.
//

#import "DataSimple.h"
static DataSimple * simple;

@implementation DataSimple
+ (instancetype)shareSimpleData{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        simple = [[DataSimple alloc]init];
    });
    return simple;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    if (!simple) {
        simple = [DataSimple shareSimpleData];
    }
    return simple;
}
- (id)copy{
    return self;
}
- (id)mutableCopy{
    return self;
}

@end
