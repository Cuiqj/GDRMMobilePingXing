//
//  Inspection.m
//  GDRMMobile
//
//  Created by yu hongwu on 12-11-26.
//
//

#import "Inspection.h"


@implementation Inspection

@dynamic carcode;
@dynamic classe;
@dynamic date_inspection;
@dynamic delivertext;
@dynamic duty_leader;
@dynamic inspection_description;
@dynamic inspection_milimetres;
@dynamic inspection_place;
@dynamic inspectionor_name;
@dynamic isdeliver;
@dynamic isuploaded;
@dynamic myid;
@dynamic organization_id;
@dynamic recorder_name;
@dynamic remark;
@dynamic time_end;
@dynamic time_start;
@dynamic weather;
@dynamic fuzeren;
@dynamic yjsx;
@dynamic yjzb;
@dynamic yjr;
@dynamic jsr;
@dynamic yjsj;
@dynamic isdowndata;

- (NSString *) signStr{
    if (![self.myid isEmpty]) {
        return [NSString stringWithFormat:@"myid == %@", self.myid];
    }else{
        return @"";
    }
}

+(NSArray *)inspectionForDownData{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Inspection" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    //    NSSortDescriptor *sortByCaseMark2=[NSSortDescriptor sortDescriptorWithKey:@"case_mark2.integerValue" ascending:NO];
    //    NSSortDescriptor *sortByCaseMark3=[NSSortDescriptor sortDescriptorWithKey:@"case_mark3.integerValue" ascending:NO];
    NSSortDescriptor *sortByCaseMark2=[NSSortDescriptor sortDescriptorWithKey:@"date_inspection" ascending:NO];
    NSArray *sortArray=[NSArray arrayWithObjects:sortByCaseMark2,nil];
    [fetchRequest setSortDescriptors:sortArray];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"isdowndata == YES && isdeliver.boolValue == YES"]];
    NSError *error;
    return [context executeFetchRequest:fetchRequest error:&error] ;
}

+ (NSArray *)inspectionForID:(NSString *)inspectionID{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    NSSortDescriptor *sortDS=[[NSSortDescriptor alloc] initWithKey:@"date_inspection" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDS]];
    [fetchRequest setEntity:entity];
    if (![inspectionID isEmpty]) {
        [fetchRequest setPredicate:[NSPredicate  predicateWithFormat:@"myid == %@ && isdowndata != YES",inspectionID]];
    } else {
        [fetchRequest setPredicate:[NSPredicate  predicateWithFormat:@"isdeliver.boolValue == YES && isdowndata != YES"]];
    }
    return [context executeFetchRequest:fetchRequest error:nil];
}

+ (NSArray *)inspectionDownDataForID:(NSString *)inspectionID{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    NSSortDescriptor *sortDS=[[NSSortDescriptor alloc] initWithKey:@"date_inspection" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDS]];
    [fetchRequest setEntity:entity];
    if (![inspectionID isEmpty]) {
        [fetchRequest setPredicate:[NSPredicate  predicateWithFormat:@"myid == %@ && isdowndata == YES",inspectionID]];
    } else {
        [fetchRequest setPredicate:[NSPredicate  predicateWithFormat:@"isdeliver.boolValue == YES && isdowndata == YES"]];
    }
    return [context executeFetchRequest:fetchRequest error:nil];
}

/*add by lxm
 *  新增删除历史巡查
 *
 *
 + (void)deleteInspectionForID:(NSString *)inspectionID withHistoryID:(NSString *)historyID{
 if (inspectionID && ![inspectionID isEmpty]) {
 NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
 NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
 NSPredicate *predicate=[NSPredicate predicateWithFormat:@"myid ==%@ && document_name == %@",inspectionID,historyID];
 NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
 [fetchRequest setEntity:entity];
 [fetchRequest setPredicate:predicate];
 NSArray *temp = [context executeFetchRequest:fetchRequest error:nil];
 for (CaseDocuments *doc in temp) {
 if ([[NSFileManager defaultManager] fileExistsAtPath:doc.document_path]){
 [[NSFileManager defaultManager] removeItemAtPath:doc.document_path error:nil];
 }
 [context deleteObject:doc];
 [[AppDelegate App] saveContext];
 }
 }
 }
 */
+(NSDate *)inspectionfortime_endsettingtimeyjsj:(NSDate *)time_end andtime_start:(NSDate *)time_start andclasse:(NSString *)classe{
    NSDate * temp;
    NSDateFormatter * matter = [[NSDateFormatter alloc] init];
    [matter setDateFormat:@"yyyy年MM月dd日"];
    NSString * timestring;
    if([classe containsString:@"晚班"]){
        temp = time_end;
        timestring = [NSString stringWithFormat:@"%@08时00分",[matter stringFromDate:temp]];
    }else if([classe containsString:@"早班"]){
        temp = time_start;
        timestring = [NSString stringWithFormat:@"%@16时00分",[matter stringFromDate:temp]];
    }else if([classe containsString:@"中班"]){
        temp = [NSDate dateWithTimeInterval:24*60*60 sinceDate:time_start];
        timestring = [NSString stringWithFormat:@"%@00时00分",[matter stringFromDate:temp]];
    }
    [matter setDateFormat:@"yyyy年MM月dd日HH时mm分"];
    return [matter dateFromString:timestring];
}

@end
