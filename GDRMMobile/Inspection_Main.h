//
//  Inspection_Main.h
//  GDRMPingXingMobile
//
//  Created by admin on 2019/7/1.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface Inspection_Main : NSManagedObject

@property (nonatomic,retain) NSString * myid;
@property (nonatomic,retain) NSString * inspection_id;  //关联id
@property (nonatomic,retain) NSDate  * date_inspection;  //  巡查日期
@property (nonatomic,retain) NSString * inspection_mile;      //本班巡查里程
@property (nonatomic,retain) NSString * inspection_man_num;  //当班参加巡查人次
@property (nonatomic,retain) NSString * accident_num;   //发生交通事故/其中涉及路产损害
@property (nonatomic,retain) NSString * deal_accident_num;  //处理路产损害赔偿
@property (nonatomic,retain) NSString * deal_bxlp_num;  //处理路产保险理赔案件
@property (nonatomic,retain) NSString * fxqx;       //发现报送道路、交安设施缺陷
@property (nonatomic,retain) NSString * fxwfxw;     //发现违法行为
@property (nonatomic,retain) NSString * jzwfxw;     //纠正违法行为

@property (nonatomic,retain) NSString * gasoline_amount;        //加油金额
@property (nonatomic,retain) NSString * cllmzaw;    //处理路面障碍物（处）
@property (nonatomic,retain) NSString * bzgzc;      //帮助故障车（次）
@property (nonatomic,retain) NSString * jcsgd;     //检查施工点（次）
@property (nonatomic,retain) NSString * correct_construct_behaviour;  //纠正违反公路施工安全作业规程行为（次）
@property (nonatomic,retain) NSString * qlxr;       //劝离行人(人)
@property (nonatomic,retain) NSString * dissuade_person_times;  //劝离行人（次）
@property (nonatomic,retain) NSString * service_area_check;  //服务区检查（次）
@property (nonatomic,retain) NSString * tissue_shunt;       //组织分流（次）
@property (nonatomic,retain) NSString * tissue_outfire;     //组织灭火（次）
@property (nonatomic,retain) NSString * tissue_advertise;   //组织宣传（次）
@property (nonatomic,retain) NSString * law_enforcement_work;   //入口拒超和非现场执法工作（次）
@property (nonatomic,retain) NSString * damage_road_asset_case; //抓获、破获损坏路产案件（宗）
@property (nonatomic,retain) NSString * official_car_use;   //公务用车（公里）

@property (nonatomic,retain) NSString * gzzfj;      //告知交通综合行政执法局处理案件
@property (nonatomic,retain) NSString * fcflws;     //发出法律文书
@property (nonatomic,retain) NSString * xcqxkj;     //桥下空间监管（立方米/处）

@property (nonatomic,retain) NSString * org_id;
@property (nonatomic, retain) NSNumber * isuploaded;
//@property (nonatomic,retain) NSString * inspection_principal_content;
//@property (nonatomic,retain) NSString * inspection_principal;
//@property (nonatomic,retain) NSDate  * inspection_principal_sign_date;
////路政负责人意见   负责人  签字日期
//@property (nonatomic,retain) NSString * reporter_content;
//@property (nonatomic,retain) NSString * reporter;
//@property (nonatomic,retain) NSDate  * reporter_sign_date;
////统计负责人意见   负责人  签字日期
//@property (nonatomic,retain) NSString * note;       //
//@property (nonatomic,retain) NSString * remark;     //
//@property (nonatomic,retain) NSString * hfzy;       //
//@property (nonatomic,retain) NSString * org_id;     //


+(Inspection_Main *)Inspection_MainForinspection_id:(NSString*)inspection_id;




@end
