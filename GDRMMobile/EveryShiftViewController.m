//
//  EveryShiftViewController.m
//  GDRMXBYHMobile
//
//  Created by admin on 2019/6/17.
//

#import "Inspection_Main.h"
#import "EveryShiftViewController.h"
#import "Inspection.h"
#import "UserInfo.h"
@interface EveryShiftViewController ()

@property (nonatomic,retain) Inspection_Main * inspectioneveryshift;

@end

@implementation EveryShiftViewController

- (void)viewDidLoad {
    //    scrollview未设置   故事板里含有
    [super viewDidLoad];
    self.title = @"本班次巡查信息汇总";
    self.contentscrollview.contentSize = CGSizeMake(900, 480);
    //显示时间    和     班次
    [self setdateforinspectioneveryshift];
    self.inspectioneveryshift = [Inspection_Main Inspection_MainForinspection_id:self.InspectionID];
    if (self.inspectioneveryshift == nil) {

    }else{
        [self loadinitdata];
    }
}

- (void)setdateforinspectioneveryshift{
//    if (self.inspectioneveryshift.date_inspection) {
//        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
//        //        [dateFormatter setLocale:[NSLocale currentLocale]];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//        self.textdate_inspection.text = [dateFormatter stringFromDate:self.inspectioneveryshift.date_inspection];
//    }else if (self.InspectionID.length >0) {
        Inspection * inspection = [Inspection oneDatainspectionForID:self.InspectionID];
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        self.textdate_inspection.text = [dateFormatter stringFromDate:inspection.date_inspection];
//    }
    self.textclasse.text = inspection.classe;
}

- (IBAction)DeleteDataClick:(id)sender {
    //删除表中 的某一项 指定数据   删除数据
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    if(self.inspectioneveryshift != nil){
        [context deleteObject:self.inspectioneveryshift];
    }else{
        
    }
    [[AppDelegate App] saveContext];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)BtnSaveDataClick:(id)sender {
    if (self.inspectioneveryshift == nil) {
        self.inspectioneveryshift = [Inspection_Main newDataObjectWithEntityName:@"Inspection_Main"];
        self.inspectioneveryshift.inspection_id = self.InspectionID;
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
//        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        self.inspectioneveryshift.date_inspection = [dateFormatter dateFromString:self.textdate_inspection.text];
        NSString * currentUserID= [[NSUserDefaults standardUserDefaults] stringForKey:USERKEY];
        NSString * orgID = [UserInfo userInfoForUserID:currentUserID].organization_id;
        self.inspectioneveryshift.org_id = orgID;
    }
    //保存除日期之外的所有显示数据
    [self btnSaveeveryshiftdata];
}
//
- (void)loadinitdata{
    //展示除日期外的所有数据
    self.textinspection_mile.text = self.inspectioneveryshift.inspection_mile;
    self.textinspection_man_num.text = self.inspectioneveryshift.inspection_man_num;
    self.textaccident_num.text = self.inspectioneveryshift.accident_num;
    self.textdeal_accident_num.text = self.inspectioneveryshift.deal_accident_num;
    self.textdeal_bxlp_num.text  = self.inspectioneveryshift.deal_bxlp_num;
    self.textfxqx.text = self.inspectioneveryshift.fxqx;
    self.textfxwfxw.text = self.inspectioneveryshift.fxwfxw;
    self.textjzwfxw.text = self.inspectioneveryshift.jzwfxw;
    
    self.textgasoline_amount.text =self.inspectioneveryshift.gasoline_amount;
    self.textcllmzaw.text = self.inspectioneveryshift.cllmzaw;
    self.textbzgzc.text = self.inspectioneveryshift.bzgzc;
    self.textjcsgd.text = self.inspectioneveryshift.jcsgd;
    self.textcorrect_construct_behaviour.text = self.inspectioneveryshift.correct_construct_behaviour;
    self.textqlxr.text = self.inspectioneveryshift.qlxr;
    self.textdissuade_person_times.text = self.inspectioneveryshift.dissuade_person_times;
    self.textservice_area_check.text = self.inspectioneveryshift.service_area_check;
    self.texttissue_shunt.text = self.inspectioneveryshift.tissue_shunt;
    self.texttissue_outfire.text = self.inspectioneveryshift.tissue_outfire;
    self.texttissue_advertise.text = self.inspectioneveryshift.tissue_advertise;
    self.textlaw_enforcement_work.text = self.inspectioneveryshift.law_enforcement_work;
    self.textdamage_road_asset_case.text = self.inspectioneveryshift.damage_road_asset_case;
    self.textofficial_car_use.text = self.inspectioneveryshift.official_car_use;
    
//    self.textgasoline_amount.text = [NSString stringWithFormat:@"%ld",self.inspectioneveryshift.gasoline_amount.integerValue];
//    self.textcllmzaw.text = [NSString stringWithFormat:@"%ld",self.inspectioneveryshift.cllmzaw.integerValue];
//    self.textbzgzc.text = [NSString stringWithFormat:@"%ld",self.inspectioneveryshift.bzgzc.integerValue];
//    self.textjcsgd.text = [NSString stringWithFormat:@"%ld",self.inspectioneveryshift.jcsgd.integerValue];
//    self.textcorrect_construct_behaviour.text = [NSString stringWithFormat:@"%ld",self.inspectioneveryshift.correct_construct_behaviour.integerValue];
//    self.textqlxr.text = [NSString stringWithFormat:@"%ld",self.inspectioneveryshift.qlxr.integerValue];
//    self.textdissuade_person_times.text = [NSString stringWithFormat:@"%ld",self.inspectioneveryshift.dissuade_person_times.integerValue];
//    self.textservice_area_check.text = [NSString stringWithFormat:@"%ld",self.inspectioneveryshift.service_area_check.integerValue];
//    self.texttissue_shunt.text = [NSString stringWithFormat:@"%ld",self.inspectioneveryshift.tissue_shunt.integerValue];
//    self.texttissue_outfire.text = [NSString stringWithFormat:@"%ld",self.inspectioneveryshift.tissue_outfire.integerValue];
//    self.texttissue_advertise.text = [NSString stringWithFormat:@"%ld",self.inspectioneveryshift.tissue_advertise.integerValue];
//    self.textlaw_enforcement_work.text = [NSString stringWithFormat:@"%ld",self.inspectioneveryshift.law_enforcement_work.integerValue];
//    self.textdamage_road_asset_case.text = [NSString stringWithFormat:@"%ld",self.inspectioneveryshift.damage_road_asset_case.integerValue];
//    self.textofficial_car_use.text = [NSString stringWithFormat:@"%ld",self.inspectioneveryshift.official_car_use.integerValue];
    
    self.textgzzfj.text = self.inspectioneveryshift.gzzfj;
    self.textfcflws.text = self.inspectioneveryshift.fcflws;
    self.textxcqxkj.text = self.inspectioneveryshift.xcqxkj;
}

- (void)btnSaveeveryshiftdata{
    self.inspectioneveryshift.inspection_mile = self.textinspection_mile.text;
    self.inspectioneveryshift.inspection_man_num = self.textinspection_man_num.text;
    self.inspectioneveryshift.accident_num =  self.textaccident_num.text;
    self.inspectioneveryshift.deal_accident_num = self.textdeal_accident_num.text;
    self.inspectioneveryshift.deal_bxlp_num = self.textdeal_bxlp_num.text;
    self.inspectioneveryshift.fxqx = self.textfxqx.text;
    self.inspectioneveryshift.fxwfxw = self.textfxwfxw.text;
    self.inspectioneveryshift.jzwfxw = self.textjzwfxw.text;
    
    self.inspectioneveryshift.gasoline_amount = self.textgasoline_amount.text;
    self.inspectioneveryshift.cllmzaw = self.textcllmzaw.text;
    self.inspectioneveryshift.bzgzc = self.textbzgzc.text;
    self.inspectioneveryshift.jcsgd = self.textjcsgd.text;
    self.inspectioneveryshift.correct_construct_behaviour = self.textcorrect_construct_behaviour.text;
    self.inspectioneveryshift.qlxr = self.textqlxr.text;
    self.inspectioneveryshift.dissuade_person_times = self.textdissuade_person_times.text;
    self.inspectioneveryshift.service_area_check = self.textservice_area_check.text;
    self.inspectioneveryshift.tissue_shunt = self.texttissue_shunt.text;
    self.inspectioneveryshift.tissue_outfire = self.texttissue_outfire.text;
    self.inspectioneveryshift.tissue_advertise = self.texttissue_advertise.text;
    self.inspectioneveryshift.law_enforcement_work = self.textlaw_enforcement_work.text;
    self.inspectioneveryshift.damage_road_asset_case = self.textdamage_road_asset_case.text;
    self.inspectioneveryshift.official_car_use = self.textofficial_car_use.text;
//    self.inspectioneveryshift.gasoline_amount = @(self.textgasoline_amount.text.integerValue);
//    self.inspectioneveryshift.cllmzaw = @(self.textcllmzaw.text.integerValue);
//    self.inspectioneveryshift.bzgzc = @(self.textbzgzc.text.integerValue);
//    self.inspectioneveryshift.jcsgd = @(self.textjcsgd.text.integerValue);
//    self.inspectioneveryshift.correct_construct_behaviour = @(self.textcorrect_construct_behaviour.text.integerValue);
//    self.inspectioneveryshift.qlxr = @(self.textqlxr.text.integerValue);
//    self.inspectioneveryshift.dissuade_person_times = @(self.textdissuade_person_times.text.integerValue);
//    self.inspectioneveryshift.service_area_check = @(self.textservice_area_check.text.integerValue);
//    self.inspectioneveryshift.tissue_shunt = @(self.texttissue_shunt.text.integerValue);
//    self.inspectioneveryshift.tissue_outfire = @(self.texttissue_outfire.text.integerValue);
//    self.inspectioneveryshift.tissue_advertise = @(self.texttissue_advertise.text.integerValue);
//    self.inspectioneveryshift.law_enforcement_work = @(self.textlaw_enforcement_work.text.integerValue);
//    self.inspectioneveryshift.damage_road_asset_case = @(self.textdamage_road_asset_case.text.integerValue);
//    self.inspectioneveryshift.official_car_use = @(self.textofficial_car_use.text.integerValue);

    self.inspectioneveryshift.gzzfj = self.textgzzfj.text;
    self.inspectioneveryshift.fcflws = self.textfcflws.text;
    self.inspectioneveryshift.xcqxkj = self.textxcqxkj.text;
}
@end
