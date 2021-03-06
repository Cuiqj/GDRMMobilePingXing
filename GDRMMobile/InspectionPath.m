//
//  InspectionPath.m
//  GDRMMobile
//
//  Created by Sniper One on 12-11-15.
//
//

#import "InspectionPath.h"


@implementation InspectionPath

@dynamic checktime;
@dynamic inspectionid;
@dynamic myid;
@dynamic stationname;
@dynamic isuploaded;
@dynamic isdowndata;

- (NSString *) signStr{
    if (![self.inspectionid isEmpty]) {
        return [NSString stringWithFormat:@"inspectionid == %@", self.inspectionid];
    }else{
        return @"";
    }
}


// 过站记录数组查询  添加时间排序
+ (NSArray *)pathsForInspection:(NSString *)inspectionID andisdowndata:(BOOL)isdowndata{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    if (![inspectionID isEmpty]) {
//        [fetchRequest setPredicate:[NSPredicate  predicateWithFormat:@"inspectionid == %@",inspectionID]];
        NSPredicate * predicate = [NSPredicate  predicateWithFormat:@"inspectionid == %@ && isdowndata != YES",inspectionID];
        if (isdowndata) {
            predicate = [NSPredicate  predicateWithFormat:@"inspectionid == %@ && isdowndata == YES ",inspectionID];
        }
        [fetchRequest setPredicate:predicate];
    } else {
        [fetchRequest setPredicate:nil];
    }
    
//    NSPredicate * predicate = [NSPredicate  predicateWithFormat:@"inspectionid == %@ isdowndata != YES",inspectionID];
//    if (isdowndata) {
//        predicate = [NSPredicate  predicateWithFormat:@"inspectionid == %@ && isdowndata == YES ",inspectionID];
//    }
//    [fetchRequest setPredicate:predicate];
    
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"checktime" ascending:NO];
//    [fetchRequest setSortDescriptors: [NSArray arrayWithObject: sortDescriptor]];
    return [context executeFetchRequest:fetchRequest error:nil];
}
@end
