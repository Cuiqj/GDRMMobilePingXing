//
//  InitCasePhoto.m
//  GDRMXBYHMobile
//
//  Created by admin on 2018/12/11.
//

#import "InitCasePhoto.h"

@implementation InitCasePhoto


- (void)downloadCasePhotoforOrgID:(NSString *)orgID{
    WebServiceInit;
    //[service downloadDataSet:@"select * from CityCode"orgid:orgID];
    [service downloadDataSet:[NSString stringWithFormat:@"select * from Photo where parent_id in (select id from casemap where organization_id=%@)",orgID]];
}

- (NSDictionary *)xmlParser:(NSString *)webString{
    NSString * dataModel = @"CasePhoto";
    NSArray * selectedisuploadedArray = [NSClassFromString(dataModel) selectedisuploadedArrayOfObjectwithtype:nil];
    NSManagedObjectContext *context = [[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity     = [NSEntityDescription entityForName:dataModel inManagedObjectContext:context];
    NSManagedObject * obj                          = [[NSClassFromString(dataModel) alloc]initWithEntity:entity insertIntoManagedObjectContext:context];
    for(obj in selectedisuploadedArray){
        [context deleteObject:obj];
    }
    //    [[AppDelegate App] clearEntityForName:dataModel];
    [[AppDelegate App] saveContext];
    return [self autoParserForDataModel:@"CasePhoto" andInXMLString:webString];
}


-(void)downLoadCaseDocumentsfortable:(NSString *)table withorgID:(NSString *)orgID withtypeID:(NSString *)typeID{
    WebServiceInit;
    NSString * downstr = [NSString stringWithFormat: @"select * from Photo where parent_id in (select id from caseinfo where organization_id= %@",orgID];
    [service downloadDataSet:downstr withtypeID:typeID addtable:@"CaseDocuments"];
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














- (NSDictionary *)autoParserForDataModel:(NSString *)dataModelName andInXMLString:(NSString *)xmlString{
    NSMutableDictionary *userinfo = [NSMutableDictionary dictionaryWithObject:dataModelName forKey:@"dataModelName"];
    [userinfo setObject:@"0" forKey:@"success"];
    [[AppDelegate App] clearEntityForName:dataModelName];
    NSError *error;
    TBXML *tbxml=[TBXML newTBXMLWithXMLString:xmlString error:&error];
    if (!error) {
        TBXMLElement *root = tbxml.rootXMLElement;
        if (!root) {
            return userinfo;
        }
        TBXMLElement *rf=[TBXML childElementNamed:@"soap:Body" parentElement:root];
        if (!rf) {
            return userinfo;
        }
        TBXMLElement *r1 = [TBXML childElementNamed:@"DownloadDataSetResponse" parentElement:rf];
        if(!r1){
            return userinfo;
        }
        TBXMLElement *r2 = [TBXML childElementNamed:@"DownloadDataSetResult" parentElement:r1];
        if(!r2){
            return userinfo;
        }
        TBXMLElement *r3 = [TBXML childElementNamed:@"diffgr:diffgram" parentElement:r2];
        if(!r3){
            return userinfo;
        }
        TBXMLElement *r4 = [TBXML childElementNamed:@"NewDataSet" parentElement:r3];
        if (!r4) {
            [userinfo setObject:@"2" forKey:@"success"];
            return userinfo;
        }
        TBXMLElement *table = r4->firstChild;
        while (table) {
            @autoreleasepool {
                NSManagedObjectContext *context = [[AppDelegate App] managedObjectContext];
                NSEntityDescription *entity     = [NSEntityDescription entityForName:dataModelName inManagedObjectContext:context];
                id obj                          = [[NSClassFromString(dataModelName) alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
                TBXMLElement *tableChild        = table->firstChild;
                while (tableChild) {
                    @autoreleasepool {
                        NSString *elementName = [[TBXML elementName:tableChild] lowercaseString];
                        if ([elementName isEqualToString:@"id"]) {
                            elementName = @"myid";
                        }
                        
//                        @"<id>%@</id>"map.myid
//                        "<parent_id>%@</parent_id>"proveinfo_id
//                        "<photo_name>%@</photo_name>"photo_name
//                        "<imagetype>JPG</imagetype>"
//                        "<data>%@</data>" stringImage
//                        "<remark>%@</remark>"  remark
                        
                        if ([dataModelName isEqualToString:@"CasePhoto" ]&& [elementName isEqualToString:@"proveinfo_id"]) {
                            elementName = @"proveinfo_id";
                        }
                        if ([dataModelName isEqualToString:@"UserInfo" ]&& [elementName isEqualToString:@"name"]) {
                            elementName = @"username";
                        }
                        if ([dataModelName isEqualToString:@"UserInfo" ]&& [elementName isEqualToString:@"org_id"]) {
                            elementName = @"organization_id";
                        }
                        if ([dataModelName isEqualToString:@"OrgInfo" ]&& [elementName isEqualToString:@"name"]) {
                            elementName = @"orgname";
                        }
                        if ([dataModelName isEqualToString:@"OrgInfo" ]&& [elementName isEqualToString:@"short_name"]) {
                            elementName = @"orgshortname";
                        }
                        //         初始化数据是本地还是下载的。以及上传状态
                        if ([obj respondsToSelector:@selector(isdowndata)]) {
                            [obj setValue:@(YES) forKey:@"isdowndata"];
                        }
                        if ([obj respondsToSelector:@selector(isuploaded)]) {
                            [obj setValue:@(YES) forKey:@"isuploaded"];
                        }
                        
                        if ([obj respondsToSelector:NSSelectorFromString(elementName)]) {
                            NSDictionary *attributes          = [entity attributesByName];
                            NSAttributeDescription *attriDesc = [attributes objectForKey:elementName];
                            //if(elementName isEqualToString:@"myid" &&)
                            switch (attriDesc.attributeType) {
                                case NSStringAttributeType:
                                    [obj setValue:[TBXML textForElement:tableChild] forKey:elementName];
                                    break;
                                case NSBooleanAttributeType:
                                    [obj setValue:@([TBXML textForElement:tableChild].boolValue) forKey:elementName];
                                    break;
                                case NSFloatAttributeType:
                                    [obj setValue:@([TBXML textForElement:tableChild].floatValue) forKey:elementName];
                                    break;
                                case NSDoubleAttributeType:
                                    [obj setValue:@([TBXML textForElement:tableChild].doubleValue) forKey:elementName];
                                    break;
                                case NSDateAttributeType:{
                                    NSString *dateString           = [TBXML textForElement:tableChild];
                                    dateString                     = [dateString stringByReplacingOccurrencesOfString:@":" withString:@""];
                                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HHmmss'.'SSSSSSSZ"];
                                    [obj setValue:[dateFormatter dateFromString:dateString] forKey:elementName];
                                    if (![dateFormatter dateFromString:dateString] ) {
                                        if ([dateString containsString:@"T"]) {
                                            NSArray * array = [dateString componentsSeparatedByString:@"T"];
                                            if ([array count] == 2) {
                                                NSString * Downdatestr1 = array[0];
                                                NSString * Downdatestr2 = array[1];
                                                if (Downdatestr2.length>6 && Downdatestr1.length == 10) {
                                                    NSString * Downdatestr = [NSString stringWithFormat:@"%@%@",Downdatestr1,[Downdatestr2 substringToIndex:6]];
                                                    [dateFormatter setDateFormat:@"yyyy-MM-ddHHmmss"];
                                                    [obj setValue:[dateFormatter dateFromString:Downdatestr] forKey:elementName];
                                                }
                                            }
                                        }
                                    }
                                }
                                    break;
                                case NSInteger16AttributeType:
                                case NSInteger32AttributeType:
                                case NSInteger64AttributeType:
                                    [obj setValue:@([TBXML textForElement:tableChild].integerValue) forKey:elementName];
                                    break;
                                default:
                                    break;
                            }
                            
                        }
                    }
                    tableChild = tableChild->nextSibling;
                }
                [[AppDelegate App] saveContext];
                table = table->nextSibling;
            }
        }
//        if([dataModelName isEqualToString:@"OrgInfo"]){
//            NSString* selectedOrgID=[[NSUserDefaults standardUserDefaults] stringForKey:ORGKEY];
//            OrgInfo *selectedOrg=[OrgInfo orgInfoForOrgID:selectedOrgID];
//            [selectedOrg setValue:@(YES) forKey:@"isselected"];
//            [[AppDelegate App] saveContext];
//        }
        [userinfo setObject:@"1" forKey:@"success"];
        return userinfo;
    }
    return userinfo;
}
@end
