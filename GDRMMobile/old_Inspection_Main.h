//
//  Inspection_Main.h
//  GDRMPingXingMobile
//
//  Created by admin on 2019/3/28.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface old_Inspection_Main : NSManagedObject


//加油金额
@property (nonatomic,retain) NSNumber * gasoline_amount;
//纠正违反公路施工安全作业规程行为（次）
@property (nonatomic,retain) NSNumber * correct_construct_behaviour;
//劝离行人（次）
@property (nonatomic,retain) NSNumber * dissuade_person_times;
//服务区检查（次）
@property (nonatomic,retain) NSNumber * service_area_check;
//组织分流（次）
@property (nonatomic,retain) NSNumber * tissue_shunt;
//组织灭火（次）
@property (nonatomic,retain) NSNumber * tissue_outfire;
//组织宣传（次）
@property (nonatomic,retain) NSNumber * tissue_advertise;
//入口拒超和非现场执法工作（次）
@property (nonatomic,retain) NSNumber * law_enforecement_work;
//抓获、破坏h损坏路产案件（宗）
@property (nonatomic,retain) NSNumber * damage_road_asser_case;
//公务用车（公里）
@property (nonatomic,retain) NSNumber * official_car_use;

@end

NS_ASSUME_NONNULL_END
