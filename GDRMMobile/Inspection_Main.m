//
//  Inspection_Main.m
//  GDRMPingXingMobile
//
//  Created by admin on 2019/7/1.
//

#import "Inspection_Main.h"

@implementation Inspection_Main

@dynamic myid;
@dynamic inspection_id;
@dynamic date_inspection;
@dynamic inspection_mile;
@dynamic inspection_man_num;
@dynamic accident_num;
@dynamic deal_accident_num;
@dynamic deal_bxlp_num;
@dynamic fxqx;
@dynamic fxwfxw;
@dynamic jzwfxw;
@dynamic gasoline_amount;
@dynamic cllmzaw;
@dynamic bzgzc;
@dynamic jcsgd;
@dynamic correct_construct_behaviour;
@dynamic qlxr;
@dynamic dissuade_person_times;
@dynamic service_area_check;
@dynamic tissue_shunt;
@dynamic tissue_outfire;
@dynamic tissue_advertise;
@dynamic law_enforcement_work;
@dynamic damage_road_asset_case;
@dynamic official_car_use; 
@dynamic gzzfj;
@dynamic fcflws;
@dynamic xcqxkj;
@dynamic isuploaded;


+(Inspection_Main *)Inspection_MainForinspection_id:(NSString*)inspection_id{
    if(inspection_id==nil) return nil;
    NSManagedObjectContext *context = [[ AppDelegate  App ] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context ];
    NSFetchRequest *fetchRequest    = [[NSFetchRequest alloc] init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"inspection_id==%@",inspection_id];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];
    NSArray * arr = [context executeFetchRequest:fetchRequest error:nil];
    if(arr.count>0)
        return [[context executeFetchRequest:fetchRequest error:nil] objectAtIndex:0];
    else
        return nil;
}

@end
