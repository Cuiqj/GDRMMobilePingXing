//
//  InitCitizen.m
//  GDRMXBYHMobile
//
//  Created by admin on 2018/12/11.
//

#import "InitCitizen.h"

@implementation InitCitizen
- (void)downloadCitizenforOrgID:(NSString *)orgID{
    WebServiceInit;
    //[service downloadDataSet:@"select * from CityCode"orgid:orgID];
    [service downloadDataSet:[NSString stringWithFormat:@"select * from Citizen where proveinfo_id in (select id from caseinfo where organization_id=%@)",orgID]];
}

- (NSDictionary *)xmlParser:(NSString *)webString{
//    NSString * dataModel = @"Citizen";
//    NSArray * selectedisuploadedArray = [NSClassFromString(dataModel) selectedisuploadedArrayOfObjectwithtype:nil];
//    NSManagedObjectContext *context = [[AppDelegate App] managedObjectContext];
//    NSEntityDescription *entity     = [NSEntityDescription entityForName:dataModel inManagedObjectContext:context];
//    NSManagedObject * obj                          = [[NSClassFromString(dataModel) alloc]initWithEntity:entity insertIntoManagedObjectContext:context];
//    for(obj in selectedisuploadedArray){
//        [context deleteObject:obj];
//    }
    //    [[AppDelegate App] clearEntityForName:dataModel];
//    [[AppDelegate App] saveContext];
    return [self autoParserForDataModel:@"Citizen" andInXMLString:webString];
}

- (void)downLoadCitizenfortable:(NSString *)table withorgID:(NSString *)orgID withtypeID:(NSString *)typeID{
    WebServiceInit;
    NSString * downstr = [NSString stringWithFormat: @"select * from Citizen where proveinfo_id in (select id from caseinfo where organization_id=%@",orgID];
    [service downloadDataSet:downstr withtypeID:typeID addtable:@"Citizen"];
    //    [service downloadDataSet:[NSString stringWithFormat: @"select * from CaseInfo where CONVERT(nvarchar(10),happen_date,121) between '2018-01-01' and '2018-12-03' and organization_id = %@",orgID]];
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
    return [self autoParserForDataModel:dataModel andInXMLString:webString];
}




@end
