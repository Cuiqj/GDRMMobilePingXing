//
//  InspectionPath.h
//  GDRMMobile
//
//  Created by Sniper One on 12-11-15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseManageObject.h"

@interface InspectionPath : BaseManageObject

@property (nonatomic, retain) NSDate * checktime;
@property (nonatomic, retain) NSString * inspectionid;
@property (nonatomic, retain) NSString * myid;
@property (nonatomic, retain) NSString * stationname;
@property (nonatomic, retain) NSNumber * isuploaded;

//记录数据是否本地创建或者下载，不上传。 yes下载的      no是本地数据
@property (nonatomic, retain) NSNumber * isdowndata;

//+ (NSArray *)pathsForInspection:(NSString *)inspectionID;
+ (NSArray *)pathsForInspection:(NSString *)inspectionID andisdowndata:(BOOL)isdowndata;


@end
