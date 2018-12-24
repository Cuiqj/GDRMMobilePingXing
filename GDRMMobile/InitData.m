////
////  InitData.m
////  GDRMMobile
////
////  Created by yu hongwu on 12-10-9.
////
////
//
//#import "InitData.h"
//
//@implementation InitData
//@synthesize currentOrgID = _currentOrgID;
//
//- (void)getWebServiceReturnString:(NSString *)webString forWebService:(NSString *)serviceName{
//    NSDictionary *userInfo = [self xmlParser:webString];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"ParserFinished" object:nil userInfo:userInfo];
//}
//
//
//- (id)initWithOrgID:(NSString *)orgID{
//    self=[super init];
//    if (self) {
//        self.currentOrgID=orgID;
//    }
//    return self;
//}
//
//
//- (NSDictionary *)autoParserForDataModel:(NSString *)dataModelName andInXMLString:(NSString *)xmlString{
//    NSMutableDictionary *userinfo = [NSMutableDictionary dictionaryWithObject:dataModelName forKey:@"dataModelName"];
//    [userinfo setObject:@"0" forKey:@"success"];
//
//    [[AppDelegate App] clearEntityForName:dataModelName];
//    NSError *error;
//    TBXML *tbxml=[TBXML newTBXMLWithXMLString:xmlString error:&error];
//    if (!error) {
//        TBXMLElement *root=tbxml.rootXMLElement;
//        TBXMLElement *rf=[TBXML childElementNamed:@"soap:Body" parentElement:root];
//
//        TBXMLElement *r1 = [TBXML childElementNamed:@"downloadDataSetResponse" parentElement:rf];
//        TBXMLElement *r2 = [TBXML childElementNamed:@"out" parentElement:r1];
//        //        TBXMLElement *r3 = [TBXML childElementNamed:@"diffgr:diffgram" parentElement:r2];
//        TBXMLElement *r3 = [TBXML childElementNamed:@"NewDataSet" parentElement:r2];
//        TBXMLElement *table=r3->firstChild;
//        while (table) {
//            @autoreleasepool {
//                NSManagedObjectContext *context = [[AppDelegate App] managedObjectContext];
//                NSEntityDescription *entity = [NSEntityDescription entityForName:dataModelName inManagedObjectContext:context];
//                id obj = [[NSClassFromString(dataModelName) alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
//                TBXMLElement *tableChild = table->firstChild;
//                while (tableChild) {
//                    @autoreleasepool {
//                        NSString *elementName = [[TBXML elementName:tableChild] lowercaseString];
//                        if ([elementName isEqualToString:@"id"]) {
//                            elementName = @"myid";
//                        }
//                        if ([obj respondsToSelector:NSSelectorFromString(elementName)]) {
//                            NSDictionary *attributes = [entity attributesByName];
//                            NSAttributeDescription *attriDesc = [attributes objectForKey:elementName];
//                            switch (attriDesc.attributeType) {
//                                case NSStringAttributeType:
//                                    [obj setValue:[TBXML textForElement:tableChild] forKey:elementName];
//                                    break;
//                                case NSBooleanAttributeType:
//                                    [obj setValue:@([TBXML textForElement:tableChild].boolValue) forKey:elementName];
//                                    break;
//                                case NSFloatAttributeType:
//                                    [obj setValue:@([TBXML textForElement:tableChild].floatValue) forKey:elementName];
//                                    break;
//                                case NSDoubleAttributeType:
//                                    [obj setValue:@([TBXML textForElement:tableChild].doubleValue) forKey:elementName];
//                                    break;
//                                case NSDateAttributeType:{
//                                    NSString *dateString = [TBXML textForElement:tableChild];
//                                    dateString = [dateString stringByReplacingOccurrencesOfString:@":" withString:@""];
//                                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HHmmss'.'SSSSSSSZ"];
//                                    [obj setValue:[dateFormatter dateFromString:dateString] forKey:elementName];
//                                }
//                                    break;
//                                case NSInteger16AttributeType:
//                                case NSInteger32AttributeType:
//                                case NSInteger64AttributeType:
//                                    [obj setValue:@([TBXML textForElement:tableChild].integerValue) forKey:elementName];
//                                    break;
//                                default:
//                                    break;
//                            }
//
//                        }
//                    }
//                    tableChild = tableChild->nextSibling;
//                }
//                [[AppDelegate App] saveContext];
//                table = table->nextSibling;
//            }
//        }
//        [userinfo setObject:@"1" forKey:@"success"];
//        return userinfo;
//    }
//    return userinfo;
//}
//
//- (NSDictionary *)xmlParser:(NSString *)webString{
//    return nil;
//};
//
//@end


static NSArray  *dataNameArray = {@"CaseInfo",@"CaseMap",@"Citizen",@"CaseProveInfo",@"CaseDeformations",@"CaseInquire",@"InspectionRecord",@"InspectionPath",@"Inspection"};
;
//
//  InitData.m
//  GDRMMobile
//
//  Created by yu hongwu on 12-10-9.
//
//

#import "InitData.h"
#import "OrgInfo.h"
#import "AppDelegate.h"
@implementation InitData

- (void)getWebServiceReturnString:(NSString *)webString forWebService:(NSString *)serviceName{
    NSDictionary *userInfo = [self xmlParser:webString];
    
    
    NSString * dataModelName =[userInfo objectForKey:@"dataModelName"];
    if([dataModelName isEqualToString:@"InspectionRecord"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DownLoadDataFinished" object:nil userInfo:userInfo];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ParserFinished" object:nil userInfo:userInfo];
    
    
    
}
- (BOOL)isContainsStringwithDataModelName:(NSString *)dataModelName{
    for (NSString * str in dataNameArray) {
        if ([dataModelName isEqualToString:str]) {
            return YES;
        }
    }
    return NO;
}
//[dataModelName isEqualToString:@"CaseInfo"] || [dataModelName isEqualToString:@"CaseMap"]||[dataModelName isEqualToString:@"Citizen"]|| [dataModelName isEqualToString:@"CaseProveInfo"]||[dataModelName isEqualToString:@"CaseDeformations"] || [dataModelName isEqualToString:@"CaseInquire"]|| [dataModelName isEqualToString:@"Citizen"]|| [dataModelName isEqualToString:@"CaseProveInfo"]|| [dataModelName isEqualToString:@"CaseDeformations"]
- (NSDictionary *)autoParserForDataModel:(NSString *)dataModelName andInXMLString:(NSString *)xmlString{
    NSMutableDictionary *userinfo = [NSMutableDictionary dictionaryWithObject:dataModelName forKey:@"dataModelName"];
    [userinfo setObject:@"0" forKey:@"success"];
//    if ([self isContainsStringwithDataModelName:dataModelName]) {
    if ([dataModelName isEqualToString:@"CaseInfo"] || [dataModelName isEqualToString:@"CaseMap"]||[dataModelName isEqualToString:@"Citizen"]|| [dataModelName isEqualToString:@"CaseProveInfo"]||[dataModelName isEqualToString:@"CaseDeformations"] || [dataModelName isEqualToString:@"CaseInquire"]|| [dataModelName isEqualToString:@"InspectionPath"]|| [dataModelName isEqualToString:@"InspectionRecord"]|| [dataModelName isEqualToString:@"Inspection"]) {
        [[AppDelegate App] clearEntityForNameandisdowndata:dataModelName];
    }else{
        [[AppDelegate App] clearEntityForName:dataModelName];
    }
  
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
                        if ([dataModelName isEqualToString:@"UserInfo" ]&& [elementName isEqualToString:@"code"]) {
                            elementName = @"account";
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
        if([dataModelName isEqualToString:@"OrgInfo"]){
            NSString* selectedOrgID=[[NSUserDefaults standardUserDefaults] stringForKey:ORGKEY];
            OrgInfo *selectedOrg=[OrgInfo orgInfoForOrgID:selectedOrgID];
            [selectedOrg setValue:@(YES) forKey:@"isselected"];
            [[AppDelegate App] saveContext];
        }
        [userinfo setObject:@"1" forKey:@"success"];
        return userinfo;
    }
    return userinfo;
}

- (NSDictionary *)xmlParser:(NSString *)webString{
    return nil;
};
- (NSDictionary *)xmlParser:(NSString *)webString withtypeID:(NSString *)typeID adddataModel:(NSString *)dataModel{
    return nil;
}
- (void)requestTimeOut{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DownLoadTimeOut" object:nil userInfo:nil];
}
- (void)requestUnkownError{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DownLoadUnkownError" object:nil userInfo:nil];
}

#pragma mark - 下载案件巡查及施工数据
- (void)getWebServiceReturnString:(NSString *)webString forWebService:(NSString *)serviceName adddataModel:(NSString *)dataModel withtypeID:(NSString *)typeID{
    NSDictionary *userInfo = [self xmlParser:webString withtypeID:typeID adddataModel:dataModel];
    
    //    NSString *dataModelName= [userInfo objectForKey:@"dataModelName"];
    if ([dataModel isEqualToString:@"CaseInquire"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DownLoadDataFinished" object:nil userInfo:userInfo];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ParserFinished" object:nil userInfo:userInfo];
    
}
- (NSDictionary *)autoParserForDataModel:(NSString *)dataModelName andInXMLString:(NSString *)xmlString andtype:(NSString *)type{
    NSMutableDictionary *userinfo = [NSMutableDictionary dictionaryWithObject:dataModelName forKey:@"dataModelName"];
    [userinfo setObject:@"0" forKey:@"success"];
//    if (![dataModelName isEqualToString:@"CaseInfo"] || ![dataModelName isEqualToString:@"CaseMap"]|| ![dataModelName isEqualToString:@"Citizen"]|| ![dataModelName isEqualToString:@"CaseProveInfo"]|| ![dataModelName isEqualToString:@"CaseDeformations"] || ![dataModelName isEqualToString:@"CaseInquire"]|| ![dataModelName isEqualToString:@"Citizen"]|| ![dataModelName isEqualToString:@"CaseProveInfo"]|| ![dataModelName isEqualToString:@"CaseDeformations"]    ) {
//        [[AppDelegate App] clearEntityForName:dataModelName];
//    }
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
                        if ([dataModelName isEqualToString:@"UserInfo" ]&& [elementName isEqualToString:@"code"]) {
                            elementName = @"account";
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
        if([dataModelName isEqualToString:@"OrgInfo"]){
            NSString* selectedOrgID=[[NSUserDefaults standardUserDefaults] stringForKey:ORGKEY];
            OrgInfo *selectedOrg=[OrgInfo orgInfoForOrgID:selectedOrgID];
            [selectedOrg setValue:@(YES) forKey:@"isselected"];
            [[AppDelegate App] saveContext];
        }
        [userinfo setObject:@"1" forKey:@"success"];
        return userinfo;
    }
    return userinfo;
}


@end
