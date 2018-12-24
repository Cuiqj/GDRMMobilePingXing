//
//  InitCaseProveInfo.m
//  GDRMXBYHMobile
//
//  Created by admin on 2018/12/11.
//

#import "InitCaseProveInfo.h"

@implementation InitCaseProveInfo

- (void)downloadCaseProveInfoforOrgID:(NSString *)orgID{
    WebServiceInit;
    //[service downloadDataSet:@"select * from CityCode"orgid:orgID];
    [service downloadDataSet:[NSString stringWithFormat:@"select * from CaseProveInfo where caseinfo_id in (select id from caseinfo where organization_id=%@)",orgID]];
}

- (NSDictionary *)xmlParser:(NSString *)webString{
//    NSString * dataModel = @"CaseProveInfo";
//    NSArray * selectedisuploadedArray = [NSClassFromString(dataModel) selectedisuploadedArrayOfObjectwithtype:nil];
//    NSManagedObjectContext *context = [[AppDelegate App] managedObjectContext];
//    NSEntityDescription *entity     = [NSEntityDescription entityForName:dataModel inManagedObjectContext:context];
//    NSManagedObject * obj                          = [[NSClassFromString(dataModel) alloc]initWithEntity:entity insertIntoManagedObjectContext:context];
//    for(obj in selectedisuploadedArray){
//        [context deleteObject:obj];
//    }
    //    [[AppDelegate App] clearEntityForName:dataModel];
//    [[AppDelegate App] saveContext];
    return [self autoParserForDataModel:@"CaseProveInfo" andInXMLString:webString  andtype:nil];
}

- (void)downLoadCaseProveInfofortable:(NSString *)table withorgID:(NSString *)orgID withtypeID:(NSString *)typeID{
    WebServiceInit;
    NSString * downstr = [NSString stringWithFormat: @"select * from CaseProveInfo where caseinfo_id in (select id from caseinfo where organization_id=%@",orgID];
    [service downloadDataSet:downstr withtypeID:typeID addtable:@"CaseProveInfo"];
}
- (NSDictionary *)xmlParser:(NSString *)webString withtypeID:(NSString *)typeID adddataModel:(NSString *)dataModel{
    NSArray * selectedisuploadedArray = [NSClassFromString(dataModel) selectedisuploadedArrayOfObjectwithtype:typeID];
    NSManagedObjectContext *context = [[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity     = [NSEntityDescription entityForName:dataModel inManagedObjectContext:context];
    NSManagedObject * obj                          = [[NSClassFromString(dataModel) alloc]initWithEntity:entity insertIntoManagedObjectContext:context];
    for(obj in selectedisuploadedArray){
        [context deleteObject:obj];
    }
    //    [[AppDelegate App] clearEntityForName:dataModel];
    [[AppDelegate App] saveContext];
    return [self autoParserForDataModel:dataModel andInXMLString:webString  andtype:nil];
}

@end
