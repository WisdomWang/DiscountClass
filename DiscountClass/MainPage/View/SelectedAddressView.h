//
//  SelectedAddressView.h
//  DiscountClass
//
//  Created by Cary on 2019/5/16.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectedAddressView : UIView

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong)NSMutableArray *addressArr;
@property (nonatomic,copy) void (^popBackBlock)(void);
@property (nonatomic,copy) void (^selectedBlock)(AddressListDetailModel *m);

@end

NS_ASSUME_NONNULL_END
