//
//  InitCaseInfo.h
//  GDRMXBYHMobile
//
//  Created by admin on 2018/12/7.
//
#import <Foundation/Foundation.h>
#import "InitData.h"

@interface InitCaseInfo : InitData

-(void)downLoadcaseinfofortable:(NSString *)table withorgID:(NSString *)orgID withtypeID:(NSString *)typeID;

//-(void)downLoadcaseinfoforALLtable:(NSString *)table withorgID:(NSString *)orgID addcaseID:(NSString *)caseID;


- (NSDictionary *)xmlParser:(NSString *)webString withtypeID:(NSString *)typeID adddataModel:(NSString *)dataModel;
@end

