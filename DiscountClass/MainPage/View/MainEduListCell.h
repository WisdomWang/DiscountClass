//
//  MainEduListCell.h
//  DiscountClass
//
//  Created by Cary on 2019/5/8.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainEduListCell : UITableViewCell

@property (nonatomic, strong) UICollectionView *cellCollectionView;
@property (nonatomic, strong) NSMutableArray *eduListArr;

@property (nonatomic,copy) void(^EduDetailBlcok)(NSIndexPath *indexPath);

@end

NS_ASSUME_NONNULL_END
