//
//  InitCaseInfo.m
//  GDRMXBYHMobile
//
//  Created by admin on 2018/12/7.
//
//#import "NSManagedObject+_NeedUpLoad_.h"
#import "TBXML.h"

#import "InitCaseInfo.h"

@implementation InitCaseInfo

-(void)downLoadcaseinfofortable:(NSString *)table withorgID:(NSString *)orgID withtypeID:(NSString *)typeID{
    WebServiceInit;
    //    WebServiceHandler *service=[[WebServiceHandler alloc] init];\
    //    service.delegate=self;
    //[service downloadDataSet:@"select * from UserInfo" orgid:orgID];
    //    [service downloadDataSet:[NSString stringWithFormat: @"select * from CaseInfo where CONVERT(nvarchar(10),happen_date,121) between '2018-01-01' and '2018-12-03' and case_type_id = 20 and organization_id = %@",orgID]];
    NSString * downstr = [NSString stringWithFormat: @"select * from CaseInfo where CONVERT(nvarchar(10),happen_date,121) between '2018-08-01' and '2050-12-03' and organization_id = %@ and case_type_id = %@",orgID,typeID];
    if (typeID == nil) {
//        downstr = [NSString stringWithFormat: @"select * from CaseInfo where CONVERT(nvarchar(10),happen_date,121) between '2018-08-01' and '2018-12-03' and organization_id = %@",orgID];
        downstr = [NSString stringWithFormat: @"select * from CaseInfo where organization_id = %@",orgID];
    }
    [service downloadDataSet:downstr withtypeID:typeID addtable:@"CaseInfo"];
    //    [service downloadDataSet:[NSString stringWithFormat: @"select * from CaseInfo where CONVERT(nvarchar(10),happen_date,121) between '2018-01-01' and '2018-12-03' and organization_id = %@",orgID]];
}
//-(void)downLoadcaseinfoforALLtable:(NSString *)table withorgID:(NSString *)orgID addcaseID:(NSString *)caseID{
//    WebServiceInit;
//    NSString * downstr = [NSString stringWithFormat: @"select * from %@ where myid = %@",table,caseID];
//    if ([table isEqualToString:@"Citizen"]) {
//        downstr = [NSString stringWithFormat: @"select * from %@ where proveinfo_id = %@",table,caseID];
//    }
//
//    [service downloadDataSet:downstr withtypeID:nil addtable:table];
//}

- (NSDictionary *)xmlParser:(NSString *)webString{
    NSString * dataModel = @"CaseInfo";
    NSArray * selectedisuploadedArray = [NSClassFromString(dataModel) selectedisuploadedArrayOfObjectwithtype:nil];
    NSManagedObjectContext *context = [[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity     = [NSEntityDescription entityForName:dataModel inManagedObjectContext:context];
    NSManagedObject * obj                          = [[NSClassFromString(dataModel) alloc]initWithEntity:entity insertIntoManagedObjectContext:context];
    for(obj in selectedisuploadedArray){
        [context deleteObject:obj];
    }
    //    [[AppDelegate App] clearEntityForName:dataModel];
//    [[AppDelegate App] saveContext];
    return [self autoParserForDataModel:@"CaseInfo" andInXMLString:webString];
}
- (NSDictionary *)xmlParser:(NSString *)webString withtypeID:(NSString *)typeID adddataModel:(NSString *)dataModel{
//    NSArray * selectedisuploadedArray = [NSClassFromString(dataModel) selectedisuploadedArrayOfObjectwithtype:typeID];
//    NSManagedObjectContext *context = [[AppDelegate App] managedObjectContext];
//    NSEntityDescription *entity     = [NSEntityDescription entityForName:dataModel inManagedObjectContext:context];
//    NSManagedObject * obj                          = [[NSClassFromString(dataModel) alloc]initWithEntity:entity insertIntoManagedObjectContext:context];
//    for(obj in selectedisuploadedArray){
//        [context deleteObject:obj];
//    }
//    [[AppDelegate App] clearEntityForName:dataModel];
    [[AppDelegate App] saveContext];
    return [self autoParserForDataModel:dataModel andInXMLString:webString];
}




@end
