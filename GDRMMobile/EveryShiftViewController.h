//
//  EveryShiftViewController.h
//  GDRMXBYHMobile
//
//  Created by admin on 2019/6/17.
//

#import <UIKit/UIKit.h>

@interface EveryShiftViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *textdate_inspection;

@property (weak, nonatomic) IBOutlet UITextField *textclasse;  //班次
@property (weak, nonatomic) IBOutlet UITextField *textinspection_mile;               //当日巡查里程     当班"
@property (weak, nonatomic) IBOutlet UITextField *textinspection_man_num;           //当日参加巡查人次"  当班    "8/4"
@property (weak, nonatomic) IBOutlet UITextField *textaccident_num;                 //发生交通事故/其中涉及路产损害" "0/0"
@property (weak, nonatomic) IBOutlet UITextField *textdeal_accident_num;            //处理路产损害赔偿" "0/0"
@property (weak, nonatomic) IBOutlet UITextField *textdeal_bxlp_num;                 //处理路产保险理赔案件" "0/0"
@property (weak, nonatomic) IBOutlet UITextField *textfxqx;                         //发现报送道路、交安设施缺陷"
@property (weak, nonatomic) IBOutlet UITextField *textfxwfxw;                       //发现违法行为"
@property (weak, nonatomic) IBOutlet UITextField *textjzwfxw;                        //纠正违法行为"
@property (weak, nonatomic) IBOutlet UITextField *textgasoline_amount;              //加油金额
@property (weak, nonatomic) IBOutlet UITextField *textcllmzaw;                      //处理路面障碍物"
@property (weak, nonatomic) IBOutlet UITextField *textbzgzc;                        //帮助故障车"
@property (weak, nonatomic) IBOutlet UITextField *textjcsgd;                        //检查施工点
@property (weak, nonatomic) IBOutlet UITextField *textcorrect_construct_behaviour;   //纠正违反公路施工安全作业规程行为（次）
@property (weak, nonatomic) IBOutlet UITextField *textqlxr;                         //劝离行人(人)
@property (weak, nonatomic) IBOutlet UITextField *textdissuade_person_times;             //劝离行人（次）
@property (weak, nonatomic) IBOutlet UITextField *textservice_area_check;           //服务区检查（次）
@property (weak, nonatomic) IBOutlet UITextField *texttissue_shunt;                 //组织分流（次）
@property (weak, nonatomic) IBOutlet UITextField *texttissue_outfire;                //组织灭火（次）
@property (weak, nonatomic) IBOutlet UITextField *texttissue_advertise;              //组织宣传（次）
@property (weak, nonatomic) IBOutlet UITextField *textlaw_enforcement_work;          //入口拒超和非现场执法工作（次）
@property (weak, nonatomic) IBOutlet UITextField *textdamage_road_asset_case;        //抓获、破获损坏路产案件（宗）
@property (weak, nonatomic) IBOutlet UITextField *textofficial_car_use;             //公务用车（公里）
@property (weak, nonatomic) IBOutlet UITextField *textgzzfj;                        //告知交通综合行政执法局处理案件
@property (weak, nonatomic) IBOutlet UITextField *textfcflws;                        //发出法律文书"
@property (weak, nonatomic) IBOutlet UITextField *textxcqxkj;                       //桥下空间监管（立方米/处）
@property (weak, nonatomic) IBOutlet UIScrollView *contentscrollview;

@property (nonatomic,retain) NSString * InspectionID;

- (IBAction)DeleteDataClick:(id)sender;
- (IBAction)BtnSaveDataClick:(id)sender;


@end
