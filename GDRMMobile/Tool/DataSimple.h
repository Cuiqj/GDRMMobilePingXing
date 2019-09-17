//
//  DataSimple.h
//  Book
//
//  Created by admin on 2019/9/17.
//  Copyright © 2019 zhongjiaoyuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSimple : NSObject


+ (instancetype)shareSimpleData;

@property (nonatomic,strong) NSString * orgid;
@property (nonatomic,strong) NSString * user;
@property (nonatomic,strong) NSMutableArray * userarray;
@property (nonatomic,strong) NSString * inspection_id;
@end
